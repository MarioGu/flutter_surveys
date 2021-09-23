import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../signup_presenter.dart';
import '../../../helpers/helpers.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<bool>(
        stream: presenter.isFormValidStream,
        builder: (context, snapshot) {
          return ElevatedButton(
              onPressed: snapshot.data == true ? presenter.signup : null,
              child: Text(R.strings.addAccount.toUpperCase()));
        });
  }
}
