import 'package:http/http.dart';

class XXHttpClient extends BaseClient {
  final Map<String, String>? headers;
  final Client client;

  XXHttpClient({required this.client, this.headers});

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    Map<String, String>? allHeaders = request.headers;
    request.headers.clear();
    allHeaders.addAll(headers ?? {});
    request.headers.addAll(allHeaders);
    return client.send(request);
  }
}
