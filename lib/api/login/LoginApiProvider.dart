import 'dart:convert';
import 'package:bloc_pattern_flutter_app/models/login_response.dart';
import 'package:bloc_pattern_flutter_app/utils/ApiConstant.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:http/http.dart' as http;

class LoginApiProvider {
  Client client = Client();

  Future<LoginResponse> doUserLogin(String userName, String mobNo) async {
    Map map = {
      'email': userName,
      'password': mobNo,
    };
    print(map);
    var jsonBody = JsonEncoder().convert(map);

    Uri uri = Uri.https(ApiConstant.baseURL, ApiConstant.doLogin);
    Response response = await http.post(uri, body: jsonBody, headers: {
      'Content-Type': 'application/json',
    });
    var jsonResponse = jsonDecode(response.body);
    return LoginResponse.fromJson(jsonResponse);
    /*
    if (response.statusCode == 200) {
      return User.fromJson(jsonResponse['data']);
    } else if (response.statusCode == 500) {
      return User.fromJson(jsonResponse);
    } else {
      return User.fromJson(jsonResponse);
    }*/
  }
}
