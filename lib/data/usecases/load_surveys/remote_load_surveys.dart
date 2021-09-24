import '../../http/http.dart';

class RemoteLoadSurveys {
  HttpClient httpClient;
  String url;

  RemoteLoadSurveys({required this.httpClient, required this.url});

  Future<void> load() async {
    await httpClient.request(url: url, method: 'get');
  }
}
