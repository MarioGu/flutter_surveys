import 'package:flutter/material.dart';
import 'package:flutter_course/ui/helpers/errors/ui_error.dart';
import 'package:provider/provider.dart';

import '../../../helpers/errors/ui_error.dart';
import '../login_presenter.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<UIError?>(
        stream: presenter.passwordErrorStream,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 32),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha',
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
