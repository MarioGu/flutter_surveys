import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../pages/login_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    const primaryColor = Color.fromRGBO(224, 70, 94, 1);
    const secondColor = Color.fromRGBO(239, 123, 0, 1);
    const thirdColor = Color.fromRGBO(220, 220, 0, 1);

    return MaterialApp(
      title: 'Challenges',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: primaryColor).copyWith(
          secondary: secondColor,
        ),
        primaryColor: primaryColor,
        primaryColorDark: secondColor,
        primaryColorLight: thirdColor,
        backgroundColor: Colors.white,
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: primaryColor),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: secondColor),
          ),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
          alignLabelWithHint: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
        )),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          primary: primaryColor,
        )),
      ),
      home: const LoginPage(),
    );
  }
}
