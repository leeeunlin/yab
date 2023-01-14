import 'package:get/get.dart';
import 'package:yab_v2/src/repository/preferences_repository.dart';

class PreferencesController extends GetxController {
  static PreferencesController get to => Get.find();
  Future<bool> firstStart() async {
    return PreferencesRepository.firstStart();
  }
}
