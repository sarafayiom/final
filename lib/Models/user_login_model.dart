class UserLoginModel {
  String email;
  String password;
final String? fcmToken;
  UserLoginModel({
    required this.email,
    required this.password, this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
     'fcm_token': fcmToken,
    };
  }
}