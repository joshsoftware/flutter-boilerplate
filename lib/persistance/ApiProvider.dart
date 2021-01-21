import 'dart:convert';
import 'package:bloc_pattern_flutter_app/models/user.dart';
import 'package:bloc_pattern_flutter_app/utils/ApiConstant.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:http/http.dart' as http;

class ApiProvider {
  Client client = Client();
  final _baseUrl = ApiConstant.baseGetURL;

  Future<User> fetchLondonWeather(String userName, String mobNo) async {
    Map map = {
      'user': {
        'login_id': userName,
        'password': mobNo,
        'device_token': "GlobalConstant().firebaseToken",
      },
      'device': 'mobile'
    };
    print(map);
    var jsonBody = JsonEncoder().convert(map);

    Uri uri = Uri.https(_baseUrl, ApiConstant.doLogin);
    Response response = await http.post(uri, body: jsonBody, headers: {
      'Accept': 'application/vnd.bidzwheelz; version=1',
      'Content-Type': 'application/json',
    });
    var jsonResponse = jsonDecode(response.body);
    User user;
    if (response.statusCode == 200) {
      return User.fromJson(jsonResponse['data']);
    } else if (response.statusCode == 500) {
      return User.fromJson(jsonResponse);
    } else {
      return User.fromJson(jsonResponse);
    }
  }
}
