import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../signup_presenter.dart';
import '../../../helpers/helpers.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<UIError?>(
        stream: presenter.passwordErrorStream,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 32),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: R.strings.password,
                icon: Icon(
                  Icons.lock,
                  color: Theme.of(context).primaryColorDark,
                ),
                errorText:
                    snapshot.data != null ? snapshot.data!.description : null,
              ),
              obscureText: true,
              onChanged: presenter.validatePassword,
            ),
          );
        });
  }
}
