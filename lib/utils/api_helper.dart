import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/models/response_data_model.dart';
import 'package:flutter_mvvm_boilerplate/services/network_check.dart';
import 'package:flutter_mvvm_boilerplate/utils/constants/singleton_constant.dart';
import 'package:flutter_mvvm_boilerplate/utils/pretty_json_print.dart';
import 'package:flutter_mvvm_boilerplate/utils/shared_preferences_helper.dart';
import 'package:flutter_mvvm_boilerplate/widgets/alert_bar.dart';
import 'package:flutter_mvvm_boilerplate/widgets/loader_widget.dart';
import 'package:http/http.dart' as http;

///This is generic API Helper and is very efficient.
///Auto Checks Network Availability
///Automated Loader - flag controlled
///Cleaner formatted response
///Automated message/error dialog - flag controller
///Things to change:
///              1. Error and Message Alert widget - can be left default, change as per UI design.
///              2. Header -  Change as per project spec.
///

class NoNetworkException implements Exception {
  String errMsg() => 'Please Check Internet Connection';
}

class ApiHelper {
  //Timeout in seconds
  static const int _DEFAULT_TIMEOUT = 45;

  //Base headers Supports version
  //Gets Token from singleton class which is set either on login or app startup in main.dart
  static Future<Map<String, String>> _getHeaders(bool useAuth, int apiVersion) async {
    Map<String, String> _map = {
      //Add or Remove headers from here
      'Content-Type': 'application/json',
      'Authorization': useAuth ? 'Bearer ' + await SingletonConstants().getToken : "",
    };
    return _map;
  }

  static Future<ResponseData> _handleError(
    BuildContext context,
    http.Response response,
    String responseName,
    bool showLog,
    bool showMessage,
    bool showError,
  ) async {
    ResponseData responseData = ResponseData();
    //Handle Unauthorised
    if (response.statusCode == 401) {
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
      try {
        responseData = ResponseData.fromResponse(response);
      } catch (e) {
        responseData = ResponseData(
            errors: ResponseErrors(message: "Request failed with status: ${response.statusCode}. \n ${response.reasonPhrase}"));

        if (showLog) debugPrint("$e");
      }

      if (showMessage) {
//                if (responseData.message != null) await Constant().genericErrorDialog(context, responseData.message, 0);
      }
      if (showError) {
        if (responseData.errors != null) {
          AlertBar.show(context,
              title: 'Error', description: responseData.errors.message, gravity: AlertBar.TOP, backgroundColor: Colors.red);
        }
      }
    }
    return responseData;
  }

  Future<ResponseData> postRequest(BuildContext context, var requestUri, Map map,
      {bool showError: false,
      bool showMessage: false,
      bool showLoader: true,
      bool useAuth: true,
      String responseName: "",
      bool showLog: true,
      bool showConnectivityError: true,
      int apiVersion: 1}) async {
    ResponseData responseData = ResponseData();
    if (showLog) {
      debugPrint("Requested URL: " + requestUri.toString());
      debugPrint("Map: $map");
    }

    var jsonBody = JsonEncoder().convert(map);
    if (await NetworkCheck.isOnline(context, showConnectivityError)) {
      if (showLoader) LoaderWidget.showLoader(context);
      await http
          .post(requestUri, body: jsonBody, headers: await _getHeaders(useAuth, apiVersion))
          .timeout(Duration(seconds: _DEFAULT_TIMEOUT))
          .then((http.Response response) async {
        if (showLoader) LoaderWidget.hideLoader(context);

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (showLog) {
            debugPrint("$responseName Response: ${prettyJson(jsonDecode(response.body))}");
          }
          responseData = ResponseData.fromResponse(response);
        } else {
          responseData = await _handleError(context, response, responseName, showLog, showMessage, showError);
        }
      }).catchError((error) {
        if (showLoader) LoaderWidget.hideLoader(context);
        debugPrint(error.toString());
      });
    } else {
      throw NoNetworkException;
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
    bool showConnectivityError: true,
    int apiVersion: 1,
  }) async {
    ResponseData responseData = ResponseData();
    if (showLog) {
      debugPrint("Requested URL: " + requestUri.toString());
      debugPrint("Map: $map");
    }
    var jsonBody = JsonEncoder().convert(map);
    if (await NetworkCheck.isOnline(context, showConnectivityError)) {
      if (showLoader) LoaderWidget.showLoader(context);

      await http
          .put(requestUri, body: jsonBody, headers: await _getHeaders(useAuth, apiVersion))
          .timeout(Duration(seconds: _DEFAULT_TIMEOUT))
          .then((http.Response response) async {
        if (showLoader) LoaderWidget.hideLoader(context);

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (showLog) {
            debugPrint("$responseName Response: ${prettyJson(jsonDecode(response.body))}");
          }
          responseData = ResponseData.fromResponse(response);
        } else {
          responseData = await _handleError(context, response, responseName, showLog, showMessage, showError);
        }
      }).catchError((error) {
        if (showLoader) LoaderWidget.hideLoader(context);
        debugPrint(error.toString());
      });
    } else {
      throw NoNetworkException;
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
      bool showConnectivityError: true,
      int apiVersion: 1}) async {
    ResponseData responseData = ResponseData();
    if (showLog) {
      debugPrint("Requested URL: " + requestUri.toString());
      debugPrint("Map: $map");
    }
    var jsonBody = JsonEncoder().convert(map);
    if (await NetworkCheck.isOnline(context, showConnectivityError)) {
      if (showLoader) LoaderWidget.showLoader(context);

      await http
          .patch(requestUri, body: jsonBody, headers: await _getHeaders(useAuth, apiVersion))
          .timeout(Duration(seconds: _DEFAULT_TIMEOUT))
          .then((http.Response response) async {
        if (showLoader) LoaderWidget.hideLoader(context);

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (showLog) {
            debugPrint("$responseName Response: ${prettyJson(jsonDecode(response.body))}");
          }
          responseData = ResponseData.fromResponse(response);
        } else {
          responseData = await _handleError(context, response, responseName, showLog, showMessage, showError);
        }
      }).catchError((error) {
        if (showLoader) LoaderWidget.hideLoader(context);
        debugPrint(error.toString());
      });
    } else {
      throw NoNetworkException;
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
      bool showConnectivityError: true,
      int apiVersion: 1}) async {
    ResponseData responseData = ResponseData();
    if (showLog) {
      debugPrint("Requested URL: " + requestUri.toString());
    }

    if (await NetworkCheck.isOnline(context, showConnectivityError)) {
      if (showLoader) LoaderWidget.showLoader(context);

      await http
          .get(requestUri, headers: await _getHeaders(useAuth, apiVersion))
          .timeout(Duration(seconds: _DEFAULT_TIMEOUT))
          .then((http.Response response) async {
        if (showLoader) LoaderWidget.hideLoader(context);

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (showLog) {
            debugPrint("$responseName Response: ${prettyJson(jsonDecode(response.body))}");
          }
          responseData = ResponseData.fromResponse(response);
        } else {
          responseData = await _handleError(context, response, responseName, showLog, showMessage, showError);
        }
      }).catchError((error) {
        if (showLoader) LoaderWidget.hideLoader(context);
        debugPrint(error.toString());
      });
    } else {
      throw NoNetworkException;
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
      bool showConnectivityError: true,
      int apiVersion: 1}) async {
    ResponseData responseData = ResponseData();
    if (showLog) {
      debugPrint("Requested URL: " + requestUri.toString());
    }
    if (await NetworkCheck.isOnline(context, showConnectivityError)) {
      if (showLoader) LoaderWidget.showLoader(context);

      await http
          .delete(requestUri, headers: await _getHeaders(useAuth, apiVersion))
          .timeout(Duration(seconds: _DEFAULT_TIMEOUT))
          .then((http.Response response) async {
        if (showLoader) LoaderWidget.hideLoader(context);

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (showLog) {
            debugPrint("$responseName Response: ${prettyJson(jsonDecode(response.body))}");
          }

          responseData = ResponseData.fromResponse(response);
        } else {
          responseData = await _handleError(context, response, responseName, showLog, showMessage, showError);
        }
      }).catchError((error) {
        if (showLoader) LoaderWidget.hideLoader(context);
        debugPrint(error.toString());
      });
    } else {
      if (!showConnectivityError) throw NoNetworkException;
    }
    return responseData;
  }

  Future<ResponseData> getRequestBG(var requestUri,
      {bool useAuth: true, String responseName: "", bool showLog: true, int apiVersion: 1}) async {
    return await getRequest(null, requestUri,
        showError: false,
        showLog: showLog,
        responseName: responseName,
        showLoader: false,
        useAuth: useAuth,
        apiVersion: apiVersion,
        showConnectivityError: false,
        showMessage: false);
  }

  Future<ResponseData> postRequestBG(var requestUri, Map map,
      {bool useAuth: true, String responseName: "", bool showLog: true, int apiVersion: 1}) async {
    return await postRequest(null, requestUri, map,
        showError: false,
        showLog: showLog,
        responseName: responseName,
        showLoader: false,
        useAuth: useAuth,
        apiVersion: apiVersion,
        showConnectivityError: false,
        showMessage: false);
  }

  Future<ResponseData> putRequestBG(var requestUri, Map map,
      {bool useAuth: true, String responseName: "", bool showLog: true, int apiVersion: 1}) async {
    return await putRequest(null, requestUri, map,
        showError: false,
        showLog: showLog,
        responseName: responseName,
        showLoader: false,
        useAuth: useAuth,
        apiVersion: apiVersion,
        showConnectivityError: false,
        showMessage: false);
  }

  Future<ResponseData> patchRequestBG(var requestUri, Map map,
      {bool useAuth: true, String responseName: "", bool showLog: true, int apiVersion: 1}) async {
    return await patchRequest(null, requestUri, map,
        showError: false,
        showLog: showLog,
        responseName: responseName,
        showLoader: false,
        useAuth: useAuth,
        apiVersion: apiVersion,
        showConnectivityError: false,
        showMessage: false);
  }

  Future<ResponseData> deleteRequestBG(var requestUri,
      {bool useAuth: true, String responseName: "", bool showLog: true, int apiVersion: 1}) async {
    return await deleteRequest(null, requestUri,
        showError: false,
        showLog: showLog,
        responseName: responseName,
        showLoader: false,
        useAuth: useAuth,
        apiVersion: apiVersion,
        showConnectivityError: false,
        showMessage: false);
  }
}
