import 'package:faker/faker.dart';
import 'package:flutter_course/domain/entities/account_entity.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:flutter_course/domain/usecases/load_current_account.dart';

import 'package:flutter_course/ui/pages/pages.dart';

class GetxSplashPresenter implements SplashPresenter {
  final _navigateTo = Rx<String?>(null);
  late LoadCurrentAccount loadCurrentAccount;

  GetxSplashPresenter({required this.loadCurrentAccount});

  @override
  Stream<String?> get navigateToStream => _navigateTo.stream;

  @override
  Future<void> checkAccount() async {
    try {
      final account = await loadCurrentAccount.load();
      _navigateTo.value = account == null ? '/login' : '/surveys';
    } catch (error) {
      _navigateTo.value = '/login';
    }
  }
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  late LoadCurrentAccountSpy loadCurrentAccount;
  late GetxSplashPresenter sut;

  When mockCheckAccountCall({AccountEntity? account}) {
    return when(loadCurrentAccount.load);
  }

  void mockCheckAccount({AccountEntity? account}) {
    mockCheckAccountCall(account: account).thenAnswer((_) async => account);
  }

  void mockCheckAccountError() {
    mockCheckAccountCall(account: AccountEntity(faker.guid.guid()))
        .thenThrow(Exception());
  }

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    mockCheckAccount(account: AccountEntity(faker.guid.guid()));
  });

  test('Should call LoadCUrrentAccount', () async {
    await sut.checkAccount();

    verify(loadCurrentAccount.load).called(1);
  });

  test('Should go to surveys page on success', () async {
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.checkAccount();
  });

  test('Should go to login page on null result', () async {
    mockCheckAccount();

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });

  test('Should go to login page on error', () async {
    mockCheckAccountError();

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });
}
