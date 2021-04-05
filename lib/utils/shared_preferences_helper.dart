import 'package:shared_preferences/shared_preferences.dart';

/// Common shared preference helper class
class SharedPreferencesHelper {
  static final String _authToken = "authToken";
  static final String _customURL = "customURL";

  static Future<String> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authToken);
  }

  //Returns empty String if token is not set
  static Future<String> getAuthTokenWithNullCheck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authToken) ?? "";
  }

  static Future<bool> setAuthToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_authToken, value);
  }

  static Future<bool> clearAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_authToken);
  }

  static Future<String> getCustomURL() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_customURL);
  }

  static Future<bool> setCustomURL(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_customURL, value);
  }
}
