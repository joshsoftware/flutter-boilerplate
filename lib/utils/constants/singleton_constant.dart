import 'package:flutter_mvvm_boilerplate/utils/constants/api_constants.dart';
import 'package:flutter_mvvm_boilerplate/utils/shared_preferences_helper.dart';

class SingletonConstants {
  static SingletonConstants _instance;

  factory SingletonConstants() => _instance ??= new SingletonConstants._();

  SingletonConstants._();

  String _baseUrl;
  String _authToken;

  String getBaseUrl() => _baseUrl != null ? _baseUrl : ApiConstants.SERVER_BASE_URL;

  void setBaseUrl(String baseURL) => _baseUrl = baseURL;

  Future<String> get getToken async => _authToken != null ? _authToken : await SharedPreferencesHelper.getAuthTokenWithNullCheck();
}
