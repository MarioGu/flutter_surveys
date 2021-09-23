import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../signup_presenter.dart';
import '../../../helpers/helpers.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<UIError?>(
        stream: presenter.nameErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: R.strings.name,
              icon: Icon(
                Icons.person,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            keyboardType: TextInputType.name,
            onChanged: presenter.validateName,
          );
        });
  }
}
