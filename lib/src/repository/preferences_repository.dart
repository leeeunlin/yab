import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  static Future<bool> firstStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool check =
        (prefs.getBool('firstStart') ?? true); // 최초 실행하여 값이 없으면 true로 지정
    return check;
  }
}
