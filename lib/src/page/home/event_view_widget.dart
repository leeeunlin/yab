import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/bottom_navigation_controller.dart';
import 'package:yab_v2/src/controller/event_controller.dart';
import 'package:yab_v2/src/page/event/attendance_check_widget.dart';

final List<String> eventImgPath = [
  "assets/images/event/1.png",
  "assets/images/event/2.png",
  "assets/images/event/3.png",
];

class EventViewWidget extends GetView<EventController> {
  EventViewWidget({Key? key}) : super(key: key);

  final pages = List.generate(
    3, // 이벤트 페이지 그림을 여러개 넣을 경우 해당 숫자 수정 필요
    (index) => InkWell(
      onTap: () async {
        if (eventImgPath[index] == "assets/images/event/3.png") {
          await Get.to(() => const AttendanceCheckWidget());
        } else {
          BottomNavigationController.to.offAllPage(1);
        }
      },
      child: SizedBox(
        child: ExtendedImage.asset(
          eventImgPath[index],
          fit: BoxFit.fill,
          borderRadius: BorderRadius.circular(20),
          shape: BoxShape.rectangle,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    controller.pageLength.value = eventImgPath.length;
    return SingleChildScrollView(
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                height: Get.size.height * 0.2,
                child: PageView.builder(
                  pageSnapping: true,
                  itemCount: eventImgPath.length,
                  controller: controller.pageController.value,
                  itemBuilder: (_, index) {
                    return pages[index % pages.length];
                  },
                  onPageChanged: (value) {
                    controller.currentPage.value = value + 1;
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white38, borderRadius: BorderRadius.circular(20)),
            child: Obx(
              () => Text(
                '${controller.currentPage.value} / ${controller.pageLength.value}',
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
