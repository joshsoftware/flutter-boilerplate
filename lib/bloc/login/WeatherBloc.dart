import 'package:bloc_pattern_flutter_app/models/user.dart';
import 'package:bloc_pattern_flutter_app/persistance/Repository.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc {
  Repository _repository = Repository();

  final _weatherFetcher = PublishSubject<User>();

  Observable<User> get weather => _weatherFetcher.stream;

  fetchLondonWeather() async {
    User weatherResponse = await _repository.fetchLondonWeather();
    _weatherFetcher.sink.add(weatherResponse);
  }

  dispose() {
    _weatherFetcher.close();
  }
}

final weatherBloc = WeatherBloc();