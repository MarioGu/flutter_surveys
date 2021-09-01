import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../pages.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (builderContext) {
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return SimpleDialog(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Aguarde...',
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      ],
                    );
                  });
            } else {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            }
          });

          return SafeArea(
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
                          StreamBuilder<String>(
                              stream: presenter.emailErrorStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    icon: Icon(
                                      Icons.email,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    errorText: snapshot.data?.isEmpty == true
                                        ? null
                                        : snapshot.data,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: presenter.validateEmail,
                                );
                              }),
                          StreamBuilder<String>(
                              stream: presenter.passwordErrorStream,
                              builder: (context, snapshot) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 32),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Senha',
                                      icon: Icon(
                                        Icons.lock,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      errorText: snapshot.data?.isEmpty == true
                                          ? null
                                          : snapshot.data,
                                    ),
                                    obscureText: true,
                                    onChanged: presenter.validatePassword,
                                  ),
                                );
                              }),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: StreamBuilder<bool>(
                                stream: presenter.isFormValidStream,
                                builder: (context, snapshot) {
                                  return ElevatedButton(
                                      onPressed: snapshot.data == true
                                          ? presenter.auth
                                          : null,
                                      child: Text('Entrar'.toUpperCase()));
                                }),
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
          );
        },
      ),
    );
  }
}
