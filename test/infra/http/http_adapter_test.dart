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
    return jsonDecode(response.body);
  }
}

void mockHttpPost(Client client, {bool? body}) => when(() => client.post(any(),
        headers: any(named: 'headers'),
        body: body == true ? any(named: 'body') : null))
    .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

class ClientSpy extends Mock implements Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late HttpAdapter sut;
  late Client client;
  late String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
    registerFallbackValue(FakeUri());
  });

  group('post', () {
    test('Should call post with correct values', () async {
      mockHttpPost(client, body: true);

      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});

      Uri uri = Uri.parse(url);

      verify(() => client.post(uri,
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
    });

    test('Should call post without body', () async {
      mockHttpPost(client);

      await sut.request(url: url, method: 'post');

      verify(() => client.post(any(), headers: any(named: 'headers')));
    });
  });

  test('Should return data if post returns 200', () async {
    mockHttpPost(client);

    final response = await sut.request(url: url, method: 'post');

    expect(response, {'any_key': 'any_value'});
  });
}
