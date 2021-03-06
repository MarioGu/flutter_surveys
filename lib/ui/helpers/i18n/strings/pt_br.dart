import 'translations.dart';

class PtBr implements Translations {
  @override
  String get addAccount => 'Criar conta';
  @override
  String get login => 'Login';
  @override
  String get email => 'Email';
  @override
  String get password => 'Senha';
  @override
  String get enter => 'Entrar';
  @override
  String get confirmPassword => 'Confirmar senha';
  @override
  String get name => 'Nome';
  @override
  String get wait => 'Aguarde...';

  @override
  String get msgInvalidCredentials => 'Credenciais inválidas.';
  @override
  String get msgInvalidField => 'Campo inválido';
  @override
  String get msgRequiredField => 'Campo obrigatório';
  @override
  String get msgEmailInUse => 'O email já está em uso.';
  @override
  String get msgSomethingHappend =>
      'Algo errado aconteceu. Tente novamente em breve.';
}
