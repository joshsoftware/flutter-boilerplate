import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/color_constants.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/app_constants.dart';
import 'package:flutter_mvvm_boilerplate/utils/navigation_helper.dart';
import 'package:flutter_mvvm_boilerplate/view_models/custom_url_view_model.dart';
import 'package:flutter_mvvm_boilerplate/view_models/login_view_model.dart';
import 'package:flutter_mvvm_boilerplate/views/custom_url_view.dart';
import 'package:flutter_mvvm_boilerplate/views/login_view.dart';
import 'package:provider/provider.dart';

//
// Future<bool> checkForLogin() async {
//   String authToken = await SharedPreferencesHelper.getAuthToken();
//   if (authToken != null) {
//     GlobalConstant().token = authToken;
//     return true;
//   }
//   return false;
// }

void main() async {
  Widget _defaultHome = AppConstants.isCustomURLBuild && !AppConstants.isProdBuild
      ? NavigationHelper.getCustomURLScreenWithProvider()
      : NavigationHelper.getLoginScreenWithProvider();

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: ));

  runApp(
    new MaterialApp(
      title: AppConstants.APP_NAME,
      theme: ThemeData(
        accentColor: ColorConstants.PRIMARY,
        accentColorBrightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        //Home Route is Denoted as /
        '/': (context) => _defaultHome,
        CustomURLView.TAG: (context) => NavigationHelper.getCustomURLScreenWithProvider(),
        LoginView.TAG: (context) => NavigationHelper.getLoginScreenWithProvider(),
      },
    ),
  );
}
