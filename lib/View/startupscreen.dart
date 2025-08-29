// // ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/startupscreen_controller.dart';
class StartupScreen extends StatelessWidget {
  final splashController = Get.find<SplashController>();
   StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
  return  Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/image/StartUp.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
  }
}
