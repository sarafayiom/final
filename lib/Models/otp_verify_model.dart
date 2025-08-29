class OtpVerifyModel {
  String email;
  String otp;

  OtpVerifyModel({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}
