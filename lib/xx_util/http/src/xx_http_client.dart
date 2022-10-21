import 'package:http/http.dart';

class XXHttpClient extends BaseClient {
  final Map<String, String>? commonHeaders;
  final Client client;

  XXHttpClient({required this.client, this.commonHeaders});

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.clear();
    request.headers.addAll(commonHeaders ?? {});
    return client.send(request);
  }
}
