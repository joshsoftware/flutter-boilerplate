class ApiConstant {
  static const bool isProdBuild = false;

  static const String baseURLStaging = "https://api-stage.bidwheelz.com";
  static const String baseURLProduction = "https://api.bidwheelz.com";

  static const String baseGetURLStaging = "api-stage.bidwheelz.com";
  static const String baseGetURLProduction = "api.bidwheelz.com";

  static const String baseURL = isProdBuild ? baseURLProduction : baseURLStaging;
  static const String baseGetURL = isProdBuild ? baseGetURLProduction : baseGetURLStaging;

  static const String doRegistration = "/registrations";

  static const String inviteUser = "/invitations";

  static const String verifyOTPLeading = "/registrations";
  static const String verifyOTPTrailing = "/verify_otp";

  static const String resendOTPLeading = "/registrations";
  static const String resendOTPTrailing = "/resend_otp";

  static const String setPasswordLeading = "/registrations";
  static const String setPasswordTrailing = "/set_password";

  static const String getOTPForgotPassword = "/registrations/send_otp";

  static const String doLogin = "/sessions";

  static const String doLogoutLeading = "/users";
  static const String doLogoutTrailing = "/logout";

  static const String getDashboardConstant = "/dashboard";




}
