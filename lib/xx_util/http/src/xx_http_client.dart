import 'package:http/http.dart';

class XXHttpClient extends BaseClient {
  final Map<String, String>? headers;
  final Client client;

  XXHttpClient({required this.client, this.headers});

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    Map<String, String> requestHeaders = request.headers;
    Map<String, String> allHeaders = {};

    if (headers != null) {
      allHeaders.addAll(headers ?? {});
    }

    if (requestHeaders.isNotEmpty) {
      if (headers != null && headers!.isNotEmpty) {
        for (int i = 0; i < headers!.keys.length; i++) {
          String key = headers!.keys.toList()[i];
          if (!requestHeaders.containsKey(key)) {
            requestHeaders[key] = headers![key] ?? "";
          }
        }
      }

      allHeaders.clear();
      allHeaders.addAll(requestHeaders);
    }

    request.headers.addAll(allHeaders);
    return client.send(request);
  }
}
