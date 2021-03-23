import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/models/login_model.dart';
import 'package:flutter_mvvm_boilerplate/models/response_data_model.dart';
import 'package:flutter_mvvm_boilerplate/services/api_service.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/app_constants.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/color_constants.dart';
import 'package:flutter_mvvm_boilerplate/utils/shared_preferences_helper.dart';
import 'package:flutter_mvvm_boilerplate/widgets/alert_bar.dart';

class LoginViewModel with ChangeNotifier {
  ApiStatus loadingStatus = ApiStatus.idle;

  TextEditingController emailTextFieldController = TextEditingController(text: "eve.holt@reqres.in");
  TextEditingController passwordTextFieldController = TextEditingController(text: "cityslicka");

  void loginUser({@required BuildContext context}) async {
    if (emailTextFieldController.text.isEmpty) {
      AlertBar.show(context, title: "Enter email", description: "Please enter a Email");
      return;
    }
    if (passwordTextFieldController.text.isEmpty) {
      AlertBar.show(context, title: "Enter password", description: "Please enter a Password");
      return;
    }
    loadingStatus = ApiStatus.started;

    notifyListeners();

    LoginModel _loginModel = LoginModel(email: emailTextFieldController.text.trim(), password: passwordTextFieldController.text);

    ResponseData responseData = await ApiService().loginUser(context: context, loginModel: _loginModel);

    if (responseData.ok) {
      //TODO: Push to next screen
      loadingStatus = ApiStatus.completed;
      String token = jsonDecode(responseData.rawResponseBody)['token'];
      SharedPreferencesHelper.setAuthToken(token);
      AlertBar.show(context, title: "Done", description: "Login Successful Token: $token", backgroundColor: ColorConstants.GREEN);
    } else {
      loadingStatus = ApiStatus.failed;
    }

    notifyListeners();

    await Future.delayed(Duration(seconds: 3));

    loadingStatus = ApiStatus.idle;
    notifyListeners();
  }
}
