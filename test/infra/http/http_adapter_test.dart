import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_course/data/http/http_client.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<Map> request({String? url, String? method, Map? body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    url ??= '';
    Uri uri = Uri.parse(url);
    final response = await client.post(uri, headers: headers, body: jsonBody);
    if (response.statusCode == 200) {
      return response.body.isEmpty ? {} : jsonDecode(response.body);
    } else {
      return {};
    }
  }
}

class ClientSpy extends Mock implements Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late HttpAdapter sut;
  late Client client;
  late String url;
  const Map anyMapBody = {'any_key': 'any_value'};
  const String anyStringBody = '{"any_key":"any_value"}';

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
    registerFallbackValue(FakeUri());
  });

  group('post', () {
    When<Future<Response>> mockRequest({bool? body = false}) =>
        when(() => client.post(any(),
            headers: any(named: 'headers'),
            body: body == true ? any(named: 'body') : null));

    void mockResponse(int statusCode,
        {bool? requestBody, String responseBody = anyStringBody}) {
      mockRequest(body: requestBody)
          .thenAnswer((_) async => Response(responseBody, statusCode));
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call post with correct values', () async {
      Uri uri = Uri.parse(url);

      mockResponse(200, requestBody: true);

      await sut.request(url: url, method: 'post', body: anyMapBody);

      verify(() => client.post(uri,
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: anyStringBody));
    });

    test('Should call post without body', () async {
      await sut.request(url: url, method: 'post');

      verify(() => client.post(any(), headers: any(named: 'headers')));
    });

    test('Should return data if post returns 200', () async {
      final response = await sut.request(url: url, method: 'post');

      expect(response, anyMapBody);
    });

    test('Should return empty Map if post returns 200 with no data', () async {
      mockResponse(200, responseBody: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, {});
    });

    test('Should return null if post returns 204', () async {
      mockResponse(204, responseBody: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, {});
    });

    test('Should return null if post returns 204 with data', () async {
      mockResponse(204, responseBody: anyStringBody);

      final response = await sut.request(url: url, method: 'post');

      expect(response, {});
    });
  });
}
