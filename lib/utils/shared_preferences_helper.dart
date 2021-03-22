import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _authToken = "authToken";

  static Future<String> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authToken);
  }

  static Future<bool> setAuthToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_authToken, value);
  }

  static Future<bool> clearAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_authToken);
  }
}
