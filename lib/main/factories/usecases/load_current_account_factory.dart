import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../cache/cache.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() {
  final loadSecureCacheStorage = makeLocalStorageAdapter();
  return LocalLoadCurrentAccount(
      fetchSecureCacheStorage: loadSecureCacheStorage);
}
