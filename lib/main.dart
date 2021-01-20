import 'dart:convert';

import 'package:bloc_pattern_flutter_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api/login/loginService.dart';
import 'bloc/login/loginBloc.dart';

void main() async {
  Widget _default = LoginPage();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MaterialApp(
    theme: ThemeData(
        accentColor: Colors.yellow,
        primaryColor: Color(0xFF07AAC3),
        primaryColorDark: Color(0xFF0A4B51),
        accentColorBrightness: Brightness.light),
    debugShowCheckedModeBanner: false,
    home: BlocProvider(
      create: (context) => LoginBloc(loginRepo: LoginServices()),
      child: LoginPage(),
    ),
    /*routes: {
      '/': (context) => _default,
    },*/
  ));
}
