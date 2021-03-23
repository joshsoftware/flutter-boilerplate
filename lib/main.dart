import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/app_constants.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/color_constants.dart';
import 'package:flutter_mvvm_boilerplate/utils/navigation_helper.dart';
import 'package:flutter_mvvm_boilerplate/views/custom_url_view.dart';
import 'package:flutter_mvvm_boilerplate/views/login_view.dart';

void main() async {
  //Check if custom URL flag is set and make safe check for production
  //If true custom url screen is shown
  //
  Widget _defaultHome = AppConstants.isCustomURLBuild && !AppConstants.isProdBuild
      ? NavigationHelper.getCustomURLViewWithProvider()
      : NavigationHelper.getLoginViewWithProvider();

  WidgetsFlutterBinding.ensureInitialized();
  //Locks orientation
  //Can be changed in runtime via same method.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  ///Sets Status Bar Color
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
        '/': (context) => _defaultHome,

        ///Home Route is Denoted as /
        ///Set tag in view itself, so it can be used directly maintaining consistency.
        CustomURLView.TAG: (context) => NavigationHelper.getCustomURLViewWithProvider(),
        LoginView.TAG: (context) => NavigationHelper.getLoginViewWithProvider(),
      },
    ),
  );
}
