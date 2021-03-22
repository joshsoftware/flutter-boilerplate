import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/app_constants.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  static const String TAG = "/LoginView";

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.APP_NAME),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
