import 'package:equatable/equatable.dart';

import '../../presentation/protocols/protocols.dart';
import '../../validation/protocols/protocols.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  @override
  final String field;
  final int size;

  const MinLengthValidation({required this.field, required this.size});

  @override
  List get props => [field];

  @override
  ValidationError? validate(String? value) {
    if (value != null && value.length >= size) {
      return null;
    }
    return ValidationError.invalidField;
  }
}
