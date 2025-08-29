import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/login_controller.dart';

class LogIn extends StatelessWidget {
   final loginController = Get.find<LoginController>();
   LogIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Form(key: loginController.key,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        "assets/image/barbel.png",
                        height: 150,
                        width: 150,
                      ),
                      Text(
                        "LOG IN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 30),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      TextFormField(
                        controller: loginController.userEmailController,
                        validator: loginController.validateEmail,
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
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => TextFormField(
                          controller: loginController.passwordController,
                          validator: loginController.validatePassword,
                          obscureText: !loginController.button.value,
                          smartQuotesType: loginController.isSmart(),
                          decoration: InputDecoration(
                            suffixIcon: loginController
                                .smartquotestype(loginController.button.value),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            filled: true,
                            fillColor: const Color.fromARGB(20, 100, 100, 100),
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
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            minimumSize: Size(320, 40),
                            foregroundColor: Colors.white,
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                            backgroundColor: Colors.deepPurple.shade500),
                        onPressed: () {
                          if (loginController.key.currentState!.validate()) {
                            loginController.login(loginController.userEmailController.text, loginController.passwordController.text);
                          }
                          else{
                            final snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                                title: 'Error!',
                                message: "Please Enter your Email and Password correctly!",
                                contentType: ContentType.failure));
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                          }
                        },
                        child: Text("LOG IN"),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "__________________",
                              style: TextStyle(
                                  color: Colors.deepPurple.shade400,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("OR"),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "__________________",
                              style: TextStyle(
                                  color: Colors.deepPurple.shade400,
                                  fontWeight: FontWeight.w600),
                            ),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dont have an account ?",
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              " Sign Up",
                              style: TextStyle(
                                  color: Colors.deepPurple.shade500,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.deepPurple.shade500),
                            ),
                          )
                        ],
                      )
                    ])))));
  }
}
