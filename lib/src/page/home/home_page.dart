import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/controller/receive_board_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/page/event/attendance_check_widget.dart';
import 'package:yab_v2/src/page/home/not_found_page.dart';
import 'package:yab_v2/src/page/home/point_info_widget.dart';
import 'package:yab_v2/src/page/home/event_view_widget.dart';
import 'package:yab_v2/src/page/home/trade_list_widget.dart';
import 'package:yab_v2/src/page/my/economicinfo/user_economicinfo_page.dart';
import 'package:yab_v2/src/page/my/personalityinfo/user_personalityinfo_page.dart';
import 'package:yab_v2/src/page/my/userbasicinfo/user_basicinfo_page.dart';
import 'package:yab_v2/src/page/my/userbodyinfo/user_bodyinfo_page.dart';
import 'package:yab_v2/src/page/my/usereducationinfo/user_educationinfo_page.dart';

class HomePage extends GetView<UserController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<void>(
          future: controller.getUser(AuthController
              .to.userModel.value.userKey!), // 유저 키값을 먼저 불러와서 팝업창을 생성하게 만든다.
          builder: (context, snapshot) {
            return Container(
              child: _homePageList(),
            );
          },
        ),
      ),
    );
  }

  // 뱃지 페이지를 나누려고 하였으나 FutureBuilder를 두번 사용해야하는 상황 발생,
  // 불필요하게 User를 두번 호출해야하는 상황이라 한 페이지에 모든 코드 작성함
  // 차후 해당 페이지 분리 필요
  Container achievementsList() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            spreadRadius: 1.0,
            offset: Offset(
              2,
              2,
            ),
          ),
        ],
      ),
      child: Obx(
        () => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    await Get.to(() => const UserBasicInfoPage());
                  },
                  child: Center(
                    child: Image.asset(
                      controller.userBasicInfoCount.value < 7
                          ? 'assets/images/icons/basicinfo_null.png'
                          : 'assets/images/icons/basicinfo.png',
                      width: Get.size.width / 5,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Get.to(() => const UserBodyInfoPage());
                  },
                  child: Center(
                    child: Image.asset(
                      controller.userBodyInfoCount.value < 5
                          ? 'assets/images/icons/bodyinfo_null.png'
                          : 'assets/images/icons/bodyinfo.png',
                      width: Get.size.width / 5,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Get.to(() => const NotFoundPage());
                  },
                  child: Center(
                    child: Image.asset(
                      'assets/images/icons/carinfo_null.png',
                      width: Get.size.width / 5,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Get.to(() => const UserEconomicInfoPage());
                  },
                  child: Center(
                    child: Image.asset(
                      controller.userEconomicInfoCount.value < 2
                          ? 'assets/images/icons/economicinfo_null.png'
                          : 'assets/images/icons/economicinfo.png',
                      width: Get.size.width / 5,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    await Get.to(() => const UserEducationInfoPage());
                  },
                  child: Center(
                    child: Image.asset(
                      controller.userEducationInfoCount.value < 1
                          ? 'assets/images/icons/educationinfo_null.png'
                          : 'assets/images/icons/educationinfo.png',
                      width: Get.size.width / 5,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Get.to(() => const NotFoundPage());
                  },
                  child: Center(
                    child: Image.asset(
                      'assets/images/icons/fashioninfo_null.png',
                      width: Get.size.width / 5,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Get.to(() => const NotFoundPage());
                  },
                  child: Center(
                    child: Image.asset(
                      'assets/images/icons/foodinfo_null.png',
                      width: Get.size.width / 5,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Get.to(() => const UserBodyInfoPage());
                  },
                  child: Center(
                    child: Image.asset(
                      controller.userBodyInfoCount.value < 3
                          ? 'assets/images/icons/healthinfo_null.png'
                          : 'assets/images/icons/healthinfo.png',
                      width: Get.size.width / 5,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    await Get.to(() => const NotFoundPage());
                  },
                  child: Center(
                    child: Image.asset(
                      'assets/images/icons/hobbyinfo_null.png',
                      width: Get.size.width / 5,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Get.to(() => const NotFoundPage());
                  },
                  child: Center(
                    child: Image.asset(
                      'assets/images/icons/jobinfo_null.png',
                      width: Get.size.width / 5,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Get.to(() => const PersonalityInfoPage());
                  },
                  child: Center(
                    child: Image.asset(
                      controller.userPersonalityInfoCount.value < 2
                          ? 'assets/images/icons/personalityinfo_null.png'
                          : 'assets/images/icons/personalityinfo.png',
                      width: Get.size.width / 5,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await Get.to(() => const NotFoundPage());
                  },
                  child: Center(
                    child: Image.asset(
                      'assets/images/icons/politicalinfo_null.png',
                      width: Get.size.width / 5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget alertDialog() {
    return AlertDialog(
      title: const Text('출첵하러 가지 않을래?'),
      content: const Text(
          '오늘 출석을 하지 않으셨어요,\n매일매일 출석체크하고\nYAB포인트 받아가세요.\n\n바로 출석하러 갈까요?'),
      actions: <Widget>[
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.black.withOpacity(0),
                shadowColor: Colors.black.withOpacity(0)),
            onPressed: () async {
              controller.startInPopup.value = true;
              // await Get.offAll(const App());
            },
            child: const Text('아니오')),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.black.withOpacity(0),
                shadowColor: Colors.black.withOpacity(0)),
            onPressed: () async {
              controller.startInPopup.value = true;
              // await Get.offAll(const App());
              await Get.to(() => const AttendanceCheckWidget());
            },
            child: const Text('예')),
      ],
    );
  }

  Widget _homePageList() {
    BannerAd banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {},
        onAdLoaded: (_) {},
      ),
      size: AdSize.banner,
      adUnitId: kReleaseMode
          ? GetPlatform.isIOS
              ? 'ca-app-pub-2175953775265407/9945158612'
              : 'ca-app-pub-2175953775265407/5827069760'
          : GetPlatform.isIOS
              ? 'ca-app-pub-3940256099942544/6300978111'
              : 'ca-app-pub-3940256099942544/6300978111',
      request: const AdRequest(),
    )..load();

    return SafeArea(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              // ElevatedButton(
              //   onPressed: () async {
              //     const taskId =
              //         "projects/selldyyab/locations/asia-northeast3/queues/firestore-ttl/tasks/2858851905057845528";
              //     const userKey = "key";
              //     const boardId = "boardId";
              //     final HttpsCallableResult result = await FirebaseFunctions
              //         .instance
              //         .httpsCallable('test')
              //         .call(<String, dynamic>{
              //       'taskId': taskId,
              //       'userKey': userKey,
              //       'boardId': boardId
              //     });
              //     logger.i(result.data);
              //   },
              //   child: const Text('테스트버튼'),
              // ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      EventViewWidget(),
                      const PointInfoWidget(),
                      const TradeListWidget(),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        child: const AutoSizeText.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: '획득한 뱃지',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black)),
                              TextSpan(
                                text: '   뱃지 획득 방식은 점점 더 추가될 예정이에요',
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: double.infinity,
                        child: achievementsList(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: banner.size.width.toDouble(),
                height: banner.size.height.toDouble(),
                child: AdWidget(ad: banner),
              ),
            ],
          ),

          // issues: #52 메인화면 팝업부분 사망식으로 수정
          Obx(
            () => Container(
                child: !controller.attendanceToday.value &&
                        !controller.startInPopup.value
                    ? alertDialog()
                    : Container()),
          ),
          Obx(
            () => ReceiveBoardController.to.firstLoading.value
                ? Container()
                : Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: const Color.fromRGBO(158, 158, 158, 0.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              // center 내부에 인디케이터가 들어가지 않을 경우 깨지는 현상 발생
                              backgroundColor: Colors.white,
                              color: Colors.grey,
                              strokeWidth: 5,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: const Text(
                            '유저정보 로딩중...',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
