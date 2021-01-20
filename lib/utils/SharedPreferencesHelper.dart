import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  ///
  /// Instantiation of the SharedPreferences library

  static final String userJson = "userJson";

  static Future<bool> setUserJson(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userJson, value);
  }
}
