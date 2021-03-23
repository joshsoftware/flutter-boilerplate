import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/app_constants.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/color_constants.dart';
import 'package:flutter_mvvm_boilerplate/view_models/login_view_model.dart';
import 'package:flutter_mvvm_boilerplate/widgets/common_button.dart';
import 'package:flutter_mvvm_boilerplate/widgets/common_text_field.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  static const String TAG = "/LoginView";

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _buildSubmitButton(LoginViewModel loginViewModel) {
    switch (loginViewModel.loadingStatus) {
      case ApiStatus.idle:
        return CommonButton(
          title: "Login",
          function: () {
            loginViewModel.loginUser(context: context);
          },
        );
      case ApiStatus.started:
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        );
      case ApiStatus.completed:
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Icon(
            Icons.check,
            size: 40,
            color: ColorConstants.GREEN,
          ),
        );

      default:
        return CommonButton(
          title: "Login",
          function: () {
            loginViewModel.loginUser(context: context);
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginViewModel _loginViewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.APP_NAME),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: CommonTextField(
              label: "Email",
              hint: "Enter Email here",
              controller: _loginViewModel.emailTextFieldController,
            ),
          ),
          CommonTextField(
            label: "Password",
            hint: "Enter Password here",
            controller: _loginViewModel.passwordTextFieldController,
          ),
          _buildSubmitButton(_loginViewModel),
        ],
      ),
    );
  }
}
