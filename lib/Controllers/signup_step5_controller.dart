import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Models/user_complete_profile_model.dart';
import 'package:homeworkout_flutter/Services/api_complete_profile_model.dart';

class Signup5Controller extends GetxController {
  var sucsess = false;
  final apiCompleteProfile = Get.find<ApiCompleteProfile>();
  var timesel = Rx<DateTime?>(null);
  var selecteddaysgroups = <String>[].obs;
  void daygroupsselected(List<String> days) {
    selecteddaysgroups.value = [];
    selecteddaysgroups.addAll(days);
  }

  void time(DateTime? time) {
    timesel.value = time;
  }

  bool get isFormValid {
    return selecteddaysgroups.isNotEmpty && timesel.value != null;
  }

  void submitCompleteProfile() async {
    String workoutTime =
        '${timesel.value?.hour.toString().padLeft(2, '0')}:${timesel.value?.minute.toString().padLeft(2, '0')}:${timesel.value?.second.toString().padLeft(2, '0')}';

    final details = UserCompleteProfileModel(
      workoutdays: selecteddaysgroups,
      workouttimeperday: workoutTime,
    );

    final response = await apiCompleteProfile.sendCompleteProfile(details);

    if (response.statusCode == 200 || response.statusCode == 204) {
      final box = GetStorage();
    box.write("user_complete_profile", details.toJson());
      sucsess = true;
      // ignore: avoid_print
      print("Succses");
    } else {
      // ignore: avoid_print
      print("Feild: ${response.statusCode}");
      // ignore: avoid_print
      print("Response: ${response.body}");
    }
  }

  final List<Map<String, String>> daygroups = [
    {"name": "Monday"},
    {"name": "Tuesday"},
    {"name": "Wednesday"},
    {"name": "Thursday"},
    {"name": "Friday"},
    {"name": "Saturday"},
    {"name": "Sunday"},
  ];
}
