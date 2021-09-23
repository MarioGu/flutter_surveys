import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 32),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: R.strings.password,
          icon: Icon(
            Icons.lock,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        obscureText: true,
      ),
    );
  }
}
