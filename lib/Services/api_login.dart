import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Models/user_login_model.dart';

class ApiLogin extends GetConnect {
  @override
  void onInit() {
    baseUrl = "http://91.144.22.63:4567/api";
    super.onInit();
  }

  Future<Response> loginuser(UserLoginModel user) {
    return post(
      '/login/',
      jsonEncode(user.toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }


  Future<String?> refreshToken() async {
    final String refreshToken = GetStorage().read('refresh_token') ?? '';

    if (refreshToken.isEmpty) {
      return null;
    }

    final response = await post(
      '/refresh-token/',
      {'refresh_token': refreshToken},
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final newToken = response.body['access_token'];
      GetStorage().write('access_token', newToken);
      return newToken;
    } else {
      return null;
    }
  }
}
