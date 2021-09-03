import 'package:flutter_course/validation/protocols/field_validation.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_course/presentation/protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  String? validate({required String field, required String value}) {
    return null;
  }
}

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {
  test('Should return null if all validations return null or empty', () {
    final validation1 = FieldValidationSpy();
    when(() => validation1.field).thenReturn('any_field');
    when(() => validation1.validate(any())).thenReturn(null);
    final validation2 = FieldValidationSpy();
    when(() => validation2.field).thenReturn('any_field');
    when(() => validation2.validate(any())).thenReturn(null);
    final sut = ValidationComposite([validation1, validation2]);

    var error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });
}
