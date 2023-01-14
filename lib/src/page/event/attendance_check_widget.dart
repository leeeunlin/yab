import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yab_v2/src/controller/admob_controller.dart';
import 'package:yab_v2/src/controller/calendar_check_controller.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class AttendanceCheckWidget extends GetView<EventCalendarController> {
  const AttendanceCheckWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 일반 출석체크
    void nextPage() async {
      bool checker = controller.eventSource[DateFormat('yyyy-MM-dd')
          .parse(DateTime.now().toString())][FIELD_ATTENDANCE_CHECK];
      if (checker == true) {
        Get.snackbar('출석 중복.', '해당일에 출석이 이미 완료되었습니다.');
      } else {
        await EventCalendarController.to.setAttendanceData(200);
        Get.back();
        Get.snackbar('출석 완료.', '출석포인트가 지급되었습니다.');
      }
    }

    // 광고보고 출석체크
    void rewardNextPage() async {
      bool checker = await controller.eventSource[DateFormat('yyyy-MM-dd')
          .parse(DateTime.now().toString())][FIELD_ATTENDANCE_CHECK];
      if (checker == true) {
        Get.snackbar('출석 중복.', '해당일에 출석이 이미 완료되었습니다.');
      } else {
        if (AdmobController.to.rewardedAd != null) {
          await AdmobController.to.rewardedAd!.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
              await EventCalendarController.to.setAttendanceData(2000);
              Get.back();
              Get.snackbar('출석 완료.', '출석포인트가 지급되었습니다.');
            },
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle:
            false, // android : default값은 왼쪽 정렬 / IOS : default값은 가운데 정렬
        title: const Text('진행중인 이벤트'),
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 10, top: 10),
              width: double.infinity,
              child: Text('출석체크 이벤트', style: Get.textTheme.subtitle1)),
          FutureBuilder(
            future: controller.getAttendanceData(),
            builder: (context, snapshot) {
              return Obx(
                () => Container(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: TableCalendar(
                    locale: "ko_KR",
                    focusedDay: controller.focusedDay.value,
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2050, 1, 1),
                    headerVisible: false,
                    calendarFormat: controller.calendarFormat.value,
                    calendarStyle: CalendarStyle(
                      tableBorder: TableBorder.all(
                        color: Colors.black38,
                        style: BorderStyle.solid,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      markerSizeScale: 1.0,
                      markersMaxCount: 1,
                      markersAutoAligned: false,
                      markersAlignment: Alignment.center,
                      markerDecoration: const BoxDecoration(
                        image: DecorationImage(
                          image: (AssetImage('assets/images/logo/check.png')),
                        ),
                      ),
                      outsideDaysVisible: false,
                      canMarkersOverflow: true,
                    ),
                    selectedDayPredicate: (day) {
                      return isSameDay(controller.selectedDay.value, day);
                    },
                    onFormatChanged: (format) {
                      controller.setCalendarFormat(format);
                    },
                    onPageChanged: (focusedDay) {
                      controller.setFocusedDay(focusedDay);
                      controller.setSelectedDay(focusedDay);
                    },
                    eventLoader: (day) {
                      day = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(day
                          .toString()); //DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(day);
                      // logger.i(day);
                      return controller.getEventsForDay(day);
                    },
                  ),
                ),
              );
            },
          ),
          Container(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.ondemand_video,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "광고보고 2,000YAB 받기",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onPressed: () async {
                rewardNextPage();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
            width: double.infinity,
            child: ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(width: 5),
                  Text("200YAB 받고 출석하기"),
                ],
              ),
              onPressed: () async {
                nextPage();
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    '출석체크는 KST(00:00) 기준으로 초기화 됩니다.',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    '매일 한번씩 광고를 보고 출석체크 포인트를 받아가세요.\n앞으로 추가될 포인트 관련 서비스가 많이 있습니다.\n많은 기대 부탁 드립니다.',
                    style: Get.textTheme.bodyText1,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
