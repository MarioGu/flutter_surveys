import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:flutter_course/domain/entities/entities.dart';

class LocalLoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  Future<void> load() async {
    await fetchSecureCacheStorage.fetchSecure('token');
  }
}

abstract class FetchSecureCacheStorage {
  Future<void>? fetchSecure(String key) {
    return null;
  }
}

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

void main() {
  test('Should call FetchSecureCacheStorage with correct value', () async {
    final fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    final sut = LocalLoadCurrentAccount(
        fetchSecureCacheStorage: fetchSecureCacheStorage);

    await sut.load();

    verify(() => fetchSecureCacheStorage.fetchSecure('token'));
  });
}
