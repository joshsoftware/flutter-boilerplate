class ApiConstant {
  static const bool isProdBuild = false;

  static const String baseURLStaging = "https://api-stage.bidwheelz.com";
  static const String baseURLProduction = "https://api.bidwheelz.com";

  static const String baseGetURLStaging = "api-stage.bidwheelz.com";
  static const String baseGetURLProduction = "api.bidwheelz.com";

  static const String baseURL = isProdBuild ? baseURLProduction : baseURLStaging;
  static const String baseGetURL = isProdBuild ? baseGetURLProduction : baseGetURLStaging;

  static const String doLogin = "/sessions";






}
