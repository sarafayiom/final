import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:homeworkout_flutter/View/create_challenge.dart';
import 'package:homeworkout_flutter/View/home.dart';
import 'package:homeworkout_flutter/View/signup..dart';

class SplashController extends GetxController {
  Rx waiting = true.obs;
   final box = GetStorage();
  @override
  void onInit() async {
    super.onInit();
   await Future.delayed(Duration(seconds: 2), () {
      waiting.value = false;
     if (box.hasData('access_token')) {
       Get.off(() => TrainingPage());
      // Get.off(() => CreateChallenge());
      } else {
        Get.off(() => SignUp());
      }
    });
  }
    }
