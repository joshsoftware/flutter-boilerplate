import 'dart:convert';

import 'package:bloc_pattern_flutter_app/models/user.dart';
import 'package:bloc_pattern_flutter_app/utils/ApiConstant.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class LoginRepo {
  Future doLogin();
}

class LoginServices implements LoginRepo {
  LoginServices();


  @override
  Future doLogin() async {
    Map map = {
      'user': {
        'login_id': "9999999998",
        'password': "josh123#",
        'device_token': "GlobalConstant().firebaseToken",
      },
      'device': 'mobile'
    };
    print(map);
    var jsonBody = JsonEncoder().convert(map);

    Uri uri = Uri.https(ApiConstant.baseGetURL, ApiConstant.doLogin);
    Response response = await http.post(uri, body: jsonBody, headers: {
      'Accept': 'application/vnd.bidzwheelz; version=1',
      'Content-Type': 'application/json',
    });
    var jsonResponse = jsonDecode(response.body);
    User user = User.fromJson(jsonResponse['data']);

    return user;
  }
}
