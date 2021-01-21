import 'dart:convert';
import 'package:bloc_pattern_flutter_app/models/user.dart';
import 'package:bloc_pattern_flutter_app/utils/ApiConstant.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:http/http.dart' as http;

class ApiProvider {
  Client client = Client();
  final _baseUrl = ApiConstant.baseGetURL + ApiConstant.doLogin;

  Future<User> fetchLondonWeather() async {
    Map map = {
      'user': {
        'login_id': "999999998",
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
    /*final response = await client.post("$_baseUrl");
    print(response.body.toString());

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed');
    }
  }*/
}