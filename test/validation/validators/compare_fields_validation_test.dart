import 'package:test/test.dart';

import 'package:flutter_course/presentation/protocols/protocols.dart';
import 'package:flutter_course/validation/validators/validators.dart';

void main() {
  late CompareFieldsValidation sut;

  setUp(() {
    sut = CompareFieldsValidation(
        field: 'any_field', valueToCompare: 'any_value');
  });

  test('Should return error if value is different', () {
    expect(sut.validate('wrong_value'), ValidationError.invalidField);
  });
}
