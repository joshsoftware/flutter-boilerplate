import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/models/login_model.dart';
import 'package:flutter_mvvm_boilerplate/models/response_data.dart';
import 'package:flutter_mvvm_boilerplate/services/api_service.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/app_constants.dart';
import 'package:flutter_mvvm_boilerplate/widgets/edge_alert.dart';

class LoginViewModel with ChangeNotifier {
  ApiStatus loadingStatus = ApiStatus.started;

  TextEditingController _emailTextFieldController = TextEditingController();
  TextEditingController _passwordTextFieldController = TextEditingController();

  void loginUser({@required BuildContext context}) async {
    if (_emailTextFieldController.text.isEmpty) {
      AlertBar.show(context, title: "Enter email", description: "Please enter a Email");
      return;
    }
    if (_passwordTextFieldController.text.isEmpty) {
      AlertBar.show(context, title: "Enter password", description: "Please enter a Password");
      return;
    }

    LoginModel _loginModel = LoginModel(email: _emailTextFieldController.text.trim(), password: _passwordTextFieldController.text);

    ResponseData responseData = await ApiService().loginUser(context: context, loginModel: _loginModel);

    if (responseData.ok) {
      //TODO: Push to next screen
    }
  }
}
