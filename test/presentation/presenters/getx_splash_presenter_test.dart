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
    await loadCurrentAccount.load();
  }
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  late LoadCurrentAccountSpy loadCurrentAccount;
  late GetxSplashPresenter sut;

  When mockCheckAccountCall(LoadCurrentAccount loadCurrentAccount) {
    return when(loadCurrentAccount.load);
  }

  void mockCheckAccount(LoadCurrentAccount loadCurrentAccount) {
    mockCheckAccountCall(loadCurrentAccount).thenAnswer((_) async => null);
  }

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    mockCheckAccount(loadCurrentAccount);
  });

  test('Should call LoadCUrrentAccount', () async {
    await sut.checkAccount();

    verify(loadCurrentAccount.load).called(1);
  });
}
