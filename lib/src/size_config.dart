import 'package:get/get.dart';

double getProportionateScreenHeight(double inputHeight) {
  return (inputHeight / 812.0) * Get.height;
}

double getProportionateScreenWidth(double inputWidth) {
  return (inputWidth / 375.0) * Get.width;
}
