import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';

import '../../models/remote_survey_model.dart';
import '../../http/http.dart';

class RemoteLoadSurveys {
  HttpClient<List<Map>> httpClient;
  String url;

  RemoteLoadSurveys({required this.httpClient, required this.url});

  Future<List<SurveyEntity>> load() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');
      return httpResponse
          .map((json) => RemoteSurveyModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
