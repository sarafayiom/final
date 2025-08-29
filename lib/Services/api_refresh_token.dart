import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ApiRefreshToken extends GetConnect{
   @override
  void onInit() {
    httpClient.baseUrl = "http://91.144.22.63:4567/api";
    super.onInit();
  }
  final box = GetStorage();
Future<bool> refreshToken() async {
    final refreshToken = box.read('refresh_token') ?? '';
    if (refreshToken.isEmpty) return false;

    final response = await post(
      '/token/refresh/',
      {'refresh': refreshToken},
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final newAccessToken = response.body['access'];
      box.write('access_token', newAccessToken);
      return true;
    } else {
      return false;
    }
  }

}