import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:flutter_course/presentation/protocols/protocols.dart';
import 'package:flutter_course/presentation/presenters/presenters.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  ValidationSpy validation = ValidationSpy();
  StreamLoginPresenter sut = StreamLoginPresenter(validation: validation);
  String email = faker.internet.email();

  When mockValidationCall(String? field) => when(() => validation.validate(
      field: field ?? any(named: 'field'), value: any(named: 'value')));

  void mockValidation({String? field, String? value}) {
    mockValidationCall(field).thenReturn(value);
  }

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(value: 'error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if validation succeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });
}
