class AppConstants {
  static const String APP_NAME = 'Flutter Boiler Plate';
  static const bool isCustomURLBuild = false;
  static const bool isProdBuild = false;

  static const Map<String, String> Countries = {"United States of America": "us", "India": "in", "Korea": "kr", "China": "ch"};
}

enum ApiStatus { started, completed, loading, searching, empty, failed, timeout }
