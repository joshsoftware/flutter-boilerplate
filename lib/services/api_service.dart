import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_boilerplate/models/login_model.dart';
import 'package:flutter_mvvm_boilerplate/models/response_data.dart';
import 'package:flutter_mvvm_boilerplate/utils/api_helper.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/api_constants.dart';

class ApiService {
  Future<ResponseData> loginUser({@required BuildContext context, @required LoginModel loginModel}) {
    Uri _uri = Uri.parse(ApiConstants.LOGIN);

    return ApiHelper().postRequest(
      context,
      _uri,
      loginModel.toJson(),
      useAuth: false,
      showLoader: false,
      responseName: "Login",
      showLog: true,
    );
  }
}