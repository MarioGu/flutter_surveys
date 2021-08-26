import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request({required Uri uri, required String method}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    await client.post(uri, headers: headers);
  }
}

void mockHttpPost(Client client, Uri uri) =>
    when(() => client.post(uri, headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        })).thenAnswer((_) async => Response('', 200));

class ClientSpy extends Mock implements Client {}

void main() {
  group('post', () {
    test('Should call post with correct values', () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final uri = Uri.parse(faker.internet.httpUrl());

      mockHttpPost(client, uri);

      await sut.request(uri: uri, method: 'post');

      verify(() => client.post(uri, headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          }));
    });
  });
}
