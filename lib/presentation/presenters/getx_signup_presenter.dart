import 'package:get/get.dart';

import '../../ui/helpers/errors/errors.dart';

import '../protocols/protocols.dart';

class GetxSignUpPresenter {
  final Validation validation;

  final _emailError = Rx<UIError?>(null);
  final _isFormValid = false.obs;

  @override
  Stream<UIError?> get emailErrorStream => _emailError.stream;
  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;

  GetxSignUpPresenter({required this.validation});

  @override
  void validateEmail(String email) {
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  UIError? _validateField({required String field, required String value}) {
    final error = validation.validate(field: field, value: value);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  void _validateForm() {
    _isFormValid.value = false;
  }
}
