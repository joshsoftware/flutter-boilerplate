import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_boilerplate/widgets/alert_bar.dart';

//Identifies Network Availability.
//Automated alert - flag controlled
//Things to change:
//              1. Message Alert widget - can be left default, change as per UI design.
//
class NetworkCheck {
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }

    return false;
  }

  static Future<bool> isOnline(BuildContext context, bool showError) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    debugPrint("No Internet");
    if (showError)
      AlertBar.show(context,
          title: 'No Connectivity', description: 'Please Check Internet Connection', gravity: AlertBar.TOP, backgroundColor: Colors.red);

    return false;
  }

  dynamic checkInternet(Function func) {
    check().then((internet) {
      if (internet != null && internet) {
        func(true);
      } else {
        func(false);
      }
    });
  }
}
