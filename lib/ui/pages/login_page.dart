import 'package:flutter/material.dart';

import '../components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const LoginHeader(),
              const Headline1(
                text: 'Login',
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(
                            Icons.email,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 32),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            icon: Icon(
                              Icons.lock,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                          obscureText: true,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: ElevatedButton(
                            onPressed: null, child: Text('Entrar')),
                      ),
                      TextButton.icon(
                          onPressed: () {},
                          label: const Text('Criar conta'),
                          icon: const Icon(Icons.person)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
