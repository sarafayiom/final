import 'package:get/get.dart';
import 'package:homeworkout_flutter/Models/user_challenge_model.dart';
import 'package:homeworkout_flutter/Services/api_user_challenge.dart';

class HomeController extends GetxController {
  Rx<UserChallengeModel?> userChallenges = UserChallengeModel().obs;
  var isLoading = false.obs;
  @override
  void onInit() {
   getUserData();
    super.onInit();
  }

 Future<void> getUserData() async {
    try {
      isLoading.value = true;
      userChallenges.value = await ApiUserChallenge().getAllChallenges();
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createChallenge() async {
    try {
      isLoading.value = true;
      bool success = await ApiUserChallenge().generateChallenge();
      if (success) {
        await getUserData();
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
