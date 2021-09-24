import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../signup_presenter.dart';
import '../../../helpers/helpers.dart';

class PasswordConfirmationInput extends StatelessWidget {
  const PasswordConfirmationInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<UIError?>(
        stream: presenter.passwordConfirmationErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: R.strings.confirmPassword,
              icon: Icon(
                Icons.lock,
                color: Theme.of(context).primaryColorDark,
              ),
              errorText:
                  snapshot.data != null ? snapshot.data!.description : null,
            ),
            obscureText: true,
            onChanged: presenter.validatePasswordConfirmation,
          );
        });
  }
}
