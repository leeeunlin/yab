import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/repository/attendance_check_repository.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class EventCalendarController extends GetxController {
  static EventCalendarController get to => Get.find();

  var calendarFormat = CalendarFormat.month.obs;
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;
  RxMap<DateTime, dynamic> eventSource = <DateTime, dynamic>{}.obs;

  @override
  void onInit() async {
    bool check = await todayAttendanceCheck();
    if (!check) {
      await createNewItem();

      await getAttendanceData();
    }
    // issues: #52 오늘 출석란이 비어있을 경우 팝업 생성 - ellee
    await attendanceTodayCheck();
    super.onInit();
  }

  List<String> getEventsForDay(DateTime day) {
    List<String> res = [];

    for (DateTime e in eventSource.keys) {
      if (e.month == day.month && e.day == day.day) {
        if (eventSource[e][FIELD_ATTENDANCE_CHECK] == true) {
          res.add(DateFormat('yyyy-MM-dd').format(e).toString());
        }
      }
    }
    return res;
  }

  // SubCollection attendance_check_list에 시간값으로 Document생성
  Future<void> createNewItem() async {
    return await AttendanceCheckRepository.createNewItem();
  }

  // 서버에 연결하여 해당 날짜의 Document가 있는지 확인 후 없으면 생성하고 있으면 생성하지 않음
  Future<bool> todayAttendanceCheck() async {
    return await AttendanceCheckRepository.todayAttendanceCheck();
  }

  // 출석된 날짜 목록을 가져오는 함수
  Future<void> getAttendanceData() async {
    eventSource.value = await AttendanceCheckRepository.getAttendanceData();
  }

  Future<void> setAttendanceData(num point) async {
    final String userKey =
        FirebaseAuth.instance.currentUser!.uid; // 로그인된 유저 키값을 가져 옴

    eventSource[DateFormat('yyyy-MM-dd').parse(DateTime.now().toString())]
        [FIELD_ATTENDANCE_CHECK] = true;

    UserController.to.addMyPoint(userKey, point, 'attendance'); // 출석체크 포인트 지급
    return await AttendanceCheckRepository.setAttendanceData();
  }

  // issues: #52 오늘 출석란이 비어있을 경우 팝업 생성 - ellee
  Future attendanceTodayCheck() async {
    await AttendanceCheckRepository.attendanceTodayCheck();
  }

  setCalendarFormat(CalendarFormat newFormat) =>
      calendarFormat.value = newFormat;

  setFocusedDay(DateTime newDay) => focusedDay.value = newDay;

  setSelectedDay(DateTime newDay) => selectedDay.value = newDay;
}
