import 'package:test/test.dart';

import 'package:flutter_course/validation/validators/validators.dart';
import 'package:flutter_course/main/factories/pages/pages.dart';

void main() {
  test('Should return the correct values', () {
    final validations = makeSignUpValidations();

    expect(validations, [
      const RequiredFieldValidation('name'),
      const MinLengthValidation(field: 'name', size: 3),
      const RequiredFieldValidation('email'),
      const EmailValidation('email'),
      const RequiredFieldValidation('password'),
      const MinLengthValidation(field: 'password', size: 3),
      const RequiredFieldValidation('passwordConfirmation'),
      const CompareFieldsValidation(
          field: 'passwordConfirmation', fieldToCompare: 'password')
    ]);
  });
}
