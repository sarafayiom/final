import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  PageController controller = PageController();
  RxInt currentPage = 0.obs;
  bool isAnimating = false;

  void goToPage(int index) async {
    if (isAnimating) return;
    isAnimating = true;
    await controller.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    isAnimating = false;
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    final current = currentPage.value;
    if (current < 4) {
      goToPage(current + 1);
    }
  }

  void previousPage() {
    final current = currentPage.value;
    if (current > 0) {
      goToPage(current - 1);
    }
  }

  String get buttonText {
    switch (currentPage.value) {
      case 0:
        return "Get Started";
      case 4:
        return "Done";
      default:
        return "Next";
    }
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}