import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Controllers/signup_step1_controller.dart';
import 'package:homeworkout_flutter/Models/user_basic_info_model.dart';
import 'package:homeworkout_flutter/Models/user_complete_profile_model.dart';
import 'package:homeworkout_flutter/Models/user_more_details_model.dart';
import 'package:homeworkout_flutter/Models/wallet_model.dart';
import 'package:homeworkout_flutter/Services/api_basic_info.dart';
import 'package:homeworkout_flutter/Services/api_complete_profile_model.dart';
import 'package:homeworkout_flutter/Services/api_more_details.dart';
import 'package:intl/intl.dart';

class EditProfileController extends GetxController {
  final box = GetStorage();
  final apiBasicInfo = Get.find<ApiBasicInfo>();
  final signupController = Get.find<SignupController>();
  final apiMoreDetails = Get.find<ApiMoreDetails>();
  final apiCompleteProfile = Get.find<ApiCompleteProfile>();

  // Rx variables
  var datesel = Rx<DateTime?>(null);
  var selectedGender = ''.obs;
  var weight = ''.obs;
  var height = ''.obs;
  var weightgoal = ''.obs;
  final genderItems = ['male', 'female'];
  final selectedgoal = ''.obs;
  final selectedlevel = ''.obs;
  var selectedmusclegroups = <String>[].obs;
  var sucsess = false;
  var timesel = Rx<DateTime?>(null);
  var selecteddaysgroups = <String>[].obs;

  // TextEditingControllers
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final weightGoalController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadStoredData();
  }

  void loadStoredData() {
  final savedBasic = box.read('user_basic_info');
  if (savedBasic != null) {
    selectedGender.value = savedBasic['gender'] ?? '';
    datesel.value = savedBasic['date_of_birth'] != null
        ? DateTime.tryParse(savedBasic['date_of_birth'])
        : null;
    weight.value = savedBasic['weight']?.toString() ?? '';
    height.value = savedBasic['height']?.toString() ?? '';
    weightgoal.value = savedBasic['weight_goal']?.toString() ?? '';
  }

  final savedMore = box.read('user_more_details');
  if (savedMore != null) {
    selectedgoal.value = savedMore['goal'] ?? '';
    selectedlevel.value = savedMore['level'] ?? '';
    selectedmusclegroups.value = savedMore['focused_muscle_groups'] != null
        ? List<String>.from(savedMore['focused_muscle_groups'].map((e) => e.toString()))
        : <String>[];
  }

  final savedComplete = box.read('user_complete_profile');
  if (savedComplete != null) {
    selecteddaysgroups.value = savedComplete['workout_days'] != null
        ? List<String>.from(savedComplete['workout_days'])
        : <String>[];

    // تحويل الوقت من String إلى DateTime
    final timeStr = savedComplete['workout_time_per_day'];
if (timeStr != null && timeStr.isNotEmpty) {
  final parts = timeStr.split(':');
  if (parts.length >= 2) {
    timesel.value = DateTime(
      2000,
      1,
      1,
      int.parse(parts[0]),
      int.parse(parts[1]),
      parts.length == 3 ? int.parse(parts[2]) : 0,
    );
  }
}
  }

  // Debug: تأكد من القيم المحملة
  print("Loaded complete profile: ${box.read('user_complete_profile')}");
  print("timesel.value = ${timesel.value}");
}

  void setGender(String value) {
    selectedGender.value = value;
  }

  void date(DateTime? date) {
    datesel.value = date;
  }

  bool get isFormValid {
    return selectedGender.value.isNotEmpty &&
        datesel.value != null &&
        weight.value.isNotEmpty &&
        height.value.isNotEmpty &&
        weightgoal.value.isNotEmpty;
  }

  void basicInfo() async {
    final info = UserBasicInfoModel(
      gender: selectedGender.value,
      dateofbirth: DateFormat('yyyy-MM-dd').format(datesel.value!),
      height: int.parse(height.value),
      weight: int.parse(weight.value),
      goalweight: int.parse(weightgoal.value),
    );

    final response = await apiBasicInfo.updateUserBasicInfo(info);
    if (response.statusCode == 200 || response.statusCode == 204) {
      box.write("user_basic_info", info.toJson());
      print("Success");
    } else {
      print("Failed: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  }

  void goalselected(String goalid) {
    selectedgoal.value = goalid;
  }

  void musclegroupsselected(List<String> muscles) {
    selectedmusclegroups.value = [];
    selectedmusclegroups.addAll(muscles);
  }

  bool get isFormValid1 {
    return selectedgoal.isNotEmpty &&
        selectedlevel.isNotEmpty &&
        selectedmusclegroups.isNotEmpty;
  }

  void levelselected(String levelid) {
    selectedlevel.value = levelid;
  }

  void moreDetails() async {
    final selectedIds =
        selectedmusclegroups.map((id) => int.parse(id)).toList();

    final details = UserMoreDetailsModel(
      goal: selectedgoal.value,
      musclegroups: selectedIds,
      level: selectedlevel.value,
    );

    final response = await apiMoreDetails.sendMoreDetails(details);
    if (response.statusCode == 200 || response.statusCode == 204) {
      box.write("user_more_details", details.toJson());
      print("Success");
    } else {
      print('Failed: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

  void daygroupsselected(List<String> days) {
    selecteddaysgroups.value = [];
    selecteddaysgroups.addAll(days);
  }

  void time(DateTime? time) {
    timesel.value = time;
  }

  bool get isFormValid2 {
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
      box.write("user_complete_profile", details.toJson());
      print("Success");
    } else {
      print("Failed: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  }

  // بيانات ثابتة
  final List<Map<String, String>> daygroups = [
    {"name": "Monday"},
    {"name": "Tuesday"},
    {"name": "Wednesday"},
    {"name": "Thursday"},
    {"name": "Friday"},
    {"name": "Saturday"},
    {"name": "Sunday"},
  ];

  final List<Map<String, String>> goal = [
    {
      "id": "lose_weight",
      "title": "Lose Weight",
      "subtitle": "Focus on fat burning and a calorie deficit routine.",
    },
    {
      "id": "hypertrophy",
      "title": "Hypertrophy",
      "subtitle": "Boost stamina with cardio and long-duration training.",
    },
    {
      "id": "muscles_definition",
      "title": "Muscles Definition",
      "subtitle":
          "Gain strength and increase muscle mass through resistance training.",
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
