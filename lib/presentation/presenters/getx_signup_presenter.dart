import 'package:get/get.dart';

import '../../ui/helpers/errors/errors.dart';

import '../protocols/protocols.dart';

class GetxSignUpPresenter {
  final Validation validation;

  final _emailError = Rx<UIError?>(null);
  final _nameError = Rx<UIError?>(null);
  final _passwordError = Rx<UIError?>(null);
  final _passwordConfirmationError = Rx<UIError?>(null);
  final _isFormValid = false.obs;

  String? _name;
  String? _email;
  String? _password;
  String? _passwordConfirmation;

  @override
  Stream<UIError?> get emailErrorStream => _emailError.stream;
  @override
  Stream<UIError?> get nameErrorStream => _nameError.stream;
  @override
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;
  @override
  Stream<UIError?> get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream;
  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;

  GetxSignUpPresenter({required this.validation});

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  @override
  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField(field: 'name', value: name);
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

  @override
  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField(
        field: 'passwordConfirmation', value: passwordConfirmation);
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
    _isFormValid.value = _nameError.value == null &&
        _emailError.value == null &&
        _passwordError.value == null &&
        _passwordConfirmationError.value == null &&
        _name != null &&
        _email != null &&
        _password != null &&
        _passwordConfirmation != null;
  }
}
