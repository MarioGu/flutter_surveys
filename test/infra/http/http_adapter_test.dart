import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request(
      {required Uri uri, required String method, Map? body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    await client.post(uri, headers: headers, body: jsonBody);
  }
}

void mockHttpPost(Client client, Uri uri, {Map? body}) =>
    when(() => client.post(uri,
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json'
            },
            body: body != null ? jsonEncode(body) : null))
        .thenAnswer((_) async => Response('', 200));

class ClientSpy extends Mock implements Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late HttpAdapter sut;
  late Client client;
  late Uri uri;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    uri = Uri.parse(faker.internet.httpUrl());
    registerFallbackValue(FakeUri());
  });

  group('post', () {
    test('Should call post with correct values', () async {
      mockHttpPost(client, uri, body: {'any_key': 'any_value'});

      await sut
          .request(uri: uri, method: 'post', body: {'any_key': 'any_value'});

      verify(() => client.post(uri,
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
    });

    test('Should call post without body', () async {
      mockHttpPost(client, uri);

      await sut.request(uri: uri, method: 'post');

      verify(() => client.post(any(), headers: any(named: 'headers')));
    });
  });
}
