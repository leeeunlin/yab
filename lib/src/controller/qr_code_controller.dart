import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';

class QRCodeController extends GetxController {
  static QRCodeController get to => Get.find();

  final _qrCodeData = ''.obs;
  RxString userKey = ''.obs;
  RxString receivePoint = '0'.obs;
  RxString receivePeePoint = '0'.obs;

  TextEditingController qrContentEditingController = TextEditingController();
  set userQrCodeData(value) => _qrCodeData.value = value;
  get userQrCodeData => _qrCodeData.value;

  final _isGapless = false.obs;
  set isGapless(value) => _isGapless.value = value;
  get isGapless => _isGapless.value;

  @override
  void onInit() {
    userKey.value = AuthController.to.userModel.value.userKey!;
    userQrCodeData = userKey.value; // UserKey값을 QRCode로 만들기 위한 데이터
    super.onInit();
  }

  void cleanController() {
    qrContentEditingController.clear();
    receivePoint.value = "0";
  }
}
