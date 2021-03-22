import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/models/response_data.dart';
import 'package:flutter_mvvm_boilerplate/utils/pretty_json_print.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/singleton_constant.dart';
import 'package:flutter_mvvm_boilerplate/widgets/loader_widget.dart';
import 'package:flutter_mvvm_boilerplate/services/network_check.dart';
import 'package:flutter_mvvm_boilerplate/utils/shared_preferences_helper.dart';
import 'package:flutter_mvvm_boilerplate/widgets/edge_alert.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  Future<ResponseData> postRequest(BuildContext context, var requestUri, Map map,
      {bool showError: false,
      bool showMessage: false,
      bool showLoader: true,
      bool useAuth: true,
      String responseName: "",
      bool showLog: true,
      int version: 1}) async {
    ResponseData responseData = ResponseData();
    if (showLog) {
      debugPrint("Requested URL: " + requestUri.toString());
      debugPrint("Map: $map");
    }

    var jsonBody = JsonEncoder().convert(map);
    if (await NetworkCheck.check()) {
      if (showLoader) LoaderWidget.showLoader(context);
      await http
          .post(requestUri, body: jsonBody, headers: {
//            'Accept': 'application/vnd.dygnostic.in; version=$version',
            'Content-Type': 'application/json',
            'Authorization': useAuth ? 'Bearer ' + SingletonConstants().token : "",
          })
          .timeout(Duration(seconds: 15))
          .then((http.Response response) async {
            if (showLoader) LoaderWidget.hideLoader(context);

            if (response.statusCode == 200 || response.statusCode == 201) {
              if (showLog) {
                debugPrint("$responseName Response: ${prettyJson(jsonDecode(response.body))}");
              }
              responseData = ResponseData.fromResponse(response);
            } else if (response.statusCode == 401) {
              if (showLog) {
                debugPrint("Request failed with status: ${response.statusCode}.");
                debugPrint("Error:${response.reasonPhrase}");
                debugPrint("$responseName Response:${response.body}");
              }
              await SharedPreferencesHelper.clearAuthToken();
              // Navigator.pushNamedAndRemoveUntil(context, GetOtpPage.tag, (route) => false);
            } else {
              if (showLog) {
                debugPrint("Request failed with status: ${response.statusCode}.");
                debugPrint("Error:${response.reasonPhrase}");
                debugPrint("$responseName Response:${response.body}");
              }
              responseData = ResponseData.fromResponse(response);

              if (showMessage) {
//                if (responseData.message != null) await Constant().genericErrorDialog(context, responseData.message, 0);
              }
              if (showError) {
                if (responseData.errors != null)
                  AlertBar.show(context,
                      title: 'Error', description: responseData.errors.message, gravity: AlertBar.TOP, backgroundColor: Colors.red);
              }
            }
          })
          .catchError((error) {
            if (showLoader) LoaderWidget.hideLoader(context);
            debugPrint(error.toString());
          });
    } else {
      AlertBar.show(context,
          title: 'No Connectivity', description: 'Please Check Internet Connection', gravity: AlertBar.TOP, backgroundColor: Colors.red);
    }
    return responseData;
  }

  Future<ResponseData> putRequest(
    BuildContext context,
    var requestUri,
    Map map, {
    bool showError: false,
    bool showMessage: false,
    bool showLoader: false,
    bool useAuth: true,
    String responseName: "",
    bool showLog: true,
    int version: 1,
  }) async {
    ResponseData responseData = ResponseData();
    if (showLog) {
      debugPrint("Requested URL: " + requestUri.toString());
      debugPrint("Map: $map");
    }
    var jsonBody = JsonEncoder().convert(map);
    if (await NetworkCheck.check()) {
      if (showLoader) LoaderWidget.showLoader(context);

      await http
          .put(requestUri, body: jsonBody, headers: {
//            'Accept': 'application/vnd.dygnostic.in; version=$version',
            'Content-Type': 'application/json',
            'Authorization': useAuth ? 'Bearer ' + SingletonConstants().token : "",
          })
          .timeout(Duration(seconds: 15))
          .then((http.Response response) async {
            if (showLoader) LoaderWidget.hideLoader(context);

            if (response.statusCode == 200 || response.statusCode == 201) {
              if (showLog) {
                debugPrint("$responseName Response: ${prettyJson(jsonDecode(response.body))}");
              }
              responseData = ResponseData.fromResponse(response);
            } else if (response.statusCode == 401) {
              if (showLog) {
                debugPrint("Request failed with status: ${response.statusCode}.");
                debugPrint("Error:${response.reasonPhrase}");
                debugPrint("$responseName Response:${response.body}");
              }
              await SharedPreferencesHelper.clearAuthToken();
              // Navigator.pushNamedAndRemoveUntil(context, GetOtpPage.tag, (route) => false);
            } else {
              if (showLog) {
                debugPrint("Request failed with status: ${response.statusCode}.");
                debugPrint("Error:${response.reasonPhrase}");
                debugPrint("$responseName Response:${response.body}");
              }
              responseData = ResponseData.fromResponse(response);
              if (showMessage) {
//                if (responseData.message != null) await Constant().genericErrorDialog(context, responseData.message, 0);
              }
              if (showError) {
                if (responseData.errors != null)
                  AlertBar.show(context,
                      title: 'Error', description: responseData.errors.message, gravity: AlertBar.TOP, backgroundColor: Colors.red);
              }
            }
          })
          .catchError((error) {
            if (showLoader) LoaderWidget.hideLoader(context);
            debugPrint(error.toString());
          });
    } else {
      AlertBar.show(context,
          title: 'No Connectivity', description: 'Please Check Internet Connection', gravity: AlertBar.TOP, backgroundColor: Colors.red);
    }
    return responseData;
  }

  Future<ResponseData> patchRequest(BuildContext context, var requestUri, Map map,
      {bool showError: false,
      bool showMessage: false,
      bool showLoader: false,
      bool useAuth: true,
      String responseName: "",
      bool showLog: true,
      int version: 1}) async {
    ResponseData responseData = ResponseData();
    if (showLog) {
      debugPrint("Requested URL: " + requestUri.toString());
      debugPrint("Map: $map");
    }
    var jsonBody = JsonEncoder().convert(map);
    if (await NetworkCheck.check()) {
      if (showLoader) LoaderWidget.showLoader(context);

      await http
          .patch(requestUri, body: jsonBody, headers: {
//            'Accept': 'application/vnd.dygnostic.in; version=$version',
            'Content-Type': 'application/json',
            'Authorization': useAuth ? 'Bearer ' + SingletonConstants().token : "",
          })
          .timeout(Duration(seconds: 15))
          .then((http.Response response) async {
            if (showLoader) LoaderWidget.hideLoader(context);

            if (response.statusCode == 200 || response.statusCode == 201) {
              if (showLog) {
                debugPrint("$responseName Response: ${prettyJson(jsonDecode(response.body))}");
              }
              responseData = ResponseData.fromResponse(response);
            } else if (response.statusCode == 401) {
              if (showLog) {
                debugPrint("Request failed with status: ${response.statusCode}.");
                debugPrint("Error:${response.reasonPhrase}");
                debugPrint("$responseName Response:${response.body}");
              }
              await SharedPreferencesHelper.clearAuthToken();
              // Navigator.pushNamedAndRemoveUntil(context, GetOtpPage.tag, (route) => false);
            } else {
              if (showLog) {
                debugPrint("Request failed with status: ${response.statusCode}.");
                debugPrint("Error:${response.reasonPhrase}");
                debugPrint("$responseName Response:${response.body}");
              }
              responseData = ResponseData.fromResponse(response);
              if (showMessage) {
//                if (responseData.message != null) await Constant().genericErrorDialog(context, responseData.message, 0);
              }
              if (showError) {
                if (responseData.errors != null)
                  AlertBar.show(context,
                      title: 'Error', description: responseData.errors.message, gravity: AlertBar.TOP, backgroundColor: Colors.red);
              }
            }
          })
          .catchError((error) {
            if (showLoader) LoaderWidget.hideLoader(context);
            debugPrint(error.toString());
          });
    } else {
      AlertBar.show(context,
          title: 'No Connectivity', description: 'Please Check Internet Connection', gravity: AlertBar.TOP, backgroundColor: Colors.red);
    }
    return responseData;
  }

  Future<ResponseData> getRequest(BuildContext context, var requestUri,
      {bool showError: false,
      bool showMessage: false,
      bool showLoader: false,
      bool useAuth: true,
      String responseName: "",
      bool showLog: true,
      int version: 1}) async {
    ResponseData responseData = ResponseData();
    if (showLog) {
      debugPrint("Requested URL: " + requestUri.toString());
    }

    if (await NetworkCheck.check()) {
      if (showLoader) LoaderWidget.showLoader(context);

      await http
          .get(requestUri, headers: {
            'Accept': 'application/vnd.dyagnostic.in; version=$version',
            'Content-Type': 'application/json',
            'Authorization': useAuth ? 'Bearer ' + SingletonConstants().token : "",
          })
          .timeout(Duration(seconds: 15))
          .then((http.Response response) async {
            if (showLoader) LoaderWidget.hideLoader(context);

            if (response.statusCode == 200 || response.statusCode == 201) {
              if (showLog) {
                debugPrint("$responseName Response: ${prettyJson(jsonDecode(response.body))}");
              }
              responseData = ResponseData.fromResponse(response);
            } else if (response.statusCode == 401) {
              if (showLog) {
                debugPrint("Request failed with status: ${response.statusCode}.");
                debugPrint("Error:${response.reasonPhrase}");
                debugPrint("$responseName Response:${response.body}");
              }
              await SharedPreferencesHelper.clearAuthToken();
              // Navigator.pushNamedAndRemoveUntil(context, GetOtpPage.tag, (route) => false);
            } else {
              if (showLog) {
                debugPrint("Request failed with status: ${response.statusCode}.");
                debugPrint("Error:${response.reasonPhrase}");
                debugPrint("$responseName Response:${response.body}");
              }
              responseData = ResponseData.fromResponse(response);

              if (showMessage) {
//                if (responseData.message != null) await Constant().genericErrorDialog(context, responseData.message, 0);
              }
              if (showError) {
                if (responseData.errors != null)
                  AlertBar.show(context,
                      title: 'Error', description: responseData.errors.message, gravity: AlertBar.TOP, backgroundColor: Colors.red);
              }
            }
          })
          .catchError((error) {
            if (showLoader) LoaderWidget.hideLoader(context);
            debugPrint(error.toString());
          });
    } else {
      AlertBar.show(context,
          title: 'No Connectivity', description: 'Please Check Internet Connection', gravity: AlertBar.TOP, backgroundColor: Colors.red);
    }
    return responseData;
  }

  Future<ResponseData> deleteRequest(BuildContext context, var requestUri,
      {bool showError: false,
      bool showMessage: false,
      bool showLoader: false,
      bool useAuth: true,
      String responseName: "",
      bool showLog: true,
      int version: 1}) async {
    ResponseData responseData = ResponseData();
    if (showLog) {
      debugPrint("Requested URL: " + requestUri.toString());
    }
    if (await NetworkCheck.check()) {
      if (showLoader) LoaderWidget.showLoader(context);

      await http
          .delete(requestUri, headers: {
//        'Accept': 'application/vnd.dyagnostic.in; version=$version',
            'Content-Type': 'application/json',
            'Authorization': useAuth ? 'Bearer ' + SingletonConstants().token : "",
          })
          .timeout(Duration(seconds: 15))
          .then((http.Response response) async {
            if (showLoader) LoaderWidget.hideLoader(context);

            if (response.statusCode == 200 || response.statusCode == 201) {
              if (showLog) {
                debugPrint("$responseName Response: ${prettyJson(jsonDecode(response.body))}");
              }

              responseData = ResponseData.fromResponse(response);
            } else if (response.statusCode == 401) {
              if (showLog) {
                debugPrint("Request failed with status: ${response.statusCode}.");
                debugPrint("Error:${response.reasonPhrase}");
                debugPrint("$responseName Response:${response.body}");
              }
              await SharedPreferencesHelper.clearAuthToken();
              // Navigator.pushNamedAndRemoveUntil(context, GetOtpPage.tag, (route) => false);
            } else {
              if (showLog) {
                debugPrint("Request failed with status: ${response.statusCode}.");
                debugPrint("Error:${response.reasonPhrase}");
                debugPrint("$responseName Response:${response.body}");
              }
              responseData = ResponseData.fromResponse(response);

              if (showMessage) {
//                if (responseData.message != null) await Constant().genericErrorDialog(context, responseData.message, 0);
              }
              if (showError) {
                if (responseData.errors != null)
                  AlertBar.show(context,
                      title: 'Error', description: responseData.errors.message, gravity: AlertBar.TOP, backgroundColor: Colors.red);
              }
            }
          })
          .catchError((error) {
            if (showLoader) LoaderWidget.hideLoader(context);
            debugPrint(error.toString());
          });
    } else {
      AlertBar.show(context,
          title: 'No Connectivity', description: 'Please Check Internet Connection', gravity: AlertBar.TOP, backgroundColor: Colors.red);
    }
    return responseData;
  }
}
