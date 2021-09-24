import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../usecases/usecases.dart';
import '../../factories.dart';

SignUpPresenter makeGetxSignUpPresenter() {
  return GetxSignUpPresenter(
      validation: makeSignUpValidation(),
      addAccount: makeRemoteAddAccount(),
      saveCurrentAccount: makeLocalSaveCurrentAccount());
}
