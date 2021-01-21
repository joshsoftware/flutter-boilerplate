import 'package:bloc_pattern_flutter_app/models/user.dart';

import 'ApiProvider.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();

  Future<User> fetchLondonWeather(String userName, String mbNo) => appApiProvider.fetchLondonWeather(userName, mbNo);
}