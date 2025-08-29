import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/home_controller.dart';
import 'package:homeworkout_flutter/View/home.dart';

class CreateChallenge extends StatelessWidget {
  final homeController = Get.find<HomeController>();
 CreateChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/young-couple-running-free-vector.jpg',
                height: 300,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                await homeController.createChallenge();
                
                    Get.offAll(() => TrainingPage());
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.purple,
                ),
                child: Text(
                  "Let's Get Started",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
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