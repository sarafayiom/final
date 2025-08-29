import 'dart:convert';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Models/otp_verify_model.dart';
import 'package:homeworkout_flutter/Models/user_register_model.dart';

class ApiRegister extends GetConnect{
  @override
  ApiRegister() {
  baseUrl = "http://91.144.22.63:4567/api";

  httpClient.timeout = const Duration(seconds: 20);

  httpClient.addRequestModifier<void>((request) {
    return request;
  });

  httpClient.addResponseModifier<void>((request, response) {
    
    return response;
  });
}
Future<Response> registerUser(UserRegisterModel user) {
  return post(
    '/register/',
   jsonEncode(user.toJson()),
    headers: {
      'Content-Type': 'application/json',
    },
  );
}
 Future<Response> verifyOtp(OtpVerifyModel data) {
    return post(
      '/verify-otp/',
      data.toJson(),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }
}