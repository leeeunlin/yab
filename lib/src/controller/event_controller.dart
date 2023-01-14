import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  static EventController get to => Get.find();

  RxBool progressEvent = false.obs;
  RxBool endEvent = false.obs;

  RxInt currentPage = 1.obs;
  RxInt pageLength = 0.obs;
  var pageController = PageController(initialPage: 0).obs;
  void sendInit() {
    progressEvent = true.obs;
    endEvent = false.obs;
  }

  @override
  void onInit() async {
    Timer.periodic(
      const Duration(seconds: 5),
      (Timer timer) {
        if (currentPage < pageLength.value) {
          currentPage++;
        } else {
          currentPage.value = 1;
        }
        pageController.value.animateToPage(currentPage.value - 1,
            duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
      },
    );
    super.onInit();
  }
}
