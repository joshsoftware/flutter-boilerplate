import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/color_constants.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/app_constants.dart';
import 'package:flutter_mvvm_boilerplate/views/login_view.dart';

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
  Widget _defaultHome = AppConstants.isCustomURLBuild && !AppConstants.isProdBuild ? null : LoginView();
//
// //  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//
//   if (await checkForLogin()) {
//     _defaultHome = ApiConstants.isCustomURLBuild && !ApiConstants.isProdBuild ? CustomURLPage() : SwitchProfile();
//   }
//
//   GlobalConstant().baseURL = ApiConstants.baseURL;

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
        // ConsultationHistoryDetailPage.tag: (context) => ConsultationHistoryDetailPage(),
      },
    ),
  );
}
