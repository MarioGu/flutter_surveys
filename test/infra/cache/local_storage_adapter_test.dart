import 'package:faker/faker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:flutter_course/data/cache/cache.dart';

class LocalStorageAdapter implements SaveSecureCacheStorage {
  FlutterSecureStorage secureStorage;

  LocalStorageAdapter({required this.secureStorage});

  @override
  Future<void> saveSecure({required String key, required String value}) async {
    secureStorage.write(key: key, value: value);
  }
}

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

    when(() => secureStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'))).thenAnswer((_) async => null);
  });

  test('Should call save secure with correct values', () async {
    await sut.saveSecure(key: key, value: value);

    verify(() => secureStorage.write(key: key, value: value));
  });
}
