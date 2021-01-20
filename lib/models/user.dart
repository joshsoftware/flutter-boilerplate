class User {
  int id;
  String status;
  String auth_token;
  String role;
  String name;
  int state_id;
  int city_id;

//  List<Child> users = new List();

  User({this.id, this.name, this.role, this.status, this.auth_token, this.state_id, this.city_id}); //, this.users});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
//    var users = parsedJson["users"];
    return User(
      id: parsedJson['id']  != null ? parsedJson['id'] : 0,
      name: parsedJson['name'] != null ? parsedJson['name'] : "",
      role: parsedJson['role']  != null ? parsedJson['role'] : "",
      status: parsedJson['status']  != null ? parsedJson['status'] : "",
      auth_token: parsedJson['auth_token']  != null ? parsedJson['auth_token'] : "",
      state_id: parsedJson['state_id']  != null ? parsedJson['state_id'] : 0,
      city_id: parsedJson['city_id']  != null ? parsedJson['city_id'] : 0,
    );
  }


  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'role': role,
    'status': status,
    'auth_token': auth_token,
    'state_id': state_id,
    'city_id': city_id
  };
}
