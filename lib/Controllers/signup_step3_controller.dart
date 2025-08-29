import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Controllers/signup_step1_controller.dart';
import 'package:homeworkout_flutter/Models/user_basic_info_model.dart';
import 'package:homeworkout_flutter/Services/api_basic_info.dart';
import 'package:intl/intl.dart';

class Signup3Controller extends GetxController {
  final apiBasicInfo = Get.find<ApiBasicInfo>();
  final  signupController = Get.find<SignupController>();
 var datesel = Rx<DateTime?>(null);
  var selectedGender = ''.obs;
  var weight = ''.obs;
  var height= ''.obs ;
  var weightgoal = ''.obs;
final genderItems = ['male', 'female'];
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
  final box = GetStorage();
    box.write("user_basic_info", info.toJson());  
    final savedBasic = box.read('user_basic_info');
    print(savedBasic);
    signupController.nextPage();
    // ignore: avoid_print
    print("Succses");
  } else {
    // ignore: avoid_print
    print("Field ${response.statusCode}");
    // ignore: avoid_print
    print("Response: ${response.body}");
  }
}
}
