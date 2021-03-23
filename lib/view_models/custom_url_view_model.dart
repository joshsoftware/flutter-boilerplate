import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/models/login_model.dart';
import 'package:flutter_mvvm_boilerplate/models/response_data_model.dart';
import 'package:flutter_mvvm_boilerplate/services/api_service.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/api_constants.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/app_constants.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/singleton_constant.dart';
import 'package:flutter_mvvm_boilerplate/utils/shared_preferences_helper.dart';
import 'package:flutter_mvvm_boilerplate/views/login_view.dart';
import 'package:flutter_mvvm_boilerplate/widgets/alert_bar.dart';

class CustomURLViewModel with ChangeNotifier {
  TextEditingController urlTextFieldController = TextEditingController();

  //Check if custom URL was set previously if true then re-set it in texfield
  void checkIfURLSetPreviously({@required BuildContext context}) async {
    String url = await SharedPreferencesHelper.getCustomURL();
    if (url != null) {
      urlTextFieldController.text = url;
    }
  }

  //Set URL in singleton class and shared preference
  void setURL({@required BuildContext context}) async {
    if (urlTextFieldController.text.isEmpty) {
      AlertBar.show(context, title: "Enter URL", description: "Please enter a URL");
      return;
    }
    SingletonConstants().setBaseUrl(urlTextFieldController.text.trim());
    SharedPreferencesHelper.setCustomURL(urlTextFieldController.text.trim());
    Navigator.pushNamedAndRemoveUntil(context, LoginView.TAG, (route) => false);
  }

  void setStaging({BuildContext context}) async {
    SingletonConstants().setBaseUrl(ApiConstants.SERVER_BASE_URL);
    Navigator.pushNamedAndRemoveUntil(context, LoginView.TAG, (route) => false);
  }
}
