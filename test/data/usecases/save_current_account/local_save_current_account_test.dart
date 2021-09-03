import 'package:faker/faker.dart';
import 'package:flutter_course/domain/helpers/helpers.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_course/domain/entities/entities.dart';
import 'package:flutter_course/domain/usecases/usecases.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  late SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentAccount({required this.saveSecureCacheStorage});

  @override
  Future<void> save(AccountEntity account) async {
    try {
      await saveSecureCacheStorage.saveSecure(
          key: 'token', value: account.token);
    } catch (error) {
      throw (DomainError.unexpected);
    }
  }
}

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({required String key, required String value});
}

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
