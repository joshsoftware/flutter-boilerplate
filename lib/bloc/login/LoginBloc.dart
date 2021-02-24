import 'package:bloc_pattern_flutter_app/models/login_response.dart';
import 'package:bloc_pattern_flutter_app/api/login/LoginRepository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  Repository _repository = Repository();

  final _doLogin = PublishSubject<LoginResponse>();

  Stream<LoginResponse> get loginCall => _doLogin.stream;

  userLogin(String userName, String mobNo) async {
    LoginResponse loginResponse =
        await _repository.doUserLogin(userName, mobNo);
    _doLogin.sink.add(loginResponse);
  }

  dispose() {
    _doLogin.close();
  }
}

final loginBloc = LoginBloc();
