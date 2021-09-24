import 'package:faker/faker.dart';
import 'package:flutter_course/domain/entities/entities.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:flutter_course/data/usecases/load_surveys/load_surveys.dart';
import 'package:flutter_course/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient<List<Map>> {}

void main() {
  late HttpClientSpy httpClient;
  late RemoteLoadSurveys sut;
  late String url;
  late List<Map> list;

  When mockRequest() => when(() =>
      httpClient.request(url: any(named: 'url'), method: any(named: 'method')));

  List<Map> mockValidData() => [
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'didAnswer': faker.randomGenerator.boolean(),
          'date': faker.date.dateTime().toIso8601String(),
        },
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'didAnswer': faker.randomGenerator.boolean(),
          'date': faker.date.dateTime().toIso8601String(),
        }
      ];

  void mockHttpData(List<Map> data) {
    list = data;
    mockRequest().thenAnswer((_) async => data);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteLoadSurveys(httpClient: httpClient, url: url);
    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(() => httpClient.request(
          url: url,
          method: 'get',
        ));
  });

  test('Should return surveys on 200', () async {
    final surveys = await sut.load();

    expect(surveys, [
      SurveyEntity(
          id: list[0]["id"],
          question: list[0]["question"],
          dateTime: DateTime.parse(list[0]["date"]),
          didAnswer: list[0]["didAnswer"]),
      SurveyEntity(
          id: list[1]["id"],
          question: list[1]["question"],
          dateTime: DateTime.parse(list[1]["date"]),
          didAnswer: list[1]["didAnswer"]),
    ]);
  });
}
