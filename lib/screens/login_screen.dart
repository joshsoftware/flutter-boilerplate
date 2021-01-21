import 'dart:convert';
import 'package:bloc_pattern_flutter_app/bloc/login/LoginBloc.dart';
import 'package:bloc_pattern_flutter_app/models/user.dart';
import 'package:bloc_pattern_flutter_app/screens/home_screen.dart';
import 'package:bloc_pattern_flutter_app/utils/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
                  loginBloc.userLogin(
                      _mobileNoTextFieldController.text,
                      _passwordTextFieldController.text);
              }),
              StreamBuilder(
                  stream: loginBloc.loginCall,
                  builder: (context, AsyncSnapshot<User> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.message != null &&
                          snapshot.data.message != "") {
                        debugPrint("Login error:  " + snapshot.data.message);
                        return Text(snapshot.data.message);
                      } else {
                        debugPrint("User details:  " + snapshot.data.name);

                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                curve: Curves.bounceInOut,
                                child: HomeScreen()));
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
