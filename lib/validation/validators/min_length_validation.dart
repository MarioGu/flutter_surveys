import '../../presentation/protocols/protocols.dart';
import '../../validation/protocols/protocols.dart';

class MinLengthValidation implements FieldValidation {
  @override
  final String field;
  final int size;

  MinLengthValidation({required this.field, required this.size});

  @override
  ValidationError? validate(String? value) {
    if (value != null && value.length >= size) {
      return null;
    }
    return ValidationError.invalidField;
  }
}
