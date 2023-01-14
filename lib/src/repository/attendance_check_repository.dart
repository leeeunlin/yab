import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/model/attendance_model.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

final String userKey =
    FirebaseAuth.instance.currentUser!.uid; // 로그인된 유저 키값을 가져 옴

class AttendanceCheckRepository {
  static Future<void> setAttendanceData() async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(SUB_COL_ATTENDANCE_CHECK_LIST)
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()));

    await docRef.update({FIELD_ATTENDANCE_CHECK: true});
  }

  static Future<Map<DateTime, dynamic>> getAttendanceData() async {
    CollectionReference docRef = FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(SUB_COL_ATTENDANCE_CHECK_LIST);

    QuerySnapshot<Object?> querySnapshot = await docRef.get();

    Map<DateTime, dynamic> values = {};

    querySnapshot.docs.map((e) {
      values[DateTime.parse(e.id)] = e.data();
    }).toList();

    return values;
  }

  static Future<void> createNewItem() async {
    await FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(SUB_COL_ATTENDANCE_CHECK_LIST)
        .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()))
        .set(AttendanceModel().toMap());
  }

  static Future<bool> todayAttendanceCheck() async {
    final today = DateTime.now();

    CollectionReference docRef = FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(SUB_COL_ATTENDANCE_CHECK_LIST);

    QuerySnapshot<Object?> querySnapshot = await docRef.get();

    final dataTimeList =
        querySnapshot.docs.map((e) => DateTime.parse(e.id)).toList();
    final sameDay = dataTimeList.where((date) => areSameDay(date, today));

    if (sameDay.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  // issues: #52 오늘 출석란이 비어있을 경우 팝업 생성 - ellee
  static Future<void> attendanceTodayCheck() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection(COL_USERS)
        .doc(userKey)
        .collection(SUB_COL_ATTENDANCE_CHECK_LIST)
        .where(
            '${DateFormat('yyyy-MM-dd').format(DateTime.now())}.$FIELD_ATTENDANCE_CHECK')
        .get();
    querySnapshot.docs
        .map((doc) => UserController.to.attendanceToday.value =
            doc[FIELD_ATTENDANCE_CHECK])
        .elementAt(0);
  }
}

bool areSameDay(DateTime one, DateTime two) {
  return one.day == two.day && one.month == two.month && one.year == two.year;
}
