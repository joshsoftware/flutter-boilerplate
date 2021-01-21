import 'package:bloc_pattern_flutter_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
 // Widget _default = LoginPage();

  runApp(MaterialApp(
    theme: ThemeData(
        accentColor: Colors.yellow,
        primaryColor: Color(0xFF07AAC3),
        primaryColorDark: Color(0xFF0A4B51),
        accentColorBrightness: Brightness.light),
    debugShowCheckedModeBanner: false,
    /*home: BlocProvider(
      create: (context) => LoginBloc(loginRepo: LoginServices()),
      child: LoginPage(),
    ),*/
    routes: {
      '/': (context) => LoginPage(),
    },
  ));
}
