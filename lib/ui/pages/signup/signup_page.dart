import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import './components/components.dart';
import 'signup_presenter.dart';

class SignUpPage extends StatelessWidget {
  final SignUpPresenter presenter;

  const SignUpPage(this.presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _hideKeyboard() {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (builderContext) {
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          return SafeArea(
            child: GestureDetector(
              onTap: _hideKeyboard,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const LoginHeader(),
                    Headline1(
                      text: R.strings.addAccount,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Provider(
                        create: (_) => presenter,
                        child: Form(
                          child: Column(
                            children: [
                              const NameInput(),
                              const EmailInput(),
                              const PasswordInput(),
                              const PasswordConfirmationInput(),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 16),
                                child: SignUpButton(),
                              ),
                              TextButton.icon(
                                  onPressed: () {},
                                  label: Text(R.strings.login),
                                  icon: const Icon(Icons.exit_to_app)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
