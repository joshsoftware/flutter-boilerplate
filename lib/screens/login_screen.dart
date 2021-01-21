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

    weatherBloc.fetchLondonWeather();
    return StreamBuilder(
        stream: weatherBloc.weather,
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            debugPrint("User details:  " + snapshot.data.name);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
