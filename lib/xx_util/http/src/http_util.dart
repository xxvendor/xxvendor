import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:retry/retry.dart';
import 'package:xx_vendor/model/media/xx_media.dart';
import 'package:xx_vendor/xx_util/http/http.dart';
import 'package:xx_vendor/xx_util/log/log_util.dart';

typedef UploadProgressCallback = void Function(
    int bytesUploaded, int bytesTotal);
typedef DownloadProgressCallback = void Function(
    int bytesDownloaded, int bytesTotal);
typedef DownloadSuccessCallback = void Function(File? file);

class HttpUtil {
  static XXHttpClient? xxHttpClient;
  static const Duration timeOutDuration = Duration(seconds: 30);
  static const int multipartChunkSize = 64 * 1024;

  static Future<Resp> request({
    required String url,
    RequestMethod requestMethod = RequestMethod.post,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Object? body,
    Map<String, String>? formDataBody,
    bool needRetry = false,
    int maxAttempts = 0,
    Encoding encoding = const Utf8Codec(),
    FutureOr<bool> Function(Exception)? retryIf,
    FutureOr<void> Function(Exception)? onRetry,
  }) async {
    generateXXClient();

    late Resp resp;
    try {
      Response response = needRetry
          ? await retry(
              () => httpRequest(
                  url: url,
                  requestMethod: requestMethod,
                  queryParameters: queryParameters,
                  headers: headers,
                  body: body,
                  formDataBody: formDataBody,
                  encoding: encoding),
              maxAttempts: maxAttempts,
              retryIf: retryIf,
              onRetry: onRetry)
          : await httpRequest(
              url: url,
              requestMethod: requestMethod,
              queryParameters: queryParameters,
              headers: headers,
              body: body,
              formDataBody: formDataBody,
              encoding: encoding);
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      resp = Resp.fromJson(decodedResponse);
    } catch (e) {
      resp = Resp(code: "-1", msg: e.toString());
    } finally {
      xxHttpClient!.close();
    }

    return resp;
  }

  static Future<Response> httpRequest({
    required String url,
    RequestMethod requestMethod = RequestMethod.post,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Object? body,
    Map<String, String>? formDataBody,
    Encoding? encoding,
  }) async {
    Uri uri = generateUri(url: url, queryParameters: queryParameters);

    late Response response;

    if (formDataBody == null) {
      switch (requestMethod) {
        case RequestMethod.get:
          response = await get(uri: uri, headers: headers);
          break;
        case RequestMethod.post:
          response = await post(
            uri: uri,
            headers: headers,
            body: body,
            encoding: encoding,
          );
          break;
        case RequestMethod.put:
          response = await put(
            uri: uri,
            headers: headers,
            body: body,
            encoding: encoding,
          );
          break;
        case RequestMethod.delete:
          response = await delete(
            uri: uri,
            headers: headers,
            body: body,
            encoding: encoding,
          );
          break;
      }
    } else {
      response = await formDataRequest(
        uri: uri,
        headers: headers,
        formDataBody: formDataBody,
      );
    }

    try {
      LogUtils.i("--------------------------------------------------"
          "\n${"request url:$url"}"
          "\n${"requestMethod:${response.request?.method}"}"
          "\n${"queryParameters:$queryParameters"}"
          "\n${"headers:${response.request?.headers}"}"
          "\n${"body:$body"}"
          "\n${"formDataBody:$formDataBody"}"
          "\n${"response code:${response.statusCode}"}"
          "\n${"response body:${jsonDecode(utf8.decode(response.bodyBytes))}"}"
          "\n${"--------------------------------------------------"}");
    } catch (e) {
      LogUtils.e("--------------------------------------------------"
          "\n${"request url:$url"}"
          "\n${"requestMethod:${response.request?.method}"}"
          "\n${"queryParameters:$queryParameters"}"
          "\n${"headers:${response.request?.headers}"}"
          "\n${"body:$body"}"
          "\n${"formDataBody:$formDataBody"}"
          "\n${"response code:${response.statusCode}"}"
          "\n${"response body:${response.body}"}"
          "\n${"--------------------------------------------------"}");
    }

    return response;
  }

  static Future<Response> get({
    required Uri uri,
    Map<String, String>? headers,
  }) async {
    return await xxHttpClient!
        .get(uri, headers: headers)
        .timeout(timeOutDuration);
  }

  static Future<Response> post({
    required Uri uri,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    return await xxHttpClient!
        .post(
          uri,
          headers: headers,
          body: body,
          encoding: encoding,
        )
        .timeout(timeOutDuration);
  }

  static Future<Response> put({
    required Uri uri,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    return await xxHttpClient!
        .put(
          uri,
          headers: headers,
          body: body,
          encoding: encoding,
        )
        .timeout(timeOutDuration);
  }

  static Future<Response> delete({
    required Uri uri,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    return await xxHttpClient!
        .delete(
          uri,
          headers: headers,
          body: body,
          encoding: encoding,
        )
        .timeout(timeOutDuration);
  }

  static Future<Response> formDataRequest({
    required Uri uri,
    Map<String, String>? headers,
    RequestMethod requestMethod = RequestMethod.post,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? formDataBody,
  }) async {
    generateXXClient();
    var multipartRequest = http.MultipartRequest(requestMethod.type, uri);
    if (headers != null) {
      multipartRequest.headers.clear();
      multipartRequest.headers.addAll(headers);
    }

    multipartRequest.fields.clear();
    multipartRequest.fields.addAll(formDataBody ?? {});

    late Response response;

    response = await http.Response.fromStream(
        await xxHttpClient!.send(multipartRequest));

    return response;
  }

  static Future<Resp> uploadSingleFile(
      {required String url,
      Map<String, String>? headers,
      RequestMethod requestMethod = RequestMethod.post,
      Map<String, dynamic>? queryParameters,
      UploadProgressCallback? onUploadProgress,
      required String field,
      required XXMedia file}) async {
    late Resp resp;
    generateXXClient();
    Uri uri = generateUri(url: url, queryParameters: queryParameters);
    var multipartRequest = http.MultipartRequest(requestMethod.type, uri);

    if (headers != null) {
      multipartRequest.headers.clear();
      multipartRequest.headers.addAll(headers);
    }

    multipartRequest.files.clear();
    multipartRequest.files.add(MultipartFile(
        field,
        File(file.mediaPath).readAsBytes().asStream(),
        File(file.mediaPath).lengthSync(),
        filename: file.mediaName.split("/").last));

    http.BaseRequest requestToSend;
    if (onUploadProgress != null) {
      final chunkedByteStream = chunkStream(
        multipartRequest.finalize(),
        chunkLength: multipartChunkSize,
      );

      var bytesUploaded = 0;
      final bytesTotal = multipartRequest.contentLength;
      final observedByteStream = chunkedByteStream
          .transform(StreamTransformer<List<int>, List<int>>.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);
          bytesUploaded += data.length;
          onUploadProgress(bytesUploaded, bytesTotal);
        },
        handleError: (error, stackTrace, sink) =>
            throw AsyncError(error, stackTrace),
        handleDone: (sink) => sink.close(),
      ));

      requestToSend =
          StreamWrappingRequest(requestMethod.type, uri, observedByteStream)
            ..contentLength = multipartRequest.contentLength
            ..headers.addAll(multipartRequest.headers);
    } else {
      requestToSend = multipartRequest;
    }

    late Response response;
    try {
      response = await http.Response.fromStream(
          await xxHttpClient!.send(requestToSend));
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      resp = Resp.fromJson(decodedResponse);
    } catch (e) {
      resp = Resp(code: "-1", msg: e.toString());
    } finally {
      xxHttpClient!.close();
    }

    return resp;
  }

  ///upload
  static Future<Resp> uploadMultiFile(
      {required String url,
      Map<String, String>? headers,
      RequestMethod requestMethod = RequestMethod.post,
      Map<String, dynamic>? queryParameters,
      UploadProgressCallback? onUploadProgress,
      Map<String, String>? fields,
      required String fileField,
      required List<XXMedia> files}) async {
    late Resp resp;
    generateXXClient();
    Uri uri = generateUri(url: url, queryParameters: queryParameters);
    var multipartRequest = http.MultipartRequest(requestMethod.type, uri);
    if (headers != null) {
      multipartRequest.headers.clear();
      multipartRequest.headers.addAll(headers);
    }

    multipartRequest.files.clear();
    multipartRequest.files.addAll(files.map((e) => MultipartFile(
        fileField,
        File(e.mediaPath).readAsBytes().asStream(),
        File(e.mediaPath).lengthSync(),
        filename: e.mediaName.split("/").last)));

    multipartRequest.fields.clear();
    multipartRequest.fields.addAll(fields ?? {});

    http.BaseRequest requestToSend;
    if (onUploadProgress != null) {
      final chunkedByteStream = chunkStream(
        multipartRequest.finalize(),
        chunkLength: multipartChunkSize,
      );

      var bytesUploaded = 0;
      final bytesTotal = multipartRequest.contentLength;
      final observedByteStream = chunkedByteStream
          .transform(StreamTransformer<List<int>, List<int>>.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);
          bytesUploaded += data.length;
          onUploadProgress(bytesUploaded, bytesTotal);
        },
        handleError: (error, stackTrace, sink) =>
            throw AsyncError(error, stackTrace),
        handleDone: (sink) => sink.close(),
      ));

      requestToSend =
          StreamWrappingRequest(requestMethod.type, uri, observedByteStream)
            ..contentLength = multipartRequest.contentLength
            ..headers.addAll(multipartRequest.headers);
    } else {
      requestToSend = multipartRequest;
    }

    late Response response;
    try {
      response = await http.Response.fromStream(
          await xxHttpClient!.send(requestToSend));
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      resp = Resp.fromJson(decodedResponse);
    } catch (e) {
      resp = Resp(code: "-1", msg: e.toString());
    } finally {
      xxHttpClient!.close();
    }

    return resp;
  }

  ///download
  static Future downloadFile(
      {required String url,
      Map<String, String>? headers,
      RequestMethod requestMethod = RequestMethod.get,
      required String savePath,
      required DownloadProgressCallback downloadProgressCallback,
      required DownloadSuccessCallback downloadSuccessCallback}) async {
    generateXXClient();

    File? file;
    late Uri uri;

    uri = Uri.parse(url);

    try {
      if (kDebugMode) {
        print("开始下载任务");
      }
      late BaseRequest downloadRequest;

      downloadRequest = http.Request(requestMethod.type, uri);
      downloadRequest.headers.clear();
      downloadRequest.headers.addAll(headers ?? {});

      http.StreamedResponse response =
          await xxHttpClient!.send(downloadRequest);

      int total = response.contentLength ?? 0;
      int received = 0;

      final List<int> bytes = [];
      response.stream.listen((value) {
        bytes.addAll(value);
        received += value.length;
        downloadProgressCallback(received, total);
      }).onDone(() async {
        if (kDebugMode) {
          print("下载任务完成,准备重命名");
        }
        File tempFile = File("$savePath.temp");
        await tempFile.writeAsBytes(bytes);
        file = tempFile.renameSync(savePath);
        if (kDebugMode) {
          print("重命名完成，文件下载成功,存储路径为:$savePath");
        }
        downloadSuccessCallback(file);
      });
    } catch (e) {
      if (kDebugMode) {
        print("下载任务异常$e");
      }
    } finally {
      xxHttpClient!.close();
    }
  }

  static setHeaders({required Map<String, String> headers}) {
    if (xxHttpClient != null) {
      xxHttpClient =
          XXHttpClient(client: xxHttpClient!.client, headers: headers);
    } else {
      xxHttpClient = XXHttpClient(client: http.Client(), headers: headers);
    }
  }

  static generateXXClient() {
    xxHttpClient ??= XXHttpClient(client: http.Client());
  }
}

enum RequestMethod {
  get(type: "GET"),
  post(type: "POST"),
  put(type: "PUT"),
  delete(type: "DELETE");

  final String type;

  const RequestMethod({required this.type});
}

Uri generateUri({required String url, Map<String, dynamic>? queryParameters}) {
  late Uri uri;
  String tempUrl = "";
  if (queryParameters != null) {
    tempUrl = "$url?${generateQueryString(queryParameters)}";
  } else {
    tempUrl = url;
  }

  uri = Uri.parse(tempUrl);
  return uri;
}

String generateQueryString(Map<String, dynamic> queryParameters) {
  return queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&');
}
