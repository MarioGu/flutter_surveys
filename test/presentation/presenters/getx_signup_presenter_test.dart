import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:flutter_course/domain/entities/entities.dart';
import 'package:flutter_course/domain/helpers/helpers.dart';
import 'package:flutter_course/domain/usecases/usecases.dart';

import 'package:flutter_course/ui/helpers/errors/ui_error.dart';

import 'package:flutter_course/presentation/presenters/presenters.dart';
import 'package:flutter_course/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

class AddAccountSpy extends Mock implements AddAccount {}

class FakeAddAccountParams extends Mock implements AddAccountParams {}

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {}

class FakeAccountEntity extends Mock implements AccountEntity {}

void main() {
  late GetxSignUpPresenter sut;
  late ValidationSpy validation;
  late AddAccountSpy addAccount;
  late SaveCurrentAccount saveCurrentAccount;
  late String email;
  late String name;
  late String password;
  late String passwordConfirmation;
  late String token;

  When mockValidationCall(String? field) => when(() => validation.validate(
      field: field ?? any(named: 'field'), value: any(named: 'value')));

  void mockValidation({String? field, ValidationError? value}) {
    mockValidationCall(field).thenReturn(value);
  }

  When mockAddAccountCall() => when(() => addAccount.add(any()));

  void mockAddAccount() {
    mockAddAccountCall().thenAnswer((_) async => AccountEntity(token));
  }

  void mockAddAccountError(DomainError error) {
    mockAddAccountCall().thenThrow(error);
  }

  When mockSaveCurrentAccountCall() =>
      when(() => saveCurrentAccount.save(any()));

  void mockSaveCurrentAccount() {
    mockSaveCurrentAccountCall().thenAnswer((_) async => AccountEntity(token));
  }

  void mockSaveCurrentAccountError() {
    mockSaveCurrentAccountCall().thenThrow(DomainError.unexpected);
  }

  setUp(() {
    validation = ValidationSpy();
    addAccount = AddAccountSpy();
    saveCurrentAccount = SaveCurrentAccountSpy();
    sut = GetxSignUpPresenter(
      validation: validation,
      addAccount: addAccount,
      saveCurrentAccount: saveCurrentAccount,
    );
    email = faker.internet.email();
    name = faker.person.name();
    password = faker.internet.password();
    passwordConfirmation = faker.internet.password();
    token = faker.guid.guid();
    registerFallbackValue(FakeAddAccountParams());
    registerFallbackValue(FakeAccountEntity());
    mockAddAccount();
    mockSaveCurrentAccount();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit invalid field error if email is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit invalid field error if email is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if email validation succeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call Validation with correct name', () {
    sut.validateName(name);

    verify(() => validation.validate(field: 'name', value: name)).called(1);
  });

  test('Should emit invalid field error if name is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.nameErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should emit invalid field error if name is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.nameErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should emit null if name validation succeds', () {
    sut.nameErrorStream.listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should call Validation with correct password', () {
    sut.validatePassword(password);

    verify(() => validation.validate(field: 'password', value: password))
        .called(1);
  });

  test('Should emit invalid field error if password is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit invalid field error if password is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit null if password validation succeds', () {
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should call Validation with correct passwordConfirmation', () {
    sut.validatePasswordConfirmation(passwordConfirmation);

    verify(() => validation.validate(
        field: 'passwordConfirmation', value: passwordConfirmation)).called(1);
  });

  test('Should emit invalid field error if passwordConfirmation is invalid',
      () {
    mockValidation(value: ValidationError.invalidField);

    sut.passwordConfirmationErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should emit invalid field error if passwordConfirmation is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.passwordConfirmationErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should emit null if passwordConfirmation validation succeds', () {
    sut.passwordConfirmationErrorStream
        .listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should enable form button if all fields are valid', () async {
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateName(name);
    await Future.delayed(Duration.zero);
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
    await Future.delayed(Duration.zero);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should call AddAccount with correct values', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    await sut.signUp();

    verify(() => addAccount.add(AddAccountParams(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation))).called(1);
  });

  test('Should call SaveCurrentAccount with correct value', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    await sut.signUp();

    verify(() => saveCurrentAccount.save(AccountEntity(token))).called(1);
  });

  test('Should emit UnexpectedError if SaveCurrentAccount fails', () async {
    mockSaveCurrentAccountError();

    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    sut.mainErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.unexpected)));

    await sut.signUp();
  });

  test('Should emit correct events on AddAccount success', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    expectLater(sut.isLoadingStream, emits(true));

    await sut.signUp();
  });

  test('Should emit correct events on EmailInUseError', () async {
    mockAddAccountError(DomainError.emailInUse);

    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.emailInUse)));

    await sut.signUp();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockAddAccountError(DomainError.unexpected);

    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.mainErrorStream
        .listen(expectAsync1((error) => expect(error, UIError.unexpected)));

    await sut.signUp();
  });

  test('Should change page on success', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.signUp();
  });

  test('Should go to LoginPage on link click', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));
    sut.goToLogin();
  });
}
