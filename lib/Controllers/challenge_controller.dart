import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Services/api_challenge1.dart';

class ChallengeController extends GetxController {
  final HomeApiService _homeApiService = HomeApiService();
  final box = GetStorage();

  RxInt availableDays = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCachedDay(); 
    fetchAvailableDaysFromServer(); 
  }

  void loadCachedDay() {
    int cachedDay =
        box.read('cachedAvailableDays') ?? 1; 
    availableDays.value = cachedDay;
  }

  Future<void> fetchAvailableDaysFromServer(int challengeId) async {
    int challengeId = box.read('idchallenge') ?? 1;

    int latestAvailable = 1;

    try {
      for (int day = 1; day <= 28; day++) {
        bool isAvailable =
            await _homeApiService.checkDayAvailability(challengeId, day);
        if (isAvailable) {
          latestAvailable = day;
        } else {
          break;
        }
      }

      availableDays.value = latestAvailable;
      box.write('cachedAvailableDays', latestAvailable);
    } catch (e) {
      print('Error fetching available days: $e');
    }
  }
}
