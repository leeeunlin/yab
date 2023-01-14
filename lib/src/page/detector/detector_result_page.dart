import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/app.dart';
import 'package:yab_v2/src/controller/bottom_navigation_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';
import 'package:yab_v2/src/model/user_info/children.dart';
import 'package:yab_v2/src/model/user_info/gender.dart';
import 'package:yab_v2/src/model/user_info/maritalstatus.dart';
import 'package:yab_v2/src/model/user_info/nationality.dart';
import 'package:yab_v2/src/size_config.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class DetectorResultPage extends GetView<UserInfoDetectorController> {
  const DetectorResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###'); // 숫자 자르기

    LayoutBuilder detectorResultImageList() {
      return LayoutBuilder(
        builder: (context, constraints) {
          Size _size = Get.size;
          var imageSize =
              (_size.width / 3) - getProportionateScreenWidth(20) * 2;
          var imageCorner = 16.0;
          return SizedBox(
            height: _size.width / 3,
            width: _size.width,
            child: Obx(
              () => ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.grey,
                          ),
                          Obx(
                            () => Text(
                              "${controller.imagesController.length}/5",
                              style: Get.theme.textTheme.subtitle2,
                            ),
                          ),
                        ],
                      ),
                      width: imageSize,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(imageCorner),
                          border: Border.all(color: Colors.grey, width: 1)),
                    ),
                  ),
                  ...List.generate(
                    controller.imagesController.length,
                    (index) => Padding(
                      padding:
                          const EdgeInsets.only(right: 20, top: 20, bottom: 20),
                      child: ExtendedImage.memory(
                        controller.imagesController[index],
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.cover,
                        loadStateChanged: (state) {
                          switch (state.extendedImageLoadState) {
                            case LoadState.loading:
                              return Container(
                                child: const CircularProgressIndicator(),
                                width: imageSize,
                                height: imageSize,
                                padding: EdgeInsets.all(imageSize / 3),
                              );
                            case LoadState.completed:
                              return null;
                            case LoadState.failed:
                              return const Icon(Icons.cancel);
                          }
                        },
                        borderRadius: BorderRadius.circular(imageCorner),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    Container detectorResultContainer(String title, String value) {
      return Container(
        padding: const EdgeInsets.all(10),
        width: Get.size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Get.theme.textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(value),
            ),
            const Divider(
              height: 0,
              thickness: 1,
            )
          ],
        ),
      );
    }

    Container detectorVSResultContainer(String title) {
      return Container(
        padding: const EdgeInsets.all(10),
        width: Get.size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Get.theme.textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.detectorUserModel.value.detail![0],
                      style: Get.theme.textTheme.subtitle2),
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "VS",
                        style: Get.theme.textTheme.subtitle1,
                      )),
                  Text(controller.detectorUserModel.value.detail![1],
                      style: Get.theme.textTheme.subtitle2)
                ],
              ),
            ),
          ],
        ),
      );
    }

    Container detectorMultiResultContainer(String title) {
      return Container(
        padding: const EdgeInsets.all(10),
        width: Get.size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Get.theme.textTheme.subtitle1,
            ),
            for (var i = 0;
                i < controller.detectorUserModel.value.detail!.length;
                i++)
              Container(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${i + 1}번 항목',
                      style: Get.theme.textTheme.subtitle1,
                    ),
                    Text(controller.detectorUserModel.value.detail![i],
                        style: Get.theme.textTheme.subtitle2)
                  ],
                ),
              ),
          ],
        ),
      );
    }

    // Home으 이동 하면서 네비게이션 컨트롤러 초기화 및 detector 컨트롤러 초기화
    void goHomePageInit() async {
      controller.isResultPageLoading.value = false; // 로딩 끝
      controller.detectorControllerInit(); // detector 컨트롤러 초기화
      BottomNavigationController.to.offAllPage(0); // navigation 컨트롤러 초기화
      await Get.offAll(const App()); // 히스토리 삭제 후 App으로 이동
    }

    void nextPage() async {
      // 메시지 전송
      controller.isResultPageLoading.value = true; // 로딩 시작
      await controller.sendDetectorModeltoServer(); // 결과 페이지의 모든 행위를 하는 함수
      UserController.to
          .updateSubCoin(controller.detectorUserModel.value.fullPrice!);
      await Future.delayed(const Duration(
          seconds:
              5)); // 서버에서 처리시간이 있기 때문에 기다려야함... callback을 사용할 수 있으면 해결될거 같음

      Get.snackbar('전송 완료.', '해당 내용이 전송되었습니다.'); // 전송하고 FCM메시지 보내기

      goHomePageInit();
    }

    void detectorDialog(num totalPrice) async {
      await Get.defaultDialog(
        title: '작성 결과',
        middleText:
            '총 ${f.format(totalPrice)}YAB을 사용하여\n글을 게시합니다.\n\n진행 하시겠습니까?',
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.black.withOpacity(0),
                  shadowColor: Colors.black.withOpacity(0)),
              onPressed: () {
                Get.back(); // 팝업창 닫기
              },
              child: const Text('아니오')),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.black.withOpacity(0),
                  shadowColor: Colors.black.withOpacity(0)),
              onPressed: () {
                Get.back(); // 팝업창 닫기
                // 날짜 비교 함수
                if (controller.reservationDateSelectedValue.value.isNotEmpty) {
                  num selectTimeComparison = num.parse(
                      DateFormat('yyyyMMddkkmm').format(DateTime.parse(
                          controller.reservationDateSelectedValue.value)));
                  num todayTimeComparison = num.parse(
                      DateFormat('yyyyMMddkkmm').format(DateTime.now()));
                  if (selectTimeComparison < todayTimeComparison) {
                    Get.snackbar('예약 시간 확인', '예약시간은 현재시간 이후로 지정하세요');
                    return;
                  } else {
                    nextPage();
                  }
                } else {
                  nextPage();
                }
              },
              child: const Text('예')),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('최종 확인'),
      ),
      body: SingleChildScrollView(
        // 내용이 길어질 경우 스크롤이 안되어 singlechildscrollview로 생성함
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 필터 업데이트 이후 수정 필수 (전체 항목이 안나옴)
            Column(
              children: [
                ExpansionTile(
                  title: const Text('기본 정보'),
                  collapsedBackgroundColor: Colors.amber[200],
                  backgroundColor: Colors.amber[200],
                  initiallyExpanded: false,
                  textColor: Colors.black,
                  iconColor: Colors.black,
                  children: [
                    //issues: #44 생년월일에 따른 연령 필터생성 -ellee
                    detectorResultContainer(
                        '연령',
                        controller.detectorUserModel.value.birth == 'all'
                            ? '전체'
                            : controller.detectorUserModel.value.birth == '10'
                                ? '${controller.detectorUserModel.value.birth}대 이하'
                                : controller.detectorUserModel.value.birth ==
                                        '60'
                                    ? '${controller.detectorUserModel.value.birth}대 이상'
                                    : '${controller.detectorUserModel.value.birth}대'),
                    detectorResultContainer(
                        '학력',
                        controller.detectorUserModel.value.education == 'all'
                            ? '전체'
                            : controller.detectorUserModel.value.education ==
                                    'Elementary'
                                ? '초등학교 졸업'
                                : controller.detectorUserModel.value
                                            .education ==
                                        'Middle'
                                    ? '중학교 졸업'
                                    : controller.detectorUserModel.value
                                                .education ==
                                            'High'
                                        ? '고등학교 졸업'
                                        : controller.detectorUserModel.value
                                                    .education ==
                                                'JuniorCollege'
                                            ? '전문학사'
                                            : controller.detectorUserModel.value
                                                        .education ==
                                                    'University'
                                                ? '학사'
                                                : controller.detectorUserModel
                                                            .value.education ==
                                                        'Master'
                                                    ? '석사'
                                                    : '박사'),
                    detectorResultContainer(
                        '성별',
                        controller.detectorUserModel.value.gender != 'all'
                            ? genderMapEngToKor[
                                controller.detectorUserModel.value.gender]!
                            : '전체'),
                    detectorResultContainer(
                        '국적',
                        controller.detectorUserModel.value.nationality != 'all'
                            ? nationalityMapEngToKor[
                                controller.detectorUserModel.value.nationality]!
                            : '전체'),
                    detectorResultContainer(
                        '결혼 유무',
                        controller.detectorUserModel.value.maritalstatus !=
                                'all'
                            ? maritalstatusMapEngToKor[controller
                                .detectorUserModel.value.maritalstatus]!
                            : '전체'),
                    detectorResultContainer(
                        '자녀 유무',
                        controller.detectorUserModel.value.children != 'all'
                            ? childrenMapEngToKor[
                                controller.detectorUserModel.value.children]!
                            : '전체'),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(
                  height: 0,
                  thickness: 1,
                ),
                const SizedBox(height: 5),
              ],
            ),

            Container(
              child: !controller.bodyHeightFilter.value &&
                      !controller.bodyWeightFilter.value &&
                      !controller.bodyVisionFilter.value &&
                      controller.bodyBloodType.value == 'all' &&
                      !controller.bodyFootSizeFilter.value
                  ? Container()
                  : Column(
                      children: [
                        ExpansionTile(
                          title: const Text('신체 정보'),
                          initiallyExpanded: false,
                          collapsedBackgroundColor: Colors.amber[200],
                          backgroundColor: Colors.amber[200],
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          children: [
                            // issues: #41 신체정보 이상, 이하 UI선택 및 적용 - ellee
                            if (controller.bodyHeightFilter.value)
                              detectorResultContainer('키',
                                  '${controller.detectorUserModel.value.heightStart}cm ~ ${controller.detectorUserModel.value.heightEnd}cm'),
                            if (controller.bodyWeightFilter.value)
                              detectorResultContainer('몸무게',
                                  '${controller.detectorUserModel.value.weightStart}kg ~ ${controller.detectorUserModel.value.weightEnd}kg'),
                            if (controller.bodyVisionFilter.value)
                              detectorResultContainer('시력',
                                  '좌 ${controller.detectorUserModel.value.rightVisionStart?.toStringAsFixed(1)} ~ ${controller.detectorUserModel.value.rightVisionEnd?.toStringAsFixed(1)} 우 ${controller.detectorUserModel.value.rightVisionStart?.toStringAsFixed(1)} ~ ${controller.detectorUserModel.value.rightVisionEnd?.toStringAsFixed(1)}'),
                            if (controller.bodyBloodType.value != 'all')
                              detectorResultContainer('혈액형',
                                  '${controller.detectorUserModel.value.bloodType}'),
                            if (controller.bodyFootSizeFilter.value)
                              detectorResultContainer('신발 사이즈',
                                  '${controller.detectorUserModel.value.footSizeStart}mm ~ ${controller.detectorUserModel.value.footSizeEnd}mm'),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Divider(
                          height: 0,
                          thickness: 1,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
            ),
            Container(
              child: !controller.healthTabaccoFilter.value &&
                      controller.healthAlcohol.value == 'all' &&
                      !controller.healthExerciseFilter.value
                  ? Container()
                  : Column(
                      children: [
                        ExpansionTile(
                          title: const Text('건강 정보'),
                          initiallyExpanded: false,
                          collapsedBackgroundColor: Colors.amber[200],
                          backgroundColor: Colors.amber[200],
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          children: [
                            // issues: #41 신체정보 이상, 이하 UI선택 및 적용 - ellee
                            if (controller.healthTabaccoFilter.value)
                              detectorResultContainer('흡연량',
                                  '${controller.detectorUserModel.value.healthTabaccoStart?.floor()}개피 ~ ${controller.detectorUserModel.value.healthTabaccoEnd?.floor()}개피'),
                            if (controller.healthAlcohol.value != 'all')
                              detectorResultContainer(
                                  '주량',
                                  controller.detectorUserModel.value
                                              .healthAlcohol ==
                                          'all'
                                      ? '주량: 전체'
                                      : controller.detectorUserModel.value
                                                  .healthAlcohol ==
                                              '0'
                                          ? '주량: 마시지 않음'
                                          : controller.detectorUserModel.value
                                                      .healthAlcohol ==
                                                  '1'
                                              ? '주량: 1병 이하'
                                              : controller
                                                          .detectorUserModel
                                                          .value
                                                          .healthAlcohol ==
                                                      '2'
                                                  ? '주량: 2병'
                                                  : controller
                                                              .detectorUserModel
                                                              .value
                                                              .healthAlcohol ==
                                                          '3'
                                                      ? '주량: 3병 이상'
                                                      : ''),
                            if (controller.healthExerciseFilter.value)
                              detectorResultContainer('운동량',
                                  '${controller.detectorUserModel.value.healthExerciseStart?.floor()}시간 ~ ${controller.detectorUserModel.value.healthExerciseEnd?.floor()}시간'),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Divider(
                          height: 0,
                          thickness: 1,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
            ),
            Container(
              child: controller.personalityMBTIAll.value &&
                      controller.personalityStarSignAll.value
                  ? Container()
                  : Column(
                      children: [
                        ExpansionTile(
                          title: const Text('성격 정보'),
                          initiallyExpanded: false,
                          collapsedBackgroundColor: Colors.amber[200],
                          backgroundColor: Colors.amber[200],
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          children: [
                            // issues: #51 성격정보 결과 페이지 적용 - ellee
                            if (!controller.personalityMBTIAll.value)
                              detectorResultContainer(
                                  'MBTI',
                                  controller
                                      .detectorUserModel.value.personalityMBTI
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', '')),
                            if (!controller.personalityStarSignAll.value)
                              detectorResultContainer(
                                  '별자리',
                                  controller.detectorUserModel.value
                                      .personalityStarSign
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', '')
                                      .replaceAll('Aquarius', '물병자리')
                                      .replaceAll('Pisces', '물고기자리')
                                      .replaceAll('Aries', '양자리')
                                      .replaceAll('Taurus', '황소자리')
                                      .replaceAll('Gemini', '쌍둥이자리')
                                      .replaceAll('Cancer', '게자리')
                                      .replaceAll('Leo', '사자자리')
                                      .replaceAll('Virgo', '처녀자리')
                                      .replaceAll('Libra', '천칭자리')
                                      .replaceAll('Scorpio', '전갈자리')
                                      .replaceAll('Sagittarius', '사수자리')
                                      .replaceAll('Capricorn', '염소자리')),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Divider(
                          height: 0,
                          thickness: 1,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
            ),
            Container(
              child: controller.economicPropertyAll.value &&
                      controller.economicCarAll.value &&
                      controller.economicCarFuelAll.value
                  ? Container()
                  : Column(
                      children: [
                        ExpansionTile(
                          title: const Text('재산 정보'),
                          initiallyExpanded: false,
                          collapsedBackgroundColor: Colors.amber[200],
                          backgroundColor: Colors.amber[200],
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          children: [
                            // issues: #51 성격정보 결과 페이지 적용 - ellee
                            if (!controller.economicPropertyAll.value)
                              detectorResultContainer(
                                  '부동산',
                                  controller
                                      .detectorUserModel.value.economicProperty
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', '')
                                      .replaceAll('MyHouse', '자가')
                                      .replaceAll('Jeonse', '전ㆍ월세')),
                            if (!controller.economicCarAll.value)
                              detectorResultContainer(
                                  '차량',
                                  controller.detectorUserModel.value.economicCar
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', '')
                                      .replaceAll('MyCar', '자차')
                                      .replaceAll('RentCar', '렌트')
                                      .replaceAll('LeaseCar', '리스')),
                            if (!controller.economicCarFuelAll.value)
                              detectorResultContainer(
                                  '차량 연료',
                                  controller
                                      .detectorUserModel.value.economicCarFuel
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', '')
                                      .replaceAll('Electric', '전기')
                                      .replaceAll('Gasolin', '휘발유')
                                      .replaceAll('Diesel', '경유')),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Divider(
                          height: 0,
                          thickness: 1,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
            ),

            detectorResultContainer(
                '제목', controller.detectorUserModel.value.title!),
            if (controller.detectorUserModel.value.mode == DATA_PROMOTION)
              detectorResultContainer(
                  '내용', controller.detectorUserModel.value.detail![0]),
            if (controller.detectorUserModel.value.mode == DATA_VS)
              detectorVSResultContainer('내용'),
            if (controller.detectorUserModel.value.mode == DATA_MULTIPLE)
              detectorMultiResultContainer('내용'),
            if (controller.detectorUserModel.value.mode == DATA_PROMOTION)
              detectorResultImageList(),
            detectorResultContainer(
                '인원', controller.paymentPeople.value.text.toString()),
            detectorResultContainer(
                '가격', controller.paymentPrice.value.text.toString()),
            if (controller.expiredDaySelectedValue.value.isNotEmpty)
              detectorResultContainer('만료일',
                  '${(DateFormat('yyyy-MM-dd HH:mm').format(controller.detectorUserModel.value.createdDate!)).toString()} ~ ${(DateFormat('yyyy-MM-dd HH:mm').format(controller.detectorUserModel.value.expiredDate!)).toString()}'),
            if (controller.reservationExpiredDateSelectedValue.value.isNotEmpty)
              detectorResultContainer('예약일',
                  '${(DateFormat('yyyy-MM-dd HH:mm').format(controller.detectorUserModel.value.reservationDate!)).toString()} ~ ${(DateFormat('yyyy-MM-dd HH:mm').format(controller.detectorUserModel.value.expiredDate!)).toString()}'),
            detectorResultContainer('지출 YAB  (인원 * 가격)',
                '${int.parse(controller.paymentPeople.value.text) * int.parse(controller.paymentPrice.value.text)}YAB'),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                  "위 사항으로 내용을 전달하며, \n게시물이 제출되면 되돌릴 수 없습니다.\n계속 하시려면 보내기 버튼을 눌러주세요",
                  style: Get.theme.textTheme.subtitle2),
            ),
            SizedBox(
              child: Obx(
                () => InkWell(
                  child: controller.isResultPageLoading.value
                      // ? Container(
                      //     width: double.infinity,
                      //     height: 50,
                      //     color: Colors.blue,
                      //     child: const Center(
                      //       child: SizedBox(
                      //         width: 20,
                      //         height: 20,
                      //         child: CircularProgressIndicator(
                      //           // center 내부에 인디케이터가 들어가지 않을 경우 깨지는 현상 발생
                      //           backgroundColor: Colors.blue,
                      //           color: Colors.white,
                      //           strokeWidth: 4,
                      //         ),
                      //       ),
                      //     ),
                      //   )

                      ? Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber),
                          child: const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                // center 내부에 인디케이터가 들어가지 않을 경우 깨지는 현상 발생
                                backgroundColor: Colors.blue,
                                color: Colors.white,
                                strokeWidth: 4,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber),
                          child: const Center(
                            child: Text('보내기',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17)),
                          ),
                        ),
                  onTap: () async {
                    detectorDialog(
                        int.parse(controller.paymentPeople.value.text) *
                            int.parse(controller.paymentPrice.value.text));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
