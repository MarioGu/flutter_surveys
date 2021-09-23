import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../signup_presenter.dart';
import '../../../helpers/helpers.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<UIError?>(
        stream: presenter.emailErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: R.strings.email,
              icon: Icon(
                Icons.email,
                color: Theme.of(context).primaryColorDark,
              ),
              errorText:
                  snapshot.data != null ? snapshot.data!.description : null,
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: presenter.validateEmail,
          );
        });
  }
}
