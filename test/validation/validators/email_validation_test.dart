import 'package:test/test.dart';

import 'package:flutter_course/validation/protocols/field_validation.dart';

class EmailValidation implements FieldValidation {
  @override
  final String field;

  EmailValidation(this.field);

  @override
  String? validate(String? value) {
    return null;
  }
}

void main() {
  test('Should return null if email is empty', () {
    final sut = EmailValidation('any_field');

    final error = sut.validate('');

    expect(error, null);
  });

  test('Should return null if email is null', () {
    final sut = EmailValidation('any_field');

    final error = sut.validate(null);

    expect(error, null);
  });
}
