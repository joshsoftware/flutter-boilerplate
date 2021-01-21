import 'package:bloc_pattern_flutter_app/models/user.dart';

import 'LoginApiProvider.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();

  Future<User> doUserLogin(String userName, String mbNo) => appApiProvider.doUserLogin(userName, mbNo);
}