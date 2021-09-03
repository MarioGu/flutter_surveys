import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_course/domain/entities/entities.dart';
import 'package:flutter_course/domain/helpers/helpers.dart';

import 'package:flutter_course/data/cache/save_secure_cache_storage.dart';
import 'package:flutter_course/data/usecases/save_current_account/local_save_current_account.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {
}

void main() {
  late SaveSecureCacheStorageSpy saveSecureCacheStorage;
  late LocalSaveCurrentAccount sut;
  late AccountEntity account;

  When mockSaveSecureCacheStorageCall() {
    return when(() => saveSecureCacheStorage.saveSecure(
        key: any(named: 'key'), value: any(named: 'value')));
  }

  void mockSaveSecureCacheStorage() {
    mockSaveSecureCacheStorageCall().thenAnswer((_) async => null);
  }

  void mockSaveSecureCacheStorageError() {
    mockSaveSecureCacheStorageCall().thenThrow(Exception());
  }

  setUp(() {
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    sut =
        LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    account = AccountEntity(faker.guid.toString());

    mockSaveSecureCacheStorage();
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    mockSaveSecureCacheStorage();

    sut.save(account);

    verify(() =>
        saveSecureCacheStorage.saveSecure(key: 'token', value: account.token));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws',
      () async {
    mockSaveSecureCacheStorageError();

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
