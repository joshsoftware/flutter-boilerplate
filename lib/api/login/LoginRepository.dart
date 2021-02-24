import 'package:bloc_pattern_flutter_app/models/login_response.dart';

import 'LoginApiProvider.dart';

class Repository {
  LoginApiProvider appApiProvider = LoginApiProvider();

  Future<LoginResponse> doUserLogin(String userName, String mbNo) =>
      appApiProvider.doUserLogin(userName, mbNo);
}
