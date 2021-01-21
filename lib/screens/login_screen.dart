import 'dart:convert';
import 'package:bloc_pattern_flutter_app/api/album/albumService.dart';
import 'package:bloc_pattern_flutter_app/bloc/album/bloc.dart';
import 'package:bloc_pattern_flutter_app/bloc/login/WeatherBloc.dart';
import 'package:bloc_pattern_flutter_app/bloc/login/loginBloc.dart';
import 'package:bloc_pattern_flutter_app/bloc/login/loginEvents.dart';
import 'package:bloc_pattern_flutter_app/bloc/login/loginStates.dart';
import 'package:bloc_pattern_flutter_app/models/user.dart';
import 'package:bloc_pattern_flutter_app/screens/home_screen.dart';
import 'package:bloc_pattern_flutter_app/utils/Constant.dart';
import 'package:bloc_pattern_flutter_app/utils/SharedPreferencesHelper.dart';
import 'package:bloc_pattern_flutter_app/utils/page_transition.dart';
import 'package:bloc_pattern_flutter_app/widgets/error.dart';
import 'package:bloc_pattern_flutter_app/widgets/roundedButton.dart';
import 'package:bloc_pattern_flutter_app/widgets/textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'albums_screen.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double height, width;
  String emailMob, password;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _mobileNoTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool submitLoginFormData(BuildContext mContext) {
    SnackBar snackBar;
    if (_mobileNoTextFieldController.text.length <= 0) {
      snackBar = SnackBar(content: Text('Please enter username'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return false;
    }
    if (_passwordTextFieldController.text.length <= 0) {
      snackBar = SnackBar(content: Text('Please enter password'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: TextField(
                  maxLength: 10,
                  controller: _mobileNoTextFieldController,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    // to hide max length value
                    border: InputBorder.none,
                    hintText: "Username.",
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                    ),
                    hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  cursorColor: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: TextField(
                  maxLength: 10,
                  controller: _passwordTextFieldController,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    // to hide max length value
                    border: InputBorder.none,
                    hintText: "Password",
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                    ),
                    hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  cursorColor: Colors.white,
                ),
              ),
              RaisedButton(onPressed: () {
                Text("");
                if (submitLoginFormData(context))
                  weatherBloc.fetchLondonWeather(
                      _mobileNoTextFieldController.text,
                      _passwordTextFieldController.text);
              }),
              StreamBuilder(
                  stream: weatherBloc.weather,
                  builder: (context, AsyncSnapshot<User> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.message != null &&
                          snapshot.data.message != "") {
                        debugPrint("Login error:  " + snapshot.data.message);
                        return Text(snapshot.data.message);
                      } else {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                curve: Curves.bounceInOut,
                                child: AlbumsScreen()));
                        debugPrint("User details:  " + snapshot.data.name);
                      }
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    /*else {
                      debugPrint("Login error:  Some error");
                      return Text("Some error occurred");
                    }*/
                    return Center();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
