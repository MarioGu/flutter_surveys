import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:flutter_course/domain/helpers/helpers.dart';
import 'package:flutter_course/domain/usecases/usecases.dart';

import 'package:flutter_course/data/usecases/usecases.dart';
import 'package:flutter_course/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAddAccount sut;
  late HttpClientSpy httpClient;
  late String url;
  late AddAccountParams params;

  When mockRequest() => when(() => httpClient.request(
      url: any(named: 'url'),
      method: any(named: 'method'),
      body: any(named: 'body')));

  void mockData(Map data) {
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  Map mockValidData() =>
      {'accessToken': faker.guid.guid(), 'name': faker.person.name()};

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAddAccount(
      httpClient: httpClient,
      url: url,
    );
    params = AddAccountParams(
        email: faker.internet.email(),
        password: faker.internet.password(),
        name: faker.person.name(),
        passwordConfirmation: faker.person.name());
    mockData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.add(params);

    verify(() => httpClient.request(url: url, method: 'post', body: {
          'name': params.name,
          'email': params.email,
          'password': params.password,
          'passwordConfirmation': params.passwordConfirmation
        }));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
