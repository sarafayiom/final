import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Models/user_basic_info_model.dart';
import 'package:homeworkout_flutter/Services/api_refresh_token.dart';

class ApiBasicInfo extends GetConnect {
  final box = GetStorage();
   final apiRefreshToken = Get.find<ApiRefreshToken>();
  @override
  void onInit() {
    httpClient.baseUrl = "http://91.144.22.63:4567";
    super.onInit();
  }

  Future<Map<String, String>> getHeaders() async {
    final token = box.read('access_token') ?? '';
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> updateUserBasicInfo(UserBasicInfoModel info) async {
    var headers = await getHeaders();

    var response = await patch(
      '/profile/basic-info/',
      info.toJson(),
      headers: headers,
    );

    if (response.statusCode == 401) {
      bool refreshed = await apiRefreshToken.refreshToken();
      if (refreshed) {
        headers = await getHeaders();
        response = await patch(
          '/profile/basic-info/',
          info.toJson(),
          headers: headers,
        );
      }
    }
    return response;
  }
}