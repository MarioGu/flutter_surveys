import 'translations.dart';

class EnUs implements Translations {
  @override
  String get addAccount => 'Add account';
  @override
  String get login => 'Login';
  @override
  String get email => 'Email';
  @override
  String get password => 'Password';
  @override
  String get enter => 'Enter';
  @override
  String get confirmPassword => 'Confirma password';
  @override
  String get name => 'Name';
  @override
  String get wait => 'Wait...';

  @override
  String get msgInvalidCredentials => 'Invalid credentials.';
  @override
  String get msgInvalidField => 'Invalid field';
  @override
  String get msgRequiredField => 'RequiredField';
  @override
  String get msgEmailInUse => 'Email in use';
  @override
  String get msgSomethingHappend =>
      'An unkown error has occurred. Try again later.';
}
