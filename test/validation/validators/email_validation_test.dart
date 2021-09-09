import 'package:test/test.dart';

import 'package:flutter_course/presentation/protocols/protocols.dart';
import 'package:flutter_course/validation/validators/validators.dart';

void main() {
  late EmailValidation sut;

  setUp(() {
    sut = const EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate('email@valido.com'), null);
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate('email_invalido'), ValidationError.requiredField);
  });
}
