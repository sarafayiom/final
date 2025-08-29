class UserRegisterModel {
  String username;
  String email;
  String password;

  UserRegisterModel({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'password': password,
    };
  }
}
