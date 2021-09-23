import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: R.strings.name,
        icon: Icon(
          Icons.person,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      keyboardType: TextInputType.name,
    );
  }
}
