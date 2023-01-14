import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yab_v2/src/controller/send_board_controller.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';
import 'package:yab_v2/src/page/detector/select_user_body_info_page.dart';
import 'package:yab_v2/src/page/detector/select_user_economic_info_page.dart';
import 'package:yab_v2/src/page/detector/select_user_health_info_page.dart';
import 'package:yab_v2/src/page/detector/select_user_info_page.dart';
import 'package:yab_v2/src/page/detector/select_user_personality_info_page.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class DetectorMainPage extends GetView<UserInfoDetectorController> {
  const DetectorMainPage({Key? key}) : super(key: key);

  void detectorDialog(int dectorCount) async {
    await Get.defaultDialog(
      title: '검색 결과',
      middleText: '선택한 조건에 맞는 ' +
          dectorCount.toString() +
          ' 명이\n검색되었습니다.\n\n계속 진행하시겠습니까?',
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
        if (dectorCount > 0) // 검색결과 창에서 카운트된 인원수가 0 이라면 예 버튼 생성하지 않음
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.black.withOpacity(0),
                shadowColor: Colors.black.withOpacity(0)),
            onPressed: () async {
              if (SendBoardController.to.repeatWrite.value == false) {
                controller.setModeSelected(DATA_PROMOTION);
                Get.back(); // 팝업창 닫기
                await Get.toNamed('/SelectWriteModePage');
              } else {
                Get.back();
                repeatWriteDialog();
              }
            },
            child: const Text('예'),
          ),
      ],
    );
  }

  void repeatWriteDialog() async {
    await Get.defaultDialog(
        title: '게시글 다시 보내기',
        middleText:
            '게시글을 다시 보냅니다.\n카테고리를 변경할 경우\n내용이 초기화 됩니다.\n\n일반 게시물의 사진은\n다시 업로드 해주세요',
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.black.withOpacity(0),
                shadowColor: Colors.black.withOpacity(0)),
            onPressed: () async {
              Get.back(); // 팝업창 닫기
              await Get.toNamed('/SelectWriteModePage');
            },
            child: const Text('예'),
          ),
        ]);
  }

  void nextPage() async {
    int detectorUsersCount = await controller.detector(
        controller.birthSelectedValue.value,
        // issues: #46 학력정보 검색 페이지로 넘기기 - ellee
        controller.education.value,
        controller.genderSelectedValue.value,
        controller.nationalitySelectedValue.value,
        controller.maritalstatusSelectedValue.value,
        controller.childrenSelectedValue.value,
        controller.bodyHeight.value,
        controller.bodyWeight.value,
        controller.bodyLeftVision.value,
        controller.bodyRightVision.value,
        controller.bodyBloodType.value,
        controller.bodyFootSize.value,
        controller.healthTabacco.value,
        controller.healthAlcohol.value,
        controller.healthExercise.value,
        controller.personalityMBTI,
        controller.personalityStarSign,
        // issues: #55 경제정보 검색 페이지로 넘기기 - ellee
        controller.economicProperty,
        controller.economicCar,
        controller.economicCarFuel); // 필터를 이용하여 찾은 사용자 목록 명수를 저장한다.

    //issues: #44 생년월일에 따른 연령 필터생성 -ellee
    controller.setBirthSelected();
    // issues: #46 학력정보 board 저장 - ellee
    controller.setEducationSelected();
    controller.setGenderSelected();
    controller.setNationalitySelected();
    controller.setMaritalStatusSelected();
    controller.setChildrenSelected();
    // 신체정보 필터
    controller.setBodyHeightSelected();
    controller.setBodyWeightSelected();
    controller.setBodyVisionSelected();
    controller.setBodyBloodTypeSelected();
    controller.setBodyFootSizeSelected();

    // issues: #45 건강정보 입력, 검색 생성
    controller.setHealthTabaccoSelected();
    controller.setHealthAlcoholSelected();
    controller.setHealthExerciseSelected();
    // issues: #51 성격정보 검색 - ellee
    controller.setPersonalityMBTISelected();
    // issues: #54 별자리 성격정보 검색 - ellee
    controller.setPersonalityStarSignSelected();
    // issues: #55 경제 정보 검색 - ellee
    controller.setEconomicPropertySelected();
    controller.setEconomicCarSelected();
    controller.setEconomicCarFuelSelected();

    detectorDialog(detectorUsersCount); // 다이얼로그 띄우기
  }

  @override
  Widget build(BuildContext context) {
    BannerAd banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {},
        onAdLoaded: (_) {},
      ),
      size: AdSize.banner,
      adUnitId: kReleaseMode
          ? GetPlatform.isIOS
              ? 'ca-app-pub-2175953775265407/8691786694'
              : 'ca-app-pub-2175953775265407/6253325615'
          : GetPlatform.isIOS
              ? 'ca-app-pub-3940256099942544/6300978111'
              : 'ca-app-pub-3940256099942544/6300978111',
      request: const AdRequest(),
    )..load();
    return DefaultTabController(
      length: 5, // 텝바 갯수 수정필수
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => !SendBoardController.to.repeatWrite.value
                    ? const Text('게시글 작성')
                    : const Text('게시글 다시 보내기'),
              ),
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    titlePadding: const EdgeInsets.all(20),
                    titleStyle: const TextStyle(fontSize: 17),
                    title: '필터정보 확인',
                    actions: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.red,
                              backgroundColor: Colors.black.withOpacity(0),
                              shadowColor: Colors.black.withOpacity(0)),
                          onPressed: () {
                            Get.back(); // 팝업창 닫기
                          },
                          child: const Text('닫기'))
                    ],
                    content: SizedBox(
                      height: Get.size.height / 1.5,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    width: double.infinity,
                                    child: const Text(
                                      '기본정보',
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  //issues: #44 생년월일에 따른 연령 필터생성 -ellee
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(controller
                                                .birthSelectedValue.value ==
                                            'all'
                                        ? '연령: 전체'
                                        : controller.birthSelectedValue.value ==
                                                '10'
                                            ? '연령: ${controller.birthSelectedValue.value}대 이하'
                                            : controller.birthSelectedValue
                                                        .value ==
                                                    '60'
                                                ? '연령: ${controller.birthSelectedValue.value}대 이상'
                                                : '연령: ${controller.birthSelectedValue.value}대'),
                                  ),
                                  // issues: #46 학력정보 필터 작성
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(controller.educationAll.value
                                        ? '학력: 전체'
                                        : controller.educationElementary.value
                                            ? '학력: 초등학교 졸업'
                                            : controller.educationMiddle.value
                                                ? '학력: 중학교 졸업'
                                                : controller.educationHigh.value
                                                    ? '학력: 고등학교 졸업'
                                                    : controller
                                                            .educationJuniorCollege
                                                            .value
                                                        ? '학력: 전문학사'
                                                        : controller
                                                                .educationUniversity
                                                                .value
                                                            ? '학력: 학사'
                                                            : controller
                                                                    .educationMaster
                                                                    .value
                                                                ? '학력: 석사'
                                                                : '학력: 박사'),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                        controller.genderSelectedValue.value ==
                                                'all'
                                            ? '성별: 전체'
                                            : controller.genderSelectedValue
                                                        .value ==
                                                    'male'
                                                ? '성별: 남성'
                                                : '성별: 여성'),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(controller
                                                .nationalitySelectedValue
                                                .value ==
                                            'all'
                                        ? '국적: 전체'
                                        : controller.nationalitySelectedValue
                                                    .value ==
                                                'local'
                                            ? '국적: 내국인'
                                            : '국적: 외국인'),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(controller
                                                .maritalstatusSelectedValue
                                                .value ==
                                            'all'
                                        ? '혼인 여부: 전체'
                                        : controller.maritalstatusSelectedValue
                                                    .value ==
                                                'married'
                                            ? '혼인 여부: 기혼'
                                            : '혼인 여부: 미혼'),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(controller
                                                .childrenSelectedValue.value ==
                                            'all'
                                        ? '자녀 유무: 전체'
                                        : controller.childrenSelectedValue
                                                    .value ==
                                                'existence'
                                            ? '자녀 유무: 있음'
                                            : '자녀 유무: 없음'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: !controller.bodyHeightFilter.value &&
                                      !controller.bodyWeightFilter.value &&
                                      !controller.bodyVisionFilter.value &&
                                      controller.bodyBloodType.value == 'all' &&
                                      !controller.bodyFootSizeFilter.value
                                  ? Container()
                                  : Column(
                                      children: [
                                        // issues: #41 신체정보 이상, 이하 UI선택 및 적용 - ellee
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          child: const Text(
                                            '신체 정보',
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        if (controller.bodyHeightFilter.value)
                                          Container(
                                            width: double.infinity,
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                                '키: ${controller.bodyHeight.value.start.floor()}cm ~ ${controller.bodyHeight.value.end.floor()}cm'),
                                          ),
                                        if (controller.bodyWeightFilter.value)
                                          Container(
                                            width: double.infinity,
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                                '몸무게: ${controller.bodyWeight.value.start.floor()}kg ~ ${controller.bodyWeight.value.end.floor()}kg'),
                                          ),
                                        if (controller.bodyVisionFilter.value)
                                          Container(
                                            width: double.infinity,
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                                '시력: 좌 ${controller.bodyLeftVision.value.start.toStringAsFixed(1)} ~ ${controller.bodyLeftVision.value.end.toStringAsFixed(1)} 우 ${controller.bodyRightVision.value.start.toStringAsFixed(1)} ~ ${controller.bodyRightVision.value.end.toStringAsFixed(1)}'),
                                          ),
                                        if (controller.bodyBloodType.value !=
                                            'all')
                                          Container(
                                            width: double.infinity,
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(controller
                                                        .bodyBloodType.value ==
                                                    'all'
                                                ? '혈액형: 전체'
                                                : '혈액형: ${controller.bodyBloodType.value}'),
                                          ),
                                        if (controller.bodyFootSizeFilter.value)
                                          Container(
                                            width: double.infinity,
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                                '신발 사이즈: ${controller.bodyFootSize.value.start.round()}mm ~ ${controller.bodyFootSize.value.end.round()}mm'),
                                          ),
                                      ],
                                    ),
                            ),
                            SizedBox(
                              child: !controller.healthTabaccoFilter.value &&
                                      controller.healthAlcohol.value == 'all' &&
                                      !controller.healthExerciseFilter.value
                                  ? Container()
                                  : Column(
                                      children: [
                                        // issues: #41 신체정보 이상, 이하 UI선택 및 적용 - ellee
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          child: const Text(
                                            '건강 정보',
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        if (controller
                                            .healthTabaccoFilter.value)
                                          Container(
                                            width: double.infinity,
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                                '흡연량: ${controller.healthTabacco.value.start.floor()}개피 ~ ${controller.healthTabacco.value.end.floor()}개피'),
                                          ),
                                        if (controller.healthAlcohol.value !=
                                            'all')
                                          Container(
                                            width: double.infinity,
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(controller
                                                        .healthAlcohol.value ==
                                                    'all'
                                                ? '주량: 전체'
                                                : controller.healthAlcohol
                                                            .value ==
                                                        '0'
                                                    ? '주량: 마시지 않음'
                                                    : controller.healthAlcohol
                                                                .value ==
                                                            '1'
                                                        ? '주량: 1병 이하'
                                                        : controller.healthAlcohol
                                                                    .value ==
                                                                '2'
                                                            ? '주량: 2병'
                                                            : controller.healthAlcohol
                                                                        .value ==
                                                                    '3'
                                                                ? '주량: 3병 이상'
                                                                : ''),
                                          ),
                                        if (controller
                                            .healthExerciseFilter.value)
                                          Container(
                                            width: double.infinity,
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                                '일 평균 운동량: ${controller.healthExercise.value.start.round()}시간 ~ ${controller.healthExercise.value.end.round()}시간'),
                                          ),
                                      ],
                                    ),
                            ),
                            SizedBox(
                              child: controller.personalityMBTIAll.value &&
                                      controller.personalityStarSignAll.value
                                  ? Container()
                                  : Column(
                                      children: [
                                        // issues: #51 성격정보 검색 필터 UI적용 - ellee
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          child: const Text(
                                            '성격 정보',
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        if (!controller
                                            .personalityMBTIAll.value)
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            width: double.infinity,
                                            child: const Text(
                                              '-MBTI',
                                              textAlign: TextAlign.start,
                                            ),
                                          ),

                                        Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.only(
                                                left: 20, bottom: 5),
                                            child: Text(controller
                                                .personalityMBTI
                                                .toString()
                                                .replaceAll('[', '')
                                                .replaceAll(']', ''))),
                                        if (!controller
                                            .personalityStarSignAll.value)
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            width: double.infinity,
                                            child: const Text(
                                              '-별자리',
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.only(
                                              left: 20, bottom: 5),
                                          child: Text(controller
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
                                        ),
                                      ],
                                    ),
                            ),
                            // issues: #55 경제정보 필터 UI - ellee
                            SizedBox(
                              child: controller.economicPropertyAll.value &&
                                      controller.economicCarAll.value &&
                                      controller.economicCarFuelAll.value
                                  ? Container()
                                  : Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.infinity,
                                          child: const Text(
                                            '경제 정보',
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        if (!controller
                                            .economicPropertyAll.value)
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            width: double.infinity,
                                            child: const Text(
                                              '-부동산',
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.only(
                                                left: 20, bottom: 5),
                                            child: Text(controller
                                                .economicProperty
                                                .toString()
                                                .replaceAll('[', '')
                                                .replaceAll(']', '')
                                                .replaceAll('MyHouse', '자가')
                                                .replaceAll('Jeonse', '전ㆍ월세'))),
                                        if (!controller.economicCarAll.value)
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            width: double.infinity,
                                            child: const Text(
                                              '-차량',
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.only(
                                              left: 20, bottom: 5),
                                          child: Text(
                                            controller.economicCar
                                                .toString()
                                                .replaceAll('[', '')
                                                .replaceAll(']', '')
                                                .replaceAll('MyCar', '자차')
                                                .replaceAll('RentCar', '렌트')
                                                .replaceAll('LeaseCar', '리스'),
                                          ),
                                        ),
                                        if (!controller
                                            .economicCarFuelAll.value)
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            width: double.infinity,
                                            child: const Text(
                                              '-차량 연료',
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.only(
                                              left: 20, bottom: 5),
                                          child: Text(
                                            controller.economicCarFuel
                                                .toString()
                                                .replaceAll('[', '')
                                                .replaceAll(']', '')
                                                .replaceAll('Electric', '전기')
                                                .replaceAll('Gasolin', '휘발유')
                                                .replaceAll('Diesel', '경유'),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.filter_alt),
              )
            ],
          ),
          bottom: TabBar(
            indicatorColor: Colors.blue,
            indicatorWeight: 5,
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                  child: Text(
                '기본 정보',
                style: Get.theme.textTheme.subtitle1,
              )),
              Tab(
                child: Text(
                  '신체 정보',
                  style: Get.theme.textTheme.subtitle1,
                ),
              ),
              Tab(
                child: Text(
                  '건강 정보',
                  style: Get.theme.textTheme.subtitle1,
                ),
              ),
              Tab(
                child: Text(
                  '성격 정보',
                  style: Get.theme.textTheme.subtitle1,
                ),
              ),
              Tab(child: Text('경제 정보', style: Get.theme.textTheme.subtitle1))
            ],
          ),
        ),
        body: Obx(
          () => IgnorePointer(
            ignoring: controller.isLoading.value ? true : false,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SelectUserInfoPage(),
                        SelectUserBodyInfoPage(),
                        SelectUserHealthInfoPage(),
                        SelectUserPersonalityInfoPage(),
                        SelectUserEconomicInfoPage(),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.filterClear();
                        },
                        child: Container(
                          width: Get.size.width / 3.5,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Center(
                            child: Text('초기화',
                                style: Get.theme.textTheme.titleMedium),
                          ),
                        ),
                      ),
                      InkWell(
                        child: controller.isLoading.value
                            ? Container(
                                width: Get.size.width / 1.6,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue),
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
                                width: Get.size.width / 1.6,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue),
                                child: const Center(
                                  child: Text('대상 검색',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17)),
                                ),
                              ),
                        onTap: () {
                          controller.isLoading.value = true;
                          if (SendBoardController.to.repeatWrite.value ==
                              false) {
                            controller.modeChangePaymentInit();
                          }
                          nextPage();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: banner.size.width.toDouble(),
                  height: banner.size.height.toDouble(),
                  child: AdWidget(ad: banner),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
