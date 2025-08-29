// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Controllers/signup_step1_controller.dart';
import 'package:homeworkout_flutter/Models/user_more_details_model.dart';
import 'package:homeworkout_flutter/Services/api_more_details.dart';

class Signup4Controller extends GetxController {
  final  apiMoreDetails = Get.find<ApiMoreDetails>();
  final  signupController = Get.find<SignupController>();
  final selectedgoal = ''.obs;
  final selectedlevel = ''.obs;
  var selectedmusclegroups = <String>[].obs;
  void goalselected(String goalid) {
    selectedgoal.value = goalid;
  }

  void musclegroupsselected(List<String> muscles) {
    selectedmusclegroups.value = [];
  selectedmusclegroups.addAll(muscles);
  }
  bool get isFormValid {
    return selectedgoal.isNotEmpty && selectedlevel.isNotEmpty &&
           selectedmusclegroups.isNotEmpty;
  }
  void levelselected(String levelid) {
    selectedlevel.value = levelid;
  }
  void moreDetails() async {
 final selectedIds = selectedmusclegroups.map((id) => int.parse(id)).toList();

    final details = UserMoreDetailsModel(
      goal: selectedgoal.value,
      musclegroups: selectedIds,
      level: selectedlevel.value,
    );

  final response = await apiMoreDetails.sendMoreDetails(details);
  if (response.statusCode == 200 || response.statusCode == 204) {
    final box = GetStorage();
    box.write("user_more_details", details.toJson());
     signupController.nextPage();
    print("Succses");
  } else {
    print('Feild: ${response.statusCode}');
    print('Response: ${response.body}');
  }
}
  final List<Map<String, String>> goal = [
    {
      "id": "lose_weight",
      "title": "Lose Weight",
      "subtitle": "Focus on fat burning and a calorie deficit routine.",
    },
    {
      "id": "hypertrophy",
      "title": "Hypertrophy",
      "subtitle":"Boost stamina with cardio and long-duration training.",
    },
    {
      "id": "muscles_definition",
      "title": "Muscles Definition",
      "subtitle": "Gain strength and increase muscle mass through resistance training.",
    },
  ];
  final List<Map<String, String>> musclegroups = [
    {"id": "4", "name": "chest"},
    {"id": "3", "name": "back"},
    {"id": "1", "name": "arms"},
    {"id": "2", "name": "legs"},
    {"id": "5", "name": "glutes"},
    {"id": "6", "name": "full_body"},
  ];
   final List<Map<String, String>> level = [
    {
      "id": "beginner",
      "title": "Beginner",
      "subtitle": "New to fitness or returning after a break.",
    },
    {
      "id": "intermediate",
      "title": "Intermediate",
      "subtitle": "Comfortable with regular training.",
    },
    {
      "id": "advanced",
      "title": "Advanced",
      "subtitle": "Consistent training with advanced routines.",
    },
  ];
}
