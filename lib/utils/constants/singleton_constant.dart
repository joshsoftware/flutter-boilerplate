class SingletonConstants {
  static SingletonConstants _instance;

  factory SingletonConstants() => _instance ??= new SingletonConstants._();

  SingletonConstants._();

  String token;
  int id;
}
