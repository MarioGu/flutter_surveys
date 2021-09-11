import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../ui/components/components.dart';
//import '../../ui/helpers/helpers.dart';
import './factories/factories.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  //R.load(const Locale('en', 'US'));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return GetMaterialApp(
      title: 'Challenges',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: makeSplashPage, transition: Transition.fade),
        GetPage(
            name: '/login', page: makeLoginPage, transition: Transition.fadeIn),
        GetPage(
          name: '/surveys',
          page: () => const Scaffold(
            body: Text('Enquetes'),
          ),
          transition: Transition.fadeIn,
        ),
      ],
    );
  }
}
