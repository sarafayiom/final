import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Helpers/loading_helper.dart';
import 'package:homeworkout_flutter/Models/report_model.dart';
import 'package:homeworkout_flutter/Services/api_user_state_controller.dart';

class ReportController extends GetxController {
  var userState = Rxn<ReportModel>();

  final ApiUserState _apiUserState = Get.find<ApiUserState>();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserState();
    });
  }

  Future<void> fetchUserState() async {
  try {
    LoadingHelper.show();
    print("Fetching user state..."); 
    final response = await _apiUserState.getUserState();
    print("Response received"); 
    if (response.isOk) {
      userState.value = ReportModel.fromJson(response.body);
    } else {
      print("Error: ${response.statusText}");
    }
  } catch (e) {
    print("Error: $e");
  } finally {
    LoadingHelper.hide();
  }
}
}
