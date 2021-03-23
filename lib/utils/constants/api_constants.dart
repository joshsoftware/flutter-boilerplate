import 'package:flutter_mvvm_boilerplate/utils/constants/app_constants.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/singleton_constant.dart';

///Api Paths are set here
class ApiConstants {
  //Check if build is production or staging and use url accordingly      PRODUCTION     :     STAGING
  static const String SERVER_BASE_URL = AppConstants.isProdBuild ? "https://reqres.in" : "https://reqres.in";

  //NOTE: DO NOT TWEAK
  //Assigning Application's base url which app is going to use. Can use URL from custom page or from SERVER_BASE_URL.
  //Application have Safe checks so custom URL page will never show if isProdBuild flag in AppConstants is set as true
  static String appBaseURL =
      AppConstants.isCustomURLBuild && !AppConstants.isProdBuild ? SingletonConstants().getBaseUrl() : SERVER_BASE_URL;

  //Login end point
  //For new end points always start with "/".
  static const String LOGIN = "/api/login";
}

//NOTE: DO NOT TWEAK
//Getter to fetch baseURL easily.
//This will be available anywhere on APP level.
String get baseURL => ApiConstants.appBaseURL;
