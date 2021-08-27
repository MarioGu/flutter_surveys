import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const SizedBox(
        width: 200,
        child: Image(
          image: AssetImage('lib/ui/assets/logo.png'),
        ),
      ),
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}
