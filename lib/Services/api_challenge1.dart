import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class HomeApiService {
  final Dio _dio = Dio();
  final box = GetStorage();

  Future<bool> checkDayAvailability(int challengeId, int day) async {
    final token = box.read("access_token");
    print(challengeId);
    try {
      final response = await _dio.get(
        'http://91.144.22.63:4567/boss/check-day-availability/$challengeId/$day',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        final isAvailable = response.data['is_available'] == true;
        print(" Day Available Response: ${response.data}");
        return isAvailable;
      } else if (response.statusCode == 400) {
        print(" Day not available (Bad Request): ${response.data}");
        return false;
      } else if (response.statusCode == 404) {
        print("Day not found: ${response.data}");
        return false;
      } else {
        print(" Unexpected status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print(" Error checking day availability: $e");
      return false;
    }
  }
}