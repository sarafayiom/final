import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/signup_step1_controller.dart';
import 'package:homeworkout_flutter/Controllers/signup_step2_controller.dart';

class SignupStep2 extends StatelessWidget {
  final signup2Controller = Get.find<Signup2Controller>();
  final signupController =  Get.find<SignupController>();
   SignupStep2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: signup2Controller.key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
  if (signupController.currentPage.value > 0) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(Icons.arrow_back,weight: 40,),
        onPressed: () {
          signupController.previousPage();
        },
      ),
    );
  } else {
    return SizedBox.shrink();
  }
}),
                  Text(
                    "Let's start this journey",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                  ),
                  Image.asset(
                    "assets/image/StartUp2.jpg",
                    width: screenWidth * 0.6,
                  ),
                  Row(
                    children: [
                     Flexible(flex: 8,
                        child: TextFormField(
                          controller: signup2Controller.userNameController,
                          maxLength: 20,
                          validator: signup2Controller.validateUsername,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            filled: true,
                            fillColor: const Color.fromARGB(20, 100, 100, 100),
                            labelText: "Username",
                            hintText: "Username",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(flex: 2,child:
                      Image.asset(
                        "assets/image/download5.png",
                     width: MediaQuery.of(context).size.width * 0.2,
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(flex: 2 , child:
                      Image.asset(
                        "assets/image/download3.png",
                       width: MediaQuery.of(context).size.width * 0.2,
                      ),),
                      SizedBox(width: 10),
                     Flexible(flex: 8,
                        child: TextFormField(
                          controller: signup2Controller.userEmilController,
                          validator: signup2Controller.validateEmail,
                          decoration: InputDecoration(
                            labelText: "Email",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            filled: true,
                            fillColor: const Color.fromARGB(20, 100, 100, 100),
                            hintText: "Email",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Flexible(flex: 8,
                        child: Obx(
                          () => TextFormField(
                            controller: signup2Controller.passwordController,
                            validator: signup2Controller.validatePassword,
                            obscureText: !signup2Controller.button.value,
                            smartQuotesType: signup2Controller.isSmart(),
                            decoration: InputDecoration(
                              suffixIcon: signup2Controller.smartquotestype(
                                  signup2Controller.button.value),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(20, 100, 100, 100),
                              labelText: "Password",
                              hintText: "Password",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(flex: 2,child:
                      Image.asset(
                        "assets/image/key.png",
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),)
                    ],
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: signup2Controller.confirmPasswordController,
                    validator: signup2Controller.validateConfirmPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      filled: true,
                      fillColor: const Color.fromARGB(20, 100, 100, 100),
                      labelText: "Confirm Password",
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
