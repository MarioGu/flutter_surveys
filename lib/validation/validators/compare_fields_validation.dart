import '../../presentation/protocols/validation.dart';
import '../../validation/protocols/protocols.dart';

class CompareFieldsValidation implements FieldValidation {
  @override
  final String field;
  final String valueToCompare;

  CompareFieldsValidation({required this.field, required this.valueToCompare});

  @override
  ValidationError? validate(String value) {
    if (value != valueToCompare) {
      return ValidationError.invalidField;
    }
    return null;
  }
}
