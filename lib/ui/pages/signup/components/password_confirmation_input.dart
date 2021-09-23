import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

class PasswordConfirmationInput extends StatelessWidget {
  const PasswordConfirmationInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: R.strings.confirmPassword,
        icon: Icon(
          Icons.person,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      keyboardType: TextInputType.name,
    );
  }
}
