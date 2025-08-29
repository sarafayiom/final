import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Controllers/login_controller.dart';
import 'package:homeworkout_flutter/Controllers/signup_step1_controller.dart';
import 'package:homeworkout_flutter/Helpers/loading_helper.dart';
import 'package:homeworkout_flutter/Models/otp_verify_model.dart';
import 'package:homeworkout_flutter/Models/user_register_model.dart';
import 'package:homeworkout_flutter/Services/api_register.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../Services/api_otp.dart';

class Signup2Controller extends GetxController {
  final apiRegister = Get.find<ApiRegister>();
  final apiOtp = Get.find<ApiOtp>();
  final signupController = Get.find<SignupController>();
  final loginController = Get.find<LoginController>();
  final userNameController = TextEditingController();
  final userEmilController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final key = GlobalKey<FormState>();
  final RxBool button = false.obs;
  var isOtpVerified = false.obs;
  final box = GetStorage();
  late final Image gifImage;
  final RxBool _isSendingOtp = false.obs;
  Widget smartquotestype(bool thisbutton) {
    if (thisbutton == true) {
      return IconButton(
          onPressed: () {
            button.value = false;
          },
          icon: Icon(Icons.visibility_off));
    } else {
      return IconButton(
          onPressed: () {
            button.value = true;
          },
          icon: Icon(Icons.visibility));
    }
  }

  SmartQuotesType isSmart() {
    return button.value ? SmartQuotesType.enabled : SmartQuotesType.disabled;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Username cannot be empty";
    }
    if (value.length < 3) {
      return "Name cannot be less than 3 characters";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm password cannot be empty";
    }
    if (value != passwordController.text) {
      return "The two passwords must match";
    }
    return null;
  }

  Future<void> userRegister() async {
    LoadingHelper.show();

    final user = UserRegisterModel(
      username: userNameController.text.trim(),
      email: userEmilController.text.trim(),
      password: passwordController.text.trim(),
    );

    final response = await apiRegister.registerUser(user);

    LoadingHelper.hide();

    if (response.statusCode == 201) {
      var email = user.email;
      var password = user.password;
      box.write('email', email);
      box.write('password', password);
      _showVerificationDialog(user.email);
    } else {
      final data = response.body;

      if (data != null && data is Map<String, dynamic>) {
        String errorMessage = "Error";

        if (data.containsKey('email')) {
          errorMessage = data['email'][0];
        } else if (data.containsKey('username')) {
          errorMessage = data['username'][0];
        } else if (data.containsKey('password')) {
          errorMessage = data['password'][0];
        }
        Get.snackbar("Error", errorMessage);
      }
    }
  }

  void _showVerificationDialog(String email) {
    final verificationCodeController = TextEditingController();

    Get.dialog(
        barrierDismissible: false,
        AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child:
                    Lottie.asset('assets/animation/verfiy.json', height: 150),
              ),
              SizedBox(height: 8),
              Text(
                "Enter the code sent to $email",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Container(
            constraints: BoxConstraints(
              maxWidth: 300,
              maxHeight: 100,
            ),
            child: PinCodeTextField(
              controller: verificationCodeController,
              appContext: Get.context!,
              length: 6,
              obscureText: false,
              keyboardType: TextInputType.number,
              animationType: AnimationType.scale,
              onChanged: (value) {},
              onCompleted: (value) async {
                await _verifyOtpAndProceed(email, value);
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.deepPurple.shade400),
              ),
            ),
            TextButton(
              onPressed: () {
                resendOtp();
              },
              child: Text(
                "Resend the code",
                style: TextStyle(color: Colors.deepPurple.shade400),
              ),
            ),
          ],
        ));
  }

  Future<void> _verifyOtpAndProceed(String email, String otp) async {
    String password = box.read('password');
    final otpVerifyModel = OtpVerifyModel(
      email: email,
      otp: otp,
    );

    final response = await ApiOtp().verifyOtp(otpVerifyModel);

    if (response.statusCode == 200) {
      loginController.logingfirsttime = true;
      loginController.login(email, password);
      Get.snackbar("Succes", "Verified successfully");
      if (Get.isDialogOpen ?? false) {
        Get.back(closeOverlays: true);
      }
      signupController.nextPage();
    } else {
      String errorMessage = "Try again";
      Get.snackbar("Error", errorMessage);
    }
  }

  Future<void> resendOtp() async {
    if (_isSendingOtp.value) return;
    _isSendingOtp.value = true;
    String email = box.read('email');

    try {
      final response = await apiOtp.resendOtp(email);
      if (response.statusCode == 200) {
        Get.snackbar("Sent successfully", "We sent the code to $email");
      } else {
        final body = response.body;
        String errorMsg = "Error";

        if (body is Map<String, dynamic> && body.containsKey('detail')) {
          errorMsg = body['detail'];
        }

        Get.snackbar("Error", errorMsg);
      }
    } catch (e) {
      // ignore: avoid_print
      print("Somthing went wrong while sending the OTP: $e");
      Get.snackbar("Error", "Failed to connect to the server Try again");
    }
  }

  @override
  void onClose() {
    userNameController.dispose();
    userEmilController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }
}
