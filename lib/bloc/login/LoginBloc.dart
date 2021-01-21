import 'package:bloc_pattern_flutter_app/models/user.dart';
import 'package:bloc_pattern_flutter_app/api/login/LoginRepository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  Repository _repository = Repository();

  final _doLogin = PublishSubject<User>();

  Observable<User> get loginCall => _doLogin.stream;

  userLogin(String userName, String mobNo) async {
    User loginResponse = await _repository.doUserLogin(userName, mobNo);
    _doLogin.sink.add(loginResponse);
  }

  dispose() {
    _doLogin.close();
  }
}

final loginBloc = LoginBloc();