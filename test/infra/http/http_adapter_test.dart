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
    await client.post(uri, headers: headers, body: jsonEncode(body));
  }
}

void mockHttpPost(Client client, Uri uri) => when(() => client.post(uri,
    headers: {'content-type': 'application/json', 'accept': 'application/json'},
    body: any(named: 'body'))).thenAnswer((_) async => Response('', 200));

class ClientSpy extends Mock implements Client {}

void main() {
  late HttpAdapter sut;
  late Client client;
  late Uri uri;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    uri = Uri.parse(faker.internet.httpUrl());

    mockHttpPost(client, uri);
  });

  group('post', () {
    test('Should call post with correct values', () async {
      await sut
          .request(uri: uri, method: 'post', body: {'any_key': 'any_value'});

      verify(() => client.post(uri,
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
    });
  });
}
