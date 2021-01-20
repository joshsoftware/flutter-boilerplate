import 'package:bloc_pattern_flutter_app/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitState extends LoginState {}

class LoginInProcess extends LoginState {}

class LoginDone extends LoginState {
  final User user;
  LoginDone({this.user});
}

class LoginError extends LoginState {
  final error;
  LoginError({this.error});
}
