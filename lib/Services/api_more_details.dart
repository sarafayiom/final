
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Models/user_more_details_model.dart';
import 'package:homeworkout_flutter/Services/api_refresh_token.dart';

class ApiMoreDetails extends GetConnect {
  final box = GetStorage();

  final ApiRefreshToken apiRefreshToken = Get.find<ApiRefreshToken>();

  ApiMoreDetails() {
    httpClient.baseUrl = "http://91.144.22.63:4567";
  }

  Map<String, String> get headers {
    final token = box.read('access_token') ?? '';
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> sendMoreDetails(UserMoreDetailsModel data) async {
    var response = await patch(
      "/profile/more-details/",
      data.toJson(),
      headers: headers,
    );

    if (response.statusCode == 401) {
      bool refreshed = await apiRefreshToken.refreshToken();
      if (refreshed) {
        response = await patch(
          "/profile/more-details/",
          data.toJson(),
          headers: headers,
        );
      }
    }

    return response;
  }
}
