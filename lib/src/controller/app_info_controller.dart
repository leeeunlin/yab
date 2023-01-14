import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoController extends GetxController {
  static AppInfoController get to => Get.find();

  RxString appVersion = ''.obs;
  PackageInfo? packageInfo;

  @override
  void onInit() async {
    getPackageInfo();
    super.onInit();
  }

  // 패키지 정보를 가져오는 함수
  void getPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }
}
