class UserModel {
  final String email;
  final int id;
  final String firstName;
  final String lastName;
  final String avatar;

  UserModel({this.email, this.firstName, this.lastName, this.avatar, this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] != null ? json['email'] : "",
      id: json['id'] != null ? json['id'] : 0,
      firstName: json['first_name'] != null ? json['first_name'] : "",
      lastName: json['last_name'] != null ? json['last_name'] : "",
      avatar: json['avatar'] != null ? json['avatar'] : "",
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'avatar': avatar,
      };
}
