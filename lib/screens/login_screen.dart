import 'dart:convert';
import 'package:bloc_pattern_flutter_app/api/album/albumService.dart';
import 'package:bloc_pattern_flutter_app/bloc/album/bloc.dart';
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

  bool isLoading = false;

  final _emailMobTextFieldController = TextEditingController();
  final _passwordMobTextFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _doLogin() async {
    context.bloc<LoginBloc>().add(LoginEvents.login);
    //debugPrint("Inside _doLogin()");
  }

  void submitLoginFormData() {
    if (_emailMobTextFieldController.text.length <= 0) {
      _emailMobTextFieldController.text = "";
      return;
    }
    if (_passwordMobTextFieldController.text.length <= 0) {
      return;
    }
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    debugPrint("width: $width , height: $height");

    return Scaffold(
      body: Container(
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgrounds/gray_city.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/backgrounds/car_curve_background.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: width > 550 ? height / 3.5 : height / 7),
                    child: Image.asset(
                      "assets/images/logos/logo.png",
                      width: 160,
                      height: 180,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: RoundedTextField(
                        keyboardType: TextInputType.emailAddress,
                        hint: "Email/Mobile",
                        controller: _emailMobTextFieldController,
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: RoundedTextField(
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        hint: "Password",
                        controller: _passwordMobTextFieldController,
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                      /*child: isLoading
                          ? SpinKitFadingCircle(
                        color: Constant.colorPurpleLight,
                        duration: Duration(milliseconds: 200),
                        size: 40,
                      )*/
                      child: RoundedButton(
                          title: "Login",
                          parentAction: () {
                            _doLogin();
                            //submitLoginFormData();
                          })),
                  BlocBuilder<LoginBloc, LoginState>(
                      builder: (BuildContext context, LoginState state) {
                    if (state is LoginError) {
                      final error = state.error;
                      String message = '${error.message}\nTap to Retry.';
                      return ErrorTxt(
                        message: message,
                        //onTap: _loadAlbums,
                      );
                    }
                    if (state is LoginInProcess) {
                      SpinKitFadingCircle(
                        color: Constant.colorPurpleLight,
                        duration: Duration(milliseconds: 200),
                        size: 40,
                      );
                    }
                    if (state is LoginDone) {
                      User user = state.user;
                      if (user != null)
                        SharedPreferencesHelper.setUserJson(jsonEncode(user));
                      /*home: BlocProvider(
                        create: (context) => AlbumsBloc(albumsRepo: AlbumServices()),
                        child: AlbumsScreen(),
                      );*/
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              curve: Curves.bounceInOut,
                              child: HomeScreen()));
                      //return user;
                    }
                    //return Loading();
                  }),
                  Padding(
                      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              //NavigationHelper.goToForgotPasswordPage(context);
                            },
                            child: Container(
                                height: 20,
                                child: Text(
                                  "Forgot Password ?",
                                  style: TextStyle(
                                    color: Constant.colorDarkGray,
                                    fontSize: 15,
                                    fontFamily: Constant.fontMyraidPro,
                                  ),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              //NavigationHelper.goToRegistrationPage(context);
                            },
                            child: Container(
                                height: 20,
                                child: Text(
                                  "    Register",
                                  style: TextStyle(
                                    color: Constant.colorPurpleDark,
                                    fontSize: 16,
                                    fontFamily: Constant.fontMyraidPro,
                                  ),
                                )),
                          )
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
