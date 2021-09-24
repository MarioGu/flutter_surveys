import '../../presentation/protocols/validation.dart';
import '../../validation/protocols/protocols.dart';

class CompareFieldsValidation implements FieldValidation {
  @override
  final String field;
  final String fieldToCompare;

  CompareFieldsValidation({required this.field, required this.fieldToCompare});

  @override
  ValidationError? validate(Map input) {
    if (input[field] != null &&
        input[fieldToCompare] != null &&
        input[field] != input[fieldToCompare]) {
      return ValidationError.invalidField;
    }
    return null;
  }
}
