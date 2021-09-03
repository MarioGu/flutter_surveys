import 'package:faker/faker.dart';
import 'package:flutter_course/infra/cache/local_storage_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageSpy extends Mock implements FlutterSecureStorage {}

void main() {
  late String key;
  late String value;
  late FlutterSecureStorageSpy secureStorage;
  late LocalStorageAdapter sut;

  When mockSecureStorageCall() {
    return when(() => secureStorage.write(
        key: any(named: 'key'), value: any(named: 'value')));
  }

  void mockSecureStorageSuccess() {
    mockSecureStorageCall().thenAnswer((_) async => null);
  }

  void mockSecureStorageError() {
    mockSecureStorageCall().thenThrow(Exception());
  }

  setUp(() {
    key = faker.lorem.word();
    value = faker.guid.guid();
    secureStorage = FlutterSecureStorageSpy();
    sut = LocalStorageAdapter(secureStorage: secureStorage);
  });

  test('Should call save secure with correct values', () async {
    mockSecureStorageSuccess();

    await sut.saveSecure(key: key, value: value);

    verify(() => secureStorage.write(key: key, value: value));
  });

  test('Should throw if save secure throws', () async {
    mockSecureStorageError();

    final future = sut.saveSecure(key: key, value: value);

    expect(future, throwsA(const TypeMatcher<Exception>()));
  });
}
