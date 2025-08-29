import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Models/wallet_model.dart';
import 'api_refresh_token.dart';

class ApiWallet extends GetConnect {
  final box = GetStorage();
  final apiRefreshToken = Get.find<ApiRefreshToken>();

  @override
  void onInit() {
    httpClient.baseUrl = "http://91.144.22.63:4567/api"; 
    super.onInit();
  }

  Future<Map<String, String>> getHeaders() async {
    final token = box.read('access_token');
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Wallet?> fetchWallet() async {
    var headers = await getHeaders();

    Response response = await get('/wallet/', headers: headers)
        .timeout(Duration(seconds: 10));

    if (response.statusCode == 401) {
      bool refreshed = await apiRefreshToken.refreshToken();
      if (refreshed) {
        headers = await getHeaders();
        response = await get('/wallet/', headers: headers)
            .timeout(Duration(seconds: 10));
      }
    }

    if (response.statusCode == 200 && response.body != null) {
      return Wallet.fromJson(response.body);
    } else {
      return null;
    }
  }
}
