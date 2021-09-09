import 'package:flutter/material.dart';
import 'package:flutter_course/utils/i18n/resources.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import '../../helpers/errors/errors.dart';
import '../pages.dart';
import './components/components.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter, {Key? key}) : super(key: key);

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

          presenter.mainErrorStream.listen((error) {
            if (error != null) {
              showErrorMessage(context, error.description);
            }
          });

          presenter.navigateToStream.listen((page) {
            if (page?.isNotEmpty == true) {
              Get.offAllNamed(page!);
            }
          });

          return SafeArea(
            child: GestureDetector(
              onTap: _hideKeyboard,
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
                        create: (_) => presenter,
                        child: Form(
                          child: Column(
                            children: [
                              const EmailInput(),
                              const PasswordInput(),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 16),
                                child: LoginButton(),
                              ),
                              TextButton.icon(
                                  onPressed: () {},
                                  label: Text(R.strings.addAccount),
                                  icon: const Icon(Icons.person)),
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
