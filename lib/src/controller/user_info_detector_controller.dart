import 'package:decimal/decimal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yab_v2/src/controller/send_board_controller.dart';
import 'package:yab_v2/src/model/detector_info/select_user_model.dart';
import 'package:yab_v2/src/model/detector_info/select_user_token_model.dart';
import 'package:yab_v2/src/model/detector_model.dart';
import 'package:yab_v2/src/repository/detector_repository.dart';
import 'package:yab_v2/src/utils/data_keys.dart';
import 'package:yab_v2/src/utils/logger.dart';

class UserInfoDetectorController extends GetxController {
  static UserInfoDetectorController get to => Get.find();

  RxList<dynamic> imagesController = [].obs;

  RxBool isLoading = false.obs;
  RxBool isResultPageLoading = false.obs;

  //기본정보 값 전송
  RxString genderSelectedValue = 'all'.obs;
  RxString nationalitySelectedValue = 'all'.obs;
  RxString maritalstatusSelectedValue = 'all'.obs;
  RxString childrenSelectedValue = 'all'.obs;
  RxString birthSelectedValue = 'all'.obs;
  RxString expiredDaySelectedValue = ''.obs;
  RxBool reservationDateSelected = false.obs;
  RxString reservationDateSelectedValue = ''.obs;
  RxString reservationExpiredDateSelectedValue = ''.obs;
  RxString userModelAddressLevel1SelectedValue = 'all'.obs;
  RxString userModelAddressLevel2SelectedValue = 'all'.obs;
  RxString userModelAddressLevel4LSelectedValue = 'all'.obs;

  //신체정보 값 전송
  RxBool bodyHeightFilter = false.obs;
  RxBool bodyWeightFilter = false.obs;
  RxBool bodyVisionFilter = false.obs;
  RxBool bodyFootSizeFilter = false.obs;
  RxString bodyBloodType = 'all'.obs;
  // issues: #41 신체정보 이상, 이하 UI선택 및 적용 - ellee
  Rx<RangeValues> bodyFootSize = const RangeValues(220, 280).obs;
  Rx<RangeValues> bodyHeight = const RangeValues(130, 190).obs;
  Rx<RangeValues> bodyWeight = const RangeValues(40, 100).obs;
  Rx<RangeValues> bodyLeftVision = const RangeValues(0.5, 1.5).obs;
  Rx<RangeValues> bodyRightVision = const RangeValues(0.5, 1.5).obs;
  // 기본정보 검색
  RxBool addressSelect = false.obs;
  RxBool birthSelect = false.obs;
  RxBool genderSelect = false.obs;
  RxBool genderMale = false.obs;
  RxBool genderWoman = false.obs;
  RxBool genderAll = true.obs;
  RxBool nationalitySelect = false.obs;
  RxBool nationalityLocal = false.obs;
  RxBool nationalityForeigner = false.obs;
  RxBool nationalityAll = true.obs;
  RxBool maritalstatusSelect = false.obs;
  RxBool maritalstatusMarried = false.obs;
  RxBool maritalstatusSingle = false.obs;
  RxBool maritalstatusAll = true.obs;
  RxBool childrenSelect = false.obs;
  RxBool childrenExistence = false.obs;
  RxBool childrenNonexistence = false.obs;
  RxBool childrenAll = true.obs;
  RxBool birthAll = true.obs;
  RxBool birth10 = false.obs;
  RxBool birth20 = false.obs;
  RxBool birth30 = false.obs;
  RxBool birth40 = false.obs;
  RxBool birth50 = false.obs;
  RxBool birth60 = false.obs;
  RxString address = ''.obs;
  // issues: #46 학력정보 검색용 obs 모델 - ellee
  RxBool educationSelect = false.obs;
  RxString education = 'all'.obs;
  RxBool educationAll = true.obs;
  RxBool educationElementary = false.obs;
  RxBool educationMiddle = false.obs;
  RxBool educationHigh = false.obs;
  RxBool educationJuniorCollege = false.obs;
  RxBool educationUniversity = false.obs;
  RxBool educationMaster = false.obs;
  RxBool educationDoctor = false.obs;

  // 신체정보 검색
  RxBool bodyBloodTypeAll = true.obs;
  RxBool bodyBloodTypeA = false.obs;
  RxBool bodyBloodTypeB = false.obs;
  RxBool bodyBloodTypeO = false.obs;
  RxBool bodyBloodTypeAB = false.obs;

  // issues: #45 건강정보 입력, 검색 생성 - ellee
  RxBool healthTabaccoFilter = false.obs;
  RxBool healthExerciseFilter = false.obs;
  Rx<RangeValues> healthTabacco = const RangeValues(5, 10).obs;
  Rx<RangeValues> healthExercise = const RangeValues(2, 4).obs;
  RxString healthAlcohol = 'all'.obs;
  RxBool healthAlcoholAll = true.obs;
  RxBool healthAlcohol0 = false.obs;
  RxBool healthAlcohol1 = false.obs;
  RxBool healthAlcohol2 = false.obs;
  RxBool healthAlcohol3 = false.obs;

  // issues: #51 성격정보 입력, 검색 생성 - ellee
  RxList personalityMBTI = [].obs;
  RxBool personalityMBTIAll = true.obs;
  RxBool personalityISTJ = false.obs;
  RxBool personalityISTP = false.obs;
  RxBool personalityISFJ = false.obs;
  RxBool personalityISFP = false.obs;
  RxBool personalityINTJ = false.obs;
  RxBool personalityINTP = false.obs;
  RxBool personalityINFJ = false.obs;
  RxBool personalityINFP = false.obs;
  RxBool personalityESTJ = false.obs;
  RxBool personalityESTP = false.obs;
  RxBool personalityESFJ = false.obs;
  RxBool personalityESFP = false.obs;
  RxBool personalityENTJ = false.obs;
  RxBool personalityENTP = false.obs;
  RxBool personalityENFJ = false.obs;
  RxBool personalityENFP = false.obs;

  // issues: #54 성격정보 별자리 검색 - ellee
  RxList personalityStarSign = [].obs;
  RxBool personalityStarSignAll = true.obs;
  RxBool personalityAquarius = false.obs;
  RxBool personalityPisces = false.obs;
  RxBool personalityAries = false.obs;
  RxBool personalityTaurus = false.obs;
  RxBool personalityGemini = false.obs;
  RxBool personalityCancer = false.obs;
  RxBool personalityLeo = false.obs;
  RxBool personalityVirgo = false.obs;
  RxBool personalityLibra = false.obs;
  RxBool personalityScorpio = false.obs;
  RxBool personalitySagittarius = false.obs;
  RxBool personalityCapricorn = false.obs;

  //issues: #55 경제정보 검색 - ellee
  RxList economicProperty = [].obs;
  RxBool economicPropertyAll = true.obs;
  RxBool economicMyhouse = false.obs;
  RxBool economicJeonse = false.obs;
  RxList economicCar = [].obs;
  RxBool economicCarAll = true.obs;
  RxBool economicMycar = false.obs;
  RxBool economicRentCar = false.obs;
  RxBool economicLeaseCar = false.obs;
  RxList economicCarFuel = [].obs;
  RxBool economicCarFuelAll = true.obs;
  RxBool economicCarElectric = false.obs;
  RxBool economicCarLPG = false.obs;
  RxBool economicCarGasolin = false.obs;
  RxBool economicCarDiesel = false.obs;

  TextEditingController vsTitle = TextEditingController();
  TextEditingController vsADetail = TextEditingController();
  TextEditingController vsBDetail = TextEditingController();
  TextEditingController paymentPeople = TextEditingController();
  TextEditingController paymentPrice = TextEditingController();
  TextEditingController multiTitle = TextEditingController();
  TextEditingController multiADetail = TextEditingController();
  TextEditingController multiBDetail = TextEditingController();
  TextEditingController multiCDetail = TextEditingController();
  TextEditingController multiDDetail = TextEditingController();
  TextEditingController multiEDetail = TextEditingController();
  TextEditingController multiFDetail = TextEditingController();
  TextEditingController multiGDetail = TextEditingController();
  TextEditingController multiHDetail = TextEditingController();
  TextEditingController promotionTitle = TextEditingController();
  TextEditingController promotionDetail = TextEditingController();

  RxString vsTitleValue = ''.obs;
  RxString vsADetailValue = ''.obs;
  RxString vsBDetailValue = ''.obs;

  RxString paymentPeopleValue = ''.obs;
  RxString paymentPriceValue = ''.obs;

  RxString multiTitleValue = ''.obs;
  RxString multiADetailValue = ''.obs;
  RxString multiBDetailValue = ''.obs;
  RxString multiCDetailValue = ''.obs;
  RxString multiDDetailValue = ''.obs;
  RxString multiEDetailValue = ''.obs;
  RxString multiFDetailValue = ''.obs;
  RxString multiGDetailValue = ''.obs;
  RxString multiHDetailValue = ''.obs;

  RxString promotionTitleValue = ''.obs;
  RxString promotionDetailValue = ''.obs;

  RxInt sendUserCount = 0.obs; // 결과 페이지에서 여러명한테 보낼때 올라가는 함수

  Rx<DetectorModel> detectorUserModel = DetectorModel().obs; // detector만 사용

  @override
  void onInit() {
    vsTitle.addListener(() {
      vsTitleValue.value = vsTitle.text;
    });
    vsADetail.addListener(() {
      vsADetailValue.value = vsADetail.text;
    });
    vsBDetail.addListener(() {
      vsBDetailValue.value = vsBDetail.text;
    });
    paymentPeople.addListener(() {
      paymentPeopleValue.value = paymentPeople.text;
    });
    paymentPrice.addListener(() {
      paymentPriceValue.value = paymentPrice.text;
    });
    multiTitle.addListener(() {
      multiTitleValue.value = multiTitle.text;
    });
    multiADetail.addListener(() {
      multiADetailValue.value = multiADetail.text;
    });
    multiBDetail.addListener(() {
      multiBDetailValue.value = multiBDetail.text;
    });
    multiCDetail.addListener(() {
      multiCDetailValue.value = multiCDetail.text;
    });
    multiDDetail.addListener(() {
      multiDDetailValue.value = multiDDetail.text;
    });
    multiEDetail.addListener(() {
      multiEDetailValue.value = multiEDetail.text;
    });
    multiFDetail.addListener(() {
      multiFDetailValue.value = multiFDetail.text;
    });
    multiGDetail.addListener(() {
      multiGDetailValue.value = multiGDetail.text;
    });
    multiHDetail.addListener(() {
      multiHDetailValue.value = multiHDetail.text;
    });
    promotionTitle.addListener(() {
      promotionTitleValue.value = promotionTitle.text;
    });
    promotionDetail.addListener(() {
      promotionDetailValue.value = promotionDetail.text;
    });
    super.onInit();
  }

  // 글쓰기 모드가 바뀔때 payment페이지의 컨트롤러 초기화
  void modeChangePaymentInit() {
    vsTitle.clear();
    vsADetail.clear();
    vsBDetail.clear();
    paymentPeople.clear();
    paymentPrice.clear();
    expiredDaySelectedValue.value = '';
    reservationDateSelected.value = false;
    reservationDateSelectedValue.value = '';
    reservationExpiredDateSelectedValue.value = '';
    multiTitle.clear();
    multiADetail.clear();
    multiBDetail.clear();
    multiCDetail.clear();
    multiDDetail.clear();
    multiEDetail.clear();
    multiFDetail.clear();
    multiGDetail.clear();
    multiHDetail.clear();
    promotionTitle.clear();
    promotionDetail.clear();
    imagesController.clear();
  }

  void filterClear() {
    addressSelect.value = false;
    birthSelect.value = false;
    genderSelect.value = false;
    nationalitySelect.value = false;
    maritalstatusSelect.value = false;
    childrenSelect.value = false;
    genderSelectedValue.value = 'all';
    nationalitySelectedValue.value = 'all';
    maritalstatusSelectedValue.value = 'all';
    childrenSelectedValue.value = 'all';
    birthSelectedValue.value = 'all';
    expiredDaySelectedValue.value = '';
    reservationDateSelected.value = false;
    reservationDateSelectedValue.value = '';
    reservationExpiredDateSelectedValue.value = '';
    bodyHeightFilter.value = false;
    bodyWeightFilter.value = false;
    bodyVisionFilter.value = false;
    bodyFootSizeFilter.value = false;
    bodyHeight.value = const RangeValues(130, 190);
    bodyWeight.value = const RangeValues(40, 100);
    bodyFootSize.value = const RangeValues(220, 280);
    bodyLeftVision.value = const RangeValues(0.5, 1.5);
    bodyRightVision.value = const RangeValues(0.5, 1.5);
    bodyBloodType.value = 'all';
    genderMale.value = false;
    genderWoman.value = false;
    genderAll.value = true;
    nationalityLocal.value = false;
    nationalityForeigner.value = false;
    nationalityAll.value = true;
    maritalstatusMarried.value = false;
    maritalstatusSingle.value = false;
    maritalstatusAll.value = true;
    childrenExistence.value = false;
    childrenNonexistence.value = false;
    childrenAll.value = true;
    birthAll.value = true;
    birth10.value = false;
    birth20.value = false;
    birth30.value = false;
    birth40.value = false;
    birth50.value = false;
    birth60.value = false;
    address.value = '';
    bodyBloodTypeAll.value = true;
    bodyBloodTypeA.value = false;
    bodyBloodTypeB.value = false;
    bodyBloodTypeO.value = false;
    bodyBloodTypeAB.value = false;
    // issues: #45 건강정보 입력, 검색 생성 - ellee
    // 필터정보 초기화
    healthTabaccoFilter.value = false;
    healthExerciseFilter.value = false;
    healthTabacco.value = const RangeValues(5, 10);
    healthExercise.value = const RangeValues(2, 4);
    healthAlcohol.value = 'all';
    healthAlcoholAll.value = true;
    healthAlcohol0.value = false;
    healthAlcohol1.value = false;
    healthAlcohol2.value = false;
    healthAlcohol3.value = false;
    // issues: #51 성격정보 입력, 검색 생성 - ellee
    personalityMBTI.clear();
    personalityMBTIAll.value = true;
    personalityISTJ.value = false;
    personalityISTP.value = false;
    personalityISFJ.value = false;
    personalityISFP.value = false;
    personalityINTJ.value = false;
    personalityINTP.value = false;
    personalityINFJ.value = false;
    personalityINFP.value = false;
    personalityESTJ.value = false;
    personalityESTP.value = false;
    personalityESFJ.value = false;
    personalityESFP.value = false;
    personalityENTJ.value = false;
    personalityENTP.value = false;
    personalityENFJ.value = false;
    personalityENFP.value = false;
    // issues: #54 별자리 성격정보 검색 - ellee
    personalityStarSign.clear();
    personalityStarSignAll.value = true;
    personalityAquarius.value = false;
    personalityPisces.value = false;
    personalityAries.value = false;
    personalityTaurus.value = false;
    personalityGemini.value = false;
    personalityCancer.value = false;
    personalityLeo.value = false;
    personalityVirgo.value = false;
    personalityLibra.value = false;
    personalityScorpio.value = false;
    personalitySagittarius.value = false;
    personalityCapricorn.value = false;
    // issues: #55 경제정보 필터 초기화 - ellee
    economicProperty.clear();
    economicPropertyAll.value = true;
    economicMyhouse.value = false;
    economicJeonse.value = false;
    economicCar.clear();
    economicCarAll.value = true;
    economicMycar.value = false;
    economicRentCar.value = false;
    economicLeaseCar.value = false;
    economicCarFuel.clear();
    economicCarFuelAll.value = true;
    economicCarElectric.value = false;
    economicCarLPG.value = false;
    economicCarGasolin.value = false;
    economicCarDiesel.value = false;
  }

  // 페이지 전송 후 모든 컨트롤러 초기화
  void detectorControllerInit() {
    addressSelect.value = false;
    genderSelect.value = false;
    birthSelect.value = false;
    nationalitySelect.value = false;
    maritalstatusSelect.value = false;
    childrenSelect.value = false;
    genderSelectedValue = 'all'.obs; // 성별 초기화
    genderMale = false.obs;
    genderWoman = false.obs;
    genderAll = true.obs;
    nationalitySelectedValue = 'all'.obs; // 국적 초기화
    nationalityLocal = false.obs;
    nationalityForeigner = false.obs;
    nationalityAll = true.obs;
    maritalstatusSelectedValue = 'all'.obs; // 결혼유무 초기화
    maritalstatusMarried = false.obs;
    maritalstatusSingle = false.obs;
    maritalstatusAll = true.obs;
    childrenSelectedValue = 'all'.obs; // 자녀유무 초기화
    childrenExistence = false.obs;
    childrenNonexistence = false.obs;
    childrenAll = true.obs;
    birthSelectedValue.value = 'all';
    birthAll.value = true;
    birth10.value = false;
    birth20.value = false;
    birth30.value = false;
    birth40.value = false;
    birth50.value = false;
    birth60.value = false; // 생일 초기화
    address = ''.obs; // 주소 초기화

    bodyHeightFilter.value = false;
    bodyWeightFilter.value = false;
    bodyVisionFilter.value = false;
    bodyFootSizeFilter.value = false;
    bodyHeight.value = const RangeValues(130, 190); // 키 초기화
    bodyWeight.value = const RangeValues(40, 100); // 몸무게 초기화
    bodyFootSize.value = const RangeValues(220, 280); // 발사이즈 초기화
    bodyLeftVision.value = const RangeValues(0.5, 1.5); // 시력 좌 초기화
    bodyRightVision.value = const RangeValues(0.5, 1.5); // 시력 우 초기화
    bodyBloodType.value = 'all'; // 혈액형 초기화
    bodyBloodTypeAll.value = true;
    bodyBloodTypeA.value = false;
    bodyBloodTypeB.value = false;
    bodyBloodTypeO.value = false;
    bodyBloodTypeAB.value = false;

    expiredDaySelectedValue = ''.obs;
    reservationDateSelected.value = false;
    reservationDateSelectedValue = ''.obs;
    reservationExpiredDateSelectedValue = ''.obs;

    sendUserCount = 0.obs;

    // issues: #45 건강정보 입력, 검색 생성 - ellee
    // 필터정보 초기화
    healthTabaccoFilter.value = false;
    healthExerciseFilter.value = false;
    healthTabacco.value = const RangeValues(5, 10);
    healthExercise.value = const RangeValues(2, 4);
    healthAlcohol.value = 'all';
    healthAlcoholAll.value = true;
    healthAlcohol0.value = false;
    healthAlcohol1.value = false;
    healthAlcohol2.value = false;
    healthAlcohol3.value = false;

    // issues: #51 성격정보 입력, 검색 생성 - ellee
    personalityMBTI.clear();
    personalityMBTIAll.value = true;
    personalityISTJ.value = false;
    personalityISTP.value = false;
    personalityISFJ.value = false;
    personalityISFP.value = false;
    personalityINTJ.value = false;
    personalityINTP.value = false;
    personalityINFJ.value = false;
    personalityINFP.value = false;
    personalityESTJ.value = false;
    personalityESTP.value = false;
    personalityESFJ.value = false;
    personalityESFP.value = false;
    personalityENTJ.value = false;
    personalityENTP.value = false;
    personalityENFJ.value = false;
    personalityENFP.value = false;

    // issues: #54 별자리 성격정보 검색 - ellee
    personalityStarSign.clear();
    personalityStarSignAll.value = true;
    personalityAquarius.value = false;
    personalityPisces.value = false;
    personalityAries.value = false;
    personalityTaurus.value = false;
    personalityGemini.value = false;
    personalityCancer.value = false;
    personalityLeo.value = false;
    personalityVirgo.value = false;
    personalityLibra.value = false;
    personalityScorpio.value = false;
    personalitySagittarius.value = false;
    personalityCapricorn.value = false;

    // issues: #55 경제정보 필터 초기화 - ellee
    economicProperty.clear();
    economicPropertyAll.value = true;
    economicMyhouse.value = false;
    economicJeonse.value = false;
    economicCar.clear();
    economicCarAll.value = true;
    economicMycar.value = false;
    economicRentCar.value = false;
    economicLeaseCar.value = false;
    economicCarFuel.clear();
    economicCarFuelAll.value = true;
    economicCarElectric.value = false;
    economicCarLPG.value = false;
    economicCarGasolin.value = false;
    economicCarDiesel.value = false;

    vsTitle.clear();
    vsADetail.clear();
    vsBDetail.clear();
    paymentPeople.clear();
    paymentPrice.clear();
    multiTitle.clear();
    multiADetail.clear();
    multiBDetail.clear();
    multiCDetail.clear();
    multiDDetail.clear();
    multiEDetail.clear();
    multiFDetail.clear();
    multiGDetail.clear();
    multiHDetail.clear();
    promotionTitle.clear();
    promotionDetail.clear();
    imagesController.clear();
    SendBoardController.to.repeatWrite.value = false;
    detectorUserModel(DetectorModel());
  }

  // 성별 선택 값
  void setReGenderSelected(String value) {
    detectorUserModel.update((val) {
      val!.gender = value;
    });
  }

  // 국적 선택 값
  void setReNationalitySelected(String value) {
    detectorUserModel.update((val) {
      val!.nationality = value;
    });
  }

  // 결혼 유무 선택 값
  void setReMaritalStatusSelected(String value) {
    detectorUserModel.update((val) {
      val!.maritalstatus = value;
    });
  }

  // 자녀 유무 선택 값
  void setReChildrenSelected(String value) {
    detectorUserModel.update((val) {
      val!.children = value;
    });
  }

  //issues: #44 생년월일에 따른 연령 필터생성 -ellee
  // 연령 - 최초 글쓰기 검색 선택 값
  void setBirthSelected() {
    detectorUserModel.update((val) {
      val!.birth = birthSelectedValue.value;
    });
  }

  void setEducationSelected() {
    detectorUserModel.update((val) {
      val!.education = education.value;
    });
  }

  // 성별 - 최초 글쓰기 검색 선택값
  void setGenderSelected() {
    detectorUserModel.update((val) {
      val!.gender = genderSelectedValue.value;
    });
  }

  // 국적 - 최초 글쓰기 검색 선택값
  void setNationalitySelected() {
    detectorUserModel.update((val) {
      val!.nationality = nationalitySelectedValue.value;
    });
  }

  // 결혼 - 최초 글쓰기 검색 선택값
  void setMaritalStatusSelected() {
    detectorUserModel.update((val) {
      val!.maritalstatus = maritalstatusSelectedValue.value;
    });
  }

  // 자녀 - 최초 글쓰기 검색 선택값
  void setChildrenSelected() {
    detectorUserModel.update((val) {
      val!.children = childrenSelectedValue.value;
    });
  }

  // 키 - 최초 글쓰기 검색 선택값
  void setBodyHeightSelected() {
    detectorUserModel.update((val) {
      if (bodyHeightFilter.value) {
        val!.heightStart = bodyHeight.value.start;
        val.heightEnd = bodyHeight.value.end;
      } else {
        val!.heightStart = null;
        val.heightEnd = null;
      }
    });
  }

  // 몸무게 - 최초 글쓰기 검색 선택값
  void setBodyWeightSelected() {
    detectorUserModel.update((val) {
      if (bodyWeightFilter.value) {
        val!.weightStart = bodyWeight.value.start;
        val.weightEnd = bodyWeight.value.end;
      } else {
        val!.weightStart = null;
        val.weightEnd = null;
      }
    });
  }

// 시력 - 최초 글쓰기 검색 선택값
  void setBodyVisionSelected() {
    detectorUserModel.update((val) {
      if (bodyVisionFilter.value) {
        val!.leftVisionStart = bodyLeftVision.value.start;
        val.leftVisionEnd = bodyLeftVision.value.end;
        val.rightVisionStart = bodyRightVision.value.start;
        val.rightVisionEnd = bodyRightVision.value.end;
      } else {
        val!.leftVisionStart = null;
        val.leftVisionEnd = null;
        val.rightVisionStart = null;
        val.rightVisionEnd = null;
      }
    });
  }

// 혈액형 - 최초 글쓰기 검색 선택값
  void setBodyBloodTypeSelected() {
    detectorUserModel.update((val) {
      val!.bloodType = bodyBloodType.value;
    });
  }

  // 발 사이즈 - 최초 글쓰기 검색 선택값
  void setBodyFootSizeSelected() {
    detectorUserModel.update((val) {
      if (bodyFootSizeFilter.value) {
        val!.footSizeStart = bodyFootSize.value.start;
        val.footSizeEnd = bodyFootSize.value.end;
      } else {
        val!.footSizeStart = null;
        val.footSizeEnd = null;
      }
    });
  }

  // issues: #45 건강정보 입력, 검색 생성 - ellee
  // 흡연량
  void setHealthTabaccoSelected() {
    detectorUserModel.update((val) {
      if (healthTabaccoFilter.value) {
        val!.healthTabaccoStart = healthTabacco.value.start;
        val.healthTabaccoEnd = healthTabacco.value.end;
      } else {
        val!.healthTabaccoStart = null;
        val.healthTabaccoEnd = null;
      }
    });
  }

  // 주량
  void setHealthAlcoholSelected() {
    detectorUserModel.update((val) {
      val!.healthAlcohol = healthAlcohol.value;
    });
  }

  // 운동량
  void setHealthExerciseSelected() {
    detectorUserModel.update((val) {
      if (healthExerciseFilter.value) {
        val!.healthExerciseStart = healthExercise.value.start;
        val.healthExerciseEnd = healthExercise.value.end;
      } else {
        val!.healthExerciseStart = null;
        val.healthExerciseEnd = null;
      }
    });
  }

  // issues: #51 성격정보 board에 저장
  void setPersonalityMBTISelected() {
    detectorUserModel.update((val) {
      val!.personalityMBTI =
          personalityMBTI.cast<Map<String, dynamic>>().cast<String>();
    });
  }

  // issues: #54 성격정보 board에 저장
  void setPersonalityStarSignSelected() {
    detectorUserModel.update((val) {
      val!.personalityStarSign =
          personalityStarSign.cast<Map<String, dynamic>>().cast<String>();
    });
  }

  // issues: #55 경제정보 board에 저장
  void setEconomicPropertySelected() {
    detectorUserModel.update((val) {
      val!.economicProperty =
          economicProperty.cast<Map<String, dynamic>>().cast<String>();
    });
  }

  void setEconomicCarSelected() {
    detectorUserModel.update((val) {
      val!.economicCar =
          economicCar.cast<Map<String, dynamic>>().cast<String>();
    });
  }

  void setEconomicCarFuelSelected() {
    detectorUserModel.update((val) {
      val!.economicCarFuel =
          economicCarFuel.cast<Map<String, dynamic>>().cast<String>();
    });
  }

  // 만료일수 선택 값
  void setExpiryDateSelected(String value) {
    detectorUserModel.update((val) {
      val!.expiredDay = value;
    });
  }

  // 모드 값 저장
  void setModeSelected(String value) {
    detectorUserModel.update((val) {
      val!.mode = value;
    });
  }

  // 제목 값 저장
  void setTitleValued(String value) {
    detectorUserModel.update((val) {
      val!.title = value;
    });
  }

  // VS 내용 목록 값 저장
  void setDetailValued(List<String> value) {
    detectorUserModel.update((val) {
      val!.detail = value;
    });
  }

  // 필요한 인원수 값 저장
  void setPaymentPeopleValued(num value) {
    detectorUserModel.update((val) {
      val!.counter = value;
      // 선택한 인원수에 맞게 유저 키 새로 등록
      List<String> tmpUsers = [];
      for (int i = 0; i < value; i++) {
        tmpUsers.add(val.users![i]);
      }
      // val.users!.clear();
      setDetectorUserList(tmpUsers);
    });
  }

  // 인당 가격 값 저장
  void setPaymentPriceValued(num value) {
    detectorUserModel.update((val) {
      val!.price = value;
    });
  }

  // 차감 될 전체 금액 (FULL_PRICE)
  void setFullPriceValued(num value) {
    detectorUserModel.update((val) {
      val!.fullPrice = value;
    });
  }

  // 1차 지급금액 (FIRST_PRICE)
  void setFirstPriceValued(num value) {
    detectorUserModel.update((val) {
      val!.firstPrice = value;
    });
  }

  // 2차 지급금액 (SECOUND_PRICE)
  void setSecoundPriceValued(num value) {
    detectorUserModel.update((val) {
      val!.secondPrice = value;
    });
  }

  // FCM 메시지에서 볼 금액  (FCM_VIEW_PRICE)
  void setFCMViewPriceValued(num value) {
    detectorUserModel.update((val) {
      val!.fcmViewPrice = value;
    });
  }

  // 환불 금액 (REFUND_PRICE)
  void setRefundPriceValued(num value) {
    detectorUserModel.update((val) {
      val!.refundPrice = value;
    });
  }

  // 유저키 값 저장
  void setUserKeyValued(String value) {
    detectorUserModel.update((val) {
      val!.userKey = value;
    });
  }

  // detector키 값 저장
  void setdetectorKeyValued(String value) {
    detectorUserModel.update((val) {
      val!.detectorKey = value;
    });
  }

  // 생성시간 값 저장
  void setCreatedDateValued(DateTime value) {
    detectorUserModel.update((val) {
      val!.createdDate = value;
    });
  }

  // 만료일 값 저장
  void setExpiredDateValued(DateTime value) {
    detectorUserModel.update((val) {
      val!.expiredDate = value;
    });
  }

  // 예약일 값 저장
  void setReservationDateValued(DateTime value) {
    detectorUserModel.update((val) {
      val!.reservationDate = value;
    });
  }

  // 사진URL 값 저장
  void setImageDownloadUrlsValued(List<String> value) {
    detectorUserModel.update((val) {
      val!.imageDownloadUrls = value;
    });
  }

  void setSelectUserTokenValued(SelectUserTokenModel value) {
    detectorUserModel.update((val) {
      val!.selectUserTokenModel = value;
    });
  }

  // 선택 배열 값 저장
  void setSelctUserValued(SelectUserModel value) {
    detectorUserModel.update((val) {
      val!.selectUserModel = value;
    });
  }

  Future setNewImages(List<XFile>? newImages) async {
    for (int index = 0; index < newImages!.length; index++) {
      if (imagesController.length < 5) {
        imagesController.add(await newImages[index].readAsBytes());
      }
    }
  }

  void setDetectorUserList(List<String> value) {
    detectorUserModel.update((val) {
      val!.users = value;
    });
  }

  void setDetecotorUserTokenList(List<String> value) async {
    List<String> selectUserToken =
        await DetectorRepository.detectorToken(value);
    detectorUserModel.update((val) {
      val!.fcmTokens = selectUserToken;
    });
  }

  void removeImage(int index) {
    if (imagesController.length >= index) {
      imagesController.removeAt(index);
    }
  }

  Future<void> sendDetectorModeltoServer() async {
    final String userKey =
        FirebaseAuth.instance.currentUser!.uid; // 로그인된 유저 키값을 가져 옴

    final String detectorKey = DetectorModel.generateDetectorKey(
        userKey); // detectorKey 생성 DocumentID값 생성

    // 선택가능한 게시물의 초기값 셋팅하는 부분
    final SelectUserModel selectUserModel =
        SelectUserModel(); // 선택가능한 게시물의 선택했을씨 userKey값을 설정하기 위한 모델
    final SelectUserTokenModel selectUserTokenModel =
        SelectUserTokenModel(); // 선택가능한 게시물의 선택했을씨 FCM Token 값을 설정하기 위한 모델

    // 컨트롤러변수에 저장 부분
    setUserKeyValued(userKey); // userKey detectorModel 저장
    setdetectorKeyValued(detectorKey); // detectorKey detectorModel 저장
    setSelctUserValued(selectUserModel); //selectUserModel detectorModel 저장
    setSelectUserTokenValued(selectUserTokenModel); // selectUserTokenModel 저장
    List<String> uploadUrls =
        await uploadImages(imagesController, detectorKey); // 일반 게시물일때 사진 저장
    setImageDownloadUrlsValued(uploadUrls); // uploadImageUrls detectorModel 저장

    // 차감 될 전체 금액 (FULL_PRICE)
    logger.i(detectorUserModel.value.counter!);
    logger.i(detectorUserModel.value.price!);

    num fullPrice =
        (detectorUserModel.value.counter! * detectorUserModel.value.price!)
            .floor();
    setFullPriceValued(fullPrice);

    // issues: #47 부동소수점으로 계산할 경우 계산식 자체의 값이 변경되는 문제있음 - ellee
    // 1차 지급금액 (FIRST_PRICE)
    d(String s) => Decimal.parse(s);
    String tmpfirstPrice = ((d(detectorUserModel.value.price!.toString()) -
                (d(detectorUserModel.value.price!.toString()) *
                    d(SELLDY_PEE))) *
            d(FIRST_PEE))
        .toString(); // (이용자에게 줄 포인트 - (이용자에게 줄 포인트 * 0.30(수수료)) * 1차 포인트)
    num firstPrice = num.parse(tmpfirstPrice).floor();
    setFirstPriceValued(firstPrice);

    // 2차 지급금액 (SECOUND_PRICE)
    String tmpsecondPrice = ((d(detectorUserModel.value.price!.toString()) -
                (d(detectorUserModel.value.price!.toString()) *
                    d(SELLDY_PEE))) *
            d(SECOND_PEE))
        .toString();
    num secondPrice = num.parse(tmpsecondPrice).floor();
    setSecoundPriceValued(secondPrice);

    // FCM 메시지에서 볼 금액  (FCM_VIEW_PRICE)
    String tmpfcmViewPrice = (d(detectorUserModel.value.price!.toString()) -
            (d(detectorUserModel.value.price!.toString()) * d(SELLDY_PEE)) *
                d(FIRST_PEE))
        .toString();
    num fcmViewPrice = num.parse(tmpfcmViewPrice).floor();
    setFCMViewPriceValued(fcmViewPrice);

    // 환불 금액 (REFUND_PRICE)
    String tmprefundPrice = (d(detectorUserModel.value.price!.toString()) -
            (d(detectorUserModel.value.price!.toString()) * d(SELLDY_PEE)))
        .toString();
    tmprefundPrice = (d(tmprefundPrice) * (d('1') - d(FIRST_PEE))).toString();
    tmprefundPrice = (d(tmprefundPrice) *
            (d('1') -
                (d(detectorUserModel.value.expiredDay!.toString()) *
                    d(EXPIRE_PEE))))
        .toString();
    num refundPrice = num.parse(tmprefundPrice).floor();
    setRefundPriceValued(refundPrice);

    // 포인트 관련 부분
    // UserController.to.updateCoin(-fullPrice);

    await DetectorRepository.createNewItem(detectorUserModel.value, detectorKey,
        userKey); // Board Collection 게시물 생성
  }

  // 필터값을 이용하여 사용자키값이 몇개인지 알려주는 함수
  // detectorUserModel에 UserList값이 들어감

  Future<int> detector(
      String birth,
      // issues: #46 학력정보 값 검색 - ellee
      String education,
      String gender,
      String nationality,
      String maritalstatus,
      String children,
      RangeValues bodyHeight,
      RangeValues bodyWeight,
      RangeValues bodyLeftVision,
      RangeValues bodyRightVision,
      String bodyBloodType,
      RangeValues bodyFootSize,
      // issues: #45 건강정보 값 검색 - ellee
      RangeValues healthTabacco,
      String healthAlcohol,
      RangeValues healthExercise,
      // issues: #51 성격정보 값 검색 - ellee
      List personalityMBTI,
      // issues: #54 별자리 성격정보 검색 - ellee
      List personalityStarSign,
      // issues: #55 경제정보 검색 - ellee
      List economicProperty,
      List economicCar,
      List economicCarFuel) async {
    List<String> allUsers = [];
    List<String> tmpUsers = [];
    // 검색된 유저의 키값을 넣는 곳
    List<String> detectorUserList = await DetectorRepository.detectorUser(
        birth, education, gender, nationality, maritalstatus, children);
    allUsers = detectorUserList;
    // 신체정보 리스트
    List<String> detectorBodyUserList =
        await DetectorRepository.detectorBodyUser(bodyHeight, bodyWeight,
            bodyLeftVision, bodyRightVision, bodyBloodType, bodyFootSize);
    // 건강정보 리스트
    List<String> detectorHealthUserList =
        await DetectorRepository.detectorHealthUser(
            healthTabacco, healthAlcohol, healthExercise);

    // 성격정보 리스트
    List<String> detectorPersonalityList =
        await DetectorRepository.detectorPersonalityUser(
            personalityMBTI, personalityStarSign);

    // issues: #55 경제 정보 검색 리스트 생성
    List<String> detectorEconomicList =
        await DetectorRepository.detectorEconomicUser(
            economicProperty, economicCar, economicCarFuel);
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < tmpUsers.length; i++) {
      if (detectorBodyUserList.contains(tmpUsers[i])) {
        allUsers.add(tmpUsers[i]);
      }
    }
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < tmpUsers.length; i++) {
      if (detectorHealthUserList.contains(tmpUsers[i])) {
        allUsers.add(tmpUsers[i]);
      }
    }
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < tmpUsers.length; i++) {
      if (detectorPersonalityList.contains(tmpUsers[i])) {
        allUsers.add(tmpUsers[i]);
      }
    }
    // issues: #55 경제정보 입력, 검색 생성 - ellee
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < tmpUsers.length; i++) {
      if (detectorEconomicList.contains(tmpUsers[i])) {
        allUsers.add(tmpUsers[i]);
      }
    }

    // 배포 시 무조건 주석해제
    allUsers.remove(userKey); // 검색자신의 키 삭제
    // 필터두개 종합해야함
    allUsers.shuffle();
    setDetectorUserList(allUsers);

    isLoading.value = false;
    return allUsers.length;
  }

  // 재전송 detector
  Future<void> reDetector(List<String> detectorUserList) async {
    setDetectorUserList(detectorUserList); // 재전송 유저키목록을 넣음
    setDetecotorUserTokenList(detectorUserList); // 재전송 유저토큰목록을 넣음
    modeChangePaymentInit(); // 모드항목들 초기화
  }

  // 서버에 사진을 저장하고 저장된 사진의 URL을 가져오는 함수
  Future<List<String>> uploadImages(
      List<dynamic> images, String searchKey) async {
    List<String> downloadUrls =
        await DetectorRepository.uploadImages(images, searchKey);
    return downloadUrls;
  }

  // Cloud Functions 로 옮겨짐
  // detetor 결과페이지에서 여러명에게 1차 포인트(정보이용료) 지급하는 함수
  // Future usersPointPayment() async {
  //   for (String userKey in detectorUserModel.value.users!) {
  //     await UserController.to.addOtherUserPoint(
  //         userKey,
  //         ((detectorUserModel.value.price! -
  //                 (detectorUserModel.value.price! * SELLDY_PEE)) *
  //             FIRST_PEE),
  //         'information_use'); // (이용자에게 줄 포인트 - (이용자에게 줄 포인트 * 0.30(수수료)) * 1차 포인트)
  //     sendUserCount.value = sendUserCount.value + 1; // 전송될때마다 한개씩 더함.
  //   }
  // }
}

// const Map<String, String> expiredDayMapEngToKor = {
//   'none': '만료일을 선택해주세요',
//   '1': '1일',
//   '2': '2일',
//   '3': '3일',
//   '4': '4일',
//   '5': '5일',
//   '6': '6일',
//   '7': '7일',
// };

// const Map<String, String> expiredDayMapKorToEng = {
//   '만료일을 선택해주세요': 'none',
//   '1일': '1',
//   '2일': '2',
//   '3일': '3',
//   '4일': '4',
//   '5일': '5',
//   '6일': '6',
//   '7일': '7',
// };
