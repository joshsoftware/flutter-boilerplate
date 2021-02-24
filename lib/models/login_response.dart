class LoginResponse {
  String token;
  String error;

  LoginResponse({this.token,this.error});

  factory LoginResponse.fromJson(Map<String, dynamic> parsedJson) {
    return LoginResponse(
      token: parsedJson['token'] != null ? parsedJson['token'] : "",
      error: parsedJson['error'] != null ? parsedJson['error'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = this.token;
    data['error'] = this.error;
    return data;
  }
}