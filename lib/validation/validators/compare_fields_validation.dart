import 'package:equatable/equatable.dart';

import '../../presentation/protocols/validation.dart';
import '../../validation/protocols/protocols.dart';

class CompareFieldsValidation extends Equatable implements FieldValidation {
  @override
  final String field;
  final String fieldToCompare;

  @override
  List get props => [field];

  const CompareFieldsValidation(
      {required this.field, required this.fieldToCompare});

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
