// event, state => new state => update UI.

import 'dart:io';

import 'package:bloc_pattern_flutter_app/api/exceptions.dart';
import 'package:bloc_pattern_flutter_app/api/login/loginService.dart';
import 'package:bloc_pattern_flutter_app/bloc/login/loginApi.dart';
import 'package:bloc_pattern_flutter_app/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loginEvents.dart';
import 'loginStates.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  //
  final LoginRepo loginRepo;
  User user;

  LoginBloc({this.loginRepo}) : super(LoginInitState());

  @override
  Stream<LoginState> mapEventToState(LoginEvents event) async* {
    switch (event) {
      case LoginEvents.login:
        yield LoginInProcess();
        try {
          if(event is LoginApi){

          }
          user = await loginRepo.doLogin();
          yield LoginDone(user: user);
        } on SocketException {
          yield LoginError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          yield LoginError(
            error: NoServiceFoundException('No Service Found'),
          );
        } on FormatException {
          yield LoginError(
            error: InvalidFormatException('Invalid Response format'),
          );
        } catch (e) {
          yield LoginError(
            error: UnknownException('Unknown Error'),
          );
        }

        break;
    }
  }
}
