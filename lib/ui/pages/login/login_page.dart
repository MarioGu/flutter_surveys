import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import '../pages.dart';
import './components/components.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (builderContext) {
          widget.presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          widget.presenter.mainErrorStream.listen((error) {
            showErrorMessage(context, error);
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
                    child: Provider(
                      create: (_) => widget.presenter,
                      child: Form(
                        child: Column(
                          children: [
                            const EmailInput(),
                            const PasswordInput(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: StreamBuilder<bool>(
                                  stream: widget.presenter.isFormValidStream,
                                  builder: (context, snapshot) {
                                    return ElevatedButton(
                                        onPressed: snapshot.data == true
                                            ? widget.presenter.auth
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
