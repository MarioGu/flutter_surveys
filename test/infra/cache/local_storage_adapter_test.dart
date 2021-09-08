import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_course/infra/cache/local_storage_adapter.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  late String key;
  late String value;
  late FlutterSecureStorageSpy secureStorage;
  late LocalStorageAdapter sut;

  setUp(() {
    key = faker.lorem.word();
    value = faker.guid.guid();
    secureStorage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
  });

  group('saveSecure', () {
    When mockSaveSecureCall() {
      return when(() => secureStorage.write(
          key: any(named: 'key'), value: any(named: 'value')));
    }

    void mockSaveSecureSuccess() {
      mockSaveSecureCall().thenAnswer((_) async => null);
    }

    void mockSaveSecureError() {
      mockSaveSecureCall().thenThrow(Exception());
    }

    test('Should call save secure with correct values', () async {
      mockSaveSecureSuccess();

      await sut.saveSecure(key: key, value: value);

      verify(() => secureStorage.write(key: key, value: value));
    });

    test('Should throw if save secure throws', () async {
      mockSaveSecureError();

      final future = sut.saveSecure(key: key, value: value);

      expect(future, throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('fetchSecure', () {
    When mockFetchSecureCall() {
      return when(() => secureStorage.read(key: any(named: 'key')));
    }

    void mockFetchSecureSuccess({String? value}) {
      mockFetchSecureCall().thenAnswer((_) async => value);
    }

    test('Should call load secure with correct value', () async {
      mockFetchSecureSuccess();

      await sut.fetchSecure(key);

      verify(() => secureStorage.read(key: key));
    });

    test('Should return correct value in success', () async {
      mockFetchSecureSuccess(value: value);

      final featchedValue = await sut.fetchSecure(key);

      expect(featchedValue, value);
    });
  });
}
