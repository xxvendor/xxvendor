import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:xx_vendor/xx_util/http/resp.dart';

class HttpUtil {
  static Future<Resp> request(
      {required String url,
      RequestMethod requestMethod = RequestMethod.post,
      bool enableHttps = false,
      String? unEncodedPath,
      bool retry = false,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    late Uri uri;

    if (enableHttps) {
      uri = Uri.https(url, unEncodedPath ?? "", queryParameters);
    } else {
      uri = Uri.http(url, unEncodedPath ?? "", queryParameters);
    }

    late Client client;
    if (retry) {
      client = http.Client();
    } else {
      client = RetryClient(http.Client());
    }

    late Response response;
    late Resp resp;

    try {
      switch (requestMethod) {
        case RequestMethod.get:
          response = await get(uri: uri, headers: headers, client: client);
          break;
        case RequestMethod.post:
          response = await post(
              uri: uri,
              headers: headers,
              body: body,
              encoding: encoding,
              client: client);
          break;
        case RequestMethod.put:
          response = await put(
              uri: uri,
              headers: headers,
              body: body,
              encoding: encoding,
              client: client);
          break;
        case RequestMethod.delete:
          response = await delete(
              uri: uri,
              headers: headers,
              body: body,
              encoding: encoding,
              client: client);
          break;
      }
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      resp = Resp.fromJson(decodedResponse);
    } on ClientException catch (e) {
      resp = Resp(code: "-1", msg: e.message);
    } finally {
      client.close();
    }

    return resp;
  }

  static Future<Response> get({
    required Uri uri,
    Map<String, String>? headers,
    required Client client,
  }) async {
    return await client.get(uri, headers: headers);
  }

  static Future<Response> post({
    required Uri uri,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    required Client client,
  }) async {
    return await client.post(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }

  static Future<Response> put({
    required Uri uri,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    required Client client,
  }) async {
    return await client.put(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }

  static Future<Response> delete({
    required Uri uri,
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    required Client client,
  }) async {
    return await client.delete(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }
}

enum RequestMethod { get, post, put, delete }
