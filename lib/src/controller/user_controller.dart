import 'package:get/get.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/model/user_model.dart';
import 'package:yab_v2/src/repository/point_report_repository.dart';
import 'package:yab_v2/src/repository/user_repository.dart';

// 신규 정보를 추가할 시
// onInit에 추가를 함수를 추가해야함. (addBirth()함수 참고)
// getUser 함수에 신규 정보 값 추가 & Rxbool값 추가 (정보 페이지에 추가되있는 거 확인하는 변수)
// 신규 유저가 들어왔을 시 데이터베이스 추가 (login_page.dart => (signInWithGoogle().then & signInWithApple().then) birth: Birth.init() 참고)
// repository 필드 추가시 .set의 옵션 필히 추가 SetOptions(merge: true) 추가 않할 시 기존 데이터 지워지고 set데이터만 추가 됨

class UserController extends GetxController {
  static UserController get to => Get.find();

// issues: #52 오늘 출석란이 비어있을 경우 팝업 생성 - ellee
  RxBool attendanceToday = false.obs;

// 기본정보 값
  RxBool genderMale = false.obs;
  RxBool genderWoman = false.obs;
  RxBool nationalityLocal = false.obs;
  RxBool nationalityForeigner = false.obs;
  RxBool maritalstatusMarried = false.obs;
  RxBool maritalstatusSingle = false.obs;
  RxBool childrenExistence = false.obs;
  RxBool childrenNonexistence = false.obs;
  RxString birth = ''.obs;
  RxString address = ''.obs;
  // issues: #46 학력정보 입력, 검색 생성
  RxString education = ''.obs;
  RxBool educationElementary = false.obs;
  RxBool educationMiddle = false.obs;
  RxBool educationHigh = false.obs;
  RxBool educationJuniorCollege = false.obs;
  RxBool educationUniversity = false.obs;
  RxBool educationMaster = false.obs;
  RxBool educationDoctor = false.obs;
  RxInt userEducationInfoCount = 0.obs;
  RxInt userBasicInfoCount = 0.obs;

  // 신체정보 값
  // issues: #48 신체정보 초기 입력 시 버튼눌러 활성화 할 수 있도록 변경 - ellee
  RxBool bodyHeightFilter = false.obs;
  RxBool bodyWeightFilter = false.obs;
  RxBool bodyVisionFilter = false.obs;
  RxBool bodyFootSizeFilter = false.obs;

  Rx<num> bodyHeight = 100.obs;
  Rx<num> bodyWeight = 20.obs;
  RxDouble bodyLeftVision = 0.0.obs;
  RxDouble bodyRightVision = 0.0.obs;
  RxBool bodyBloodTypeA = false.obs;
  RxBool bodyBloodTypeB = false.obs;
  RxBool bodyBloodTypeO = false.obs;
  RxBool bodyBloodTypeAB = false.obs;
  Rx<num> bodyFootSize = 200.obs;
  RxInt userBodyInfoCount = 0.obs;
  RxBool startInPopup = false.obs;
  RxInt totalCount = 0.obs;

  // 건강정보 값
  // issues: #45 건강정보 입력, 검색 생성 - ellee
  RxBool healthTabaccoFilter = false.obs;
  RxBool healthExerciseFilter = false.obs;

  Rx<num> healthTabacco = 0.obs;
  RxString healthAlcohol = ''.obs;
  Rx<num> healthExercise = 0.obs;
  RxBool healthAlcohol0 = false.obs;
  RxBool healthAlcohol1 = false.obs;
  RxBool healthAlcohol2 = false.obs;
  RxBool healthAlcohol3 = false.obs;
  RxInt userHealthInfoCount = 0.obs;

  // 성격정보 값
  // issues: #51 성격정보 입력, 검색 생성 - ellee
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
  RxInt userPersonalityInfoCount = 0.obs;

  // issues: #54 별자리 성격정보 입력 추가 - ellee
  RxBool personalityStarSign = false.obs;

  // issues: #55 경제정보 입력 컨트롤러 - ellee
  RxBool economicProperty = false.obs;
  RxBool economicJeonse = false.obs;
  RxBool economicMyHouse = false.obs;
  RxBool economicCar = false.obs;
  RxBool economicMyCar = false.obs;
  RxBool economicRentCar = false.obs;
  RxBool economicLeaseCar = false.obs;
  RxBool economicCarElectric = false.obs;
  RxBool economicCarLPG = false.obs;
  RxBool economicCarGasolin = false.obs;
  RxBool economicCarDiesel = false.obs;
  RxInt userEconomicInfoCount = 0.obs;

  Rx<UserModel> userModel = UserModel().obs;
  @override
  void onInit() async {
    await getUser(AuthController.to.userModel.value.userKey!);
    await addBirth(); // 신규 생일 구조체 추가 최초 실행시 유저 document에 해당 필드가 Null일때 생성
    // issues: #46 최초 학력정보가 없을경우 생성
    await addEducation();
    await addAddress(); // 신규 주소 구조체 추가 최초 실행시 유저 document에 해당 필드가 Null일때 생성
    await addBody(); // 신체정보 없을경우 생성
    await addHealth(); // 건강정보 없을경우 생성
    await createPremiumUser();
    // issues: #51 최초 성격정보가 없을 경우 생성
    await addPersonality();
    // issues: #55 최초 경제정보가 없을 경우 생성
    await addEconomic();

    await getUser(AuthController.to.userModel.value.userKey!);
    // numberPicker사용 시 값이 지속적으로 변하여 debounce를 통해 멈춰있을때 값 적용하도록 변경
    // issues: #45 건강정보 입력부분
    debounce(bodyHeight, (_) {
      setBodyHeight(bodyHeight.value, 50);
    }, time: const Duration(seconds: 1));
    debounce(bodyWeight, (_) {
      setBodyWeight(bodyWeight.value, 50);
    }, time: const Duration(seconds: 1));
    debounce(bodyLeftVision, (_) {
      setBodyLeftVision(bodyLeftVision.value, bodyRightVision.value, 50);
    }, time: const Duration(seconds: 1));
    debounce(bodyRightVision, (_) {
      setBodyRightVision(bodyRightVision.value, bodyLeftVision.value, 50);
    }, time: const Duration(seconds: 1));
    debounce(bodyFootSize, (_) {
      setBodyFootSize(bodyFootSize.value, 50);
    }, time: const Duration(seconds: 1));
    debounce(healthTabacco, (_) {
      setHealthTabacco(healthTabacco.value, 50);
    }, time: const Duration(seconds: 1));
    debounce(healthExercise, (_) {
      setHealthExercise(healthExercise.value, 50);
    }, time: const Duration(seconds: 1));
    super.onInit();
  }

  // 서버에 유저의 uid값이 있는지 확인하는 단계
  Future<void> getUser(String uid) async {
    var userData = await UserRepository.loginUserByUid(uid); // 서버의 uid 값을 가져옴
    if (userData != null) {
      // 데이터가 NULL이 아니면 유저가 있는것임.
      userModel(userData); // user에 값을 넣음
      // 유저 기본정보 카운트 시작
      userBasicInfoCount = 1.obs;
      userEducationInfoCount = 0.obs;
      if (userData.gender?.giveCheckCoin == true) {
        userBasicInfoCount + 1;
        if (userData.gender?.gender == 'male') {
          genderMale = true.obs;
        } else {
          genderWoman = true.obs;
        }
      }
      if (userData.nationality?.giveCheckCoin == true) {
        userBasicInfoCount + 1;
        if (userData.nationality?.nationality == 'local') {
          nationalityLocal = true.obs;
        } else {
          nationalityForeigner = true.obs;
        }
      }
      if (userData.maritalStatus?.giveCheckCoin == true) {
        userBasicInfoCount + 1;
        if (userData.maritalStatus?.maritalstatus == 'married') {
          maritalstatusMarried = true.obs;
        } else {
          maritalstatusSingle = true.obs;
        }
      }
      if (userData.children?.giveCheckCoin == true) {
        userBasicInfoCount + 1;
        if (userData.children?.children == 'existence') {
          childrenExistence = true.obs;
        } else {
          childrenNonexistence = true.obs;
        }
      }
      if (userData.birth != null) {
        if (userData.birth!.giveCheckCoin == true) {
          String? birthday = userData.birth?.birth;
          birth.value = birthday!;
          userBasicInfoCount + 1;
        }
      }
      // issues: #46 학력정보 카운트 - ellee
      userEducationInfoCount = 0.obs;
      if (userData.education != null) {
        if (userData.education!.giveCheckCoin == true) {
          String? finaleducation = userData.education?.education;
          education.value = finaleducation!;
          userEducationInfoCount + 1;
          if (education.value == 'Elementary') {
            educationElementary.value = true;
          } else if (education.value == 'Middle') {
            educationMiddle.value = true;
          } else if (education.value == 'High') {
            educationHigh.value = true;
          } else if (education.value == 'JuniorCollege') {
            educationJuniorCollege.value = true;
          } else if (education.value == 'University') {
            educationUniversity.value = true;
          } else if (education.value == 'Master') {
            educationMaster.value = true;
          } else if (education.value == 'Doctor') {
            educationDoctor.value = true;
          }
        }
      }
      if (userData.address != null) {
        if (userData.address!.giveCheckCoin == true) {
          String? level1 = userData.address!.parcelAddress!.level1!;
          String? level2 = userData.address!.parcelAddress!.level2!;
          String? level4A = userData.address!.parcelAddress!.level4A!;
          address.value = '$level1 $level2 $level4A';
          userBasicInfoCount + 1;
        }
      }

      // 유저 신체정보 카운트 시작
      userBodyInfoCount = 0.obs;
      if (userData.body != null) {
        if (userData.body?.bodyHeight?.giveCheckCoin == true) {
          num? tmpBodyHeight = userData.body?.bodyHeight?.bodyHeight;
          bodyHeight.value = tmpBodyHeight!;
          userBodyInfoCount + 1;
          bodyHeightFilter.value = true;
        }
        if (userData.body?.bodyWeight?.giveCheckCoin == true) {
          num? tmpBodyWeight = userData.body?.bodyWeight?.bodyWeight;
          bodyWeight.value = tmpBodyWeight!;
          userBodyInfoCount + 1;
          bodyWeightFilter.value = true;
        }
        // 시력 좌 우 체크 후 둘다 코인지급이력이 있으면 카운트 +1
        if (userData.body?.bodyVision?.giveCheckCoin == true) {
          double? tmpBodyLeftVision = userData.body?.bodyVision?.bodyLeftVision;
          bodyLeftVision.value = tmpBodyLeftVision!;
        }
        if (userData.body?.bodyVision?.giveCheckCoinVision == true) {
          double? tmpBodyRightVision =
              userData.body?.bodyVision?.bodyRightVision;
          bodyRightVision.value = tmpBodyRightVision!;
        }
        if (userData.body?.bodyVision?.giveCheckCoin == true &&
            userData.body?.bodyVision?.giveCheckCoinVision == true) {
          userBodyInfoCount + 1;
          bodyVisionFilter.value = true;
        }
        if (userData.body?.bodyBloodType?.giveCheckCoin == true) {
          userBodyInfoCount + 1;
          if (userData.body?.bodyBloodType?.bodyBloodType == 'A') {
            bodyBloodTypeA = true.obs;
          } else if (userData.body?.bodyBloodType?.bodyBloodType == 'B') {
            bodyBloodTypeB = true.obs;
          } else if (userData.body?.bodyBloodType?.bodyBloodType == 'O') {
            bodyBloodTypeO = true.obs;
          } else {
            bodyBloodTypeAB = true.obs;
          }
        }
        if (userData.body?.bodyFootSize?.giveCheckCoin == true) {
          num? tmpBodyFootSize = userData.body?.bodyFootSize?.bodyFootSize;
          bodyFootSize.value = tmpBodyFootSize!;
          userBodyInfoCount + 1;
          bodyFootSizeFilter.value = true;
        }
      }
      // 유저 건강정보 카운트 시작
      userHealthInfoCount = 0.obs;
      if (userData.health != null) {
        if (userData.health?.healthTabacco?.giveCheckCoin == true) {
          num? tmpHealthTabacco = userData.health?.healthTabacco?.healthTabacco;
          healthTabacco.value = tmpHealthTabacco!;
          userHealthInfoCount + 1;
          healthTabaccoFilter.value = true;
        }
        if (userData.health?.healthAlcohol?.giveCheckCoin == true) {
          userHealthInfoCount + 1;
          String? tmpHealthAlcohol =
              userData.health?.healthAlcohol?.healthAlcohol;
          healthAlcohol.value = tmpHealthAlcohol!;
          if (healthAlcohol.value == '0') {
            healthAlcohol0.value = true;
          } else if (healthAlcohol.value == '1') {
            healthAlcohol1.value = true;
          } else if (healthAlcohol.value == '2') {
            healthAlcohol2.value = true;
          } else if (healthAlcohol.value == '3') {
            healthAlcohol3.value = true;
          }
        }
        if (userData.health?.healthExercise?.giveCheckCoin == true) {
          num? tmpHealthExercise =
              userData.health?.healthExercise?.healthExercise;
          healthExercise.value = tmpHealthExercise!;
          userHealthInfoCount + 1;
          healthExerciseFilter.value = true;
        }
      }
      // 유저 성격정보 카운트
      userPersonalityInfoCount = 0.obs;
      if (userData.personality != null) {
        if (userData.personality?.personalityMBTI?.giveCheckCoin == true) {
          userPersonalityInfoCount + 1;
          String? tmpPersonalityMBTI =
              userData.personality?.personalityMBTI?.personalityMBTI;
          if (tmpPersonalityMBTI == 'ISTJ') {
            personalityISTJ.value = true;
          } else if (tmpPersonalityMBTI == 'ISTP') {
            personalityISTP.value = true;
          } else if (tmpPersonalityMBTI == 'ISFJ') {
            personalityISFJ.value = true;
          } else if (tmpPersonalityMBTI == 'ISFP') {
            personalityISFP.value = true;
          } else if (tmpPersonalityMBTI == 'INTJ') {
            personalityINTJ.value = true;
          } else if (tmpPersonalityMBTI == 'INTP') {
            personalityINTP.value = true;
          } else if (tmpPersonalityMBTI == 'INFJ') {
            personalityINFJ.value = true;
          } else if (tmpPersonalityMBTI == 'INFP') {
            personalityINFP.value = true;
          } else if (tmpPersonalityMBTI == 'ESTJ') {
            personalityESTJ.value = true;
          } else if (tmpPersonalityMBTI == 'ESTP') {
            personalityESTP.value = true;
          } else if (tmpPersonalityMBTI == 'ESFJ') {
            personalityESFJ.value = true;
          } else if (tmpPersonalityMBTI == 'ESFP') {
            personalityESFP.value = true;
          } else if (tmpPersonalityMBTI == 'ENTJ') {
            personalityENTJ.value = true;
          } else if (tmpPersonalityMBTI == 'ENTP') {
            personalityENTP.value = true;
          } else if (tmpPersonalityMBTI == 'ENFJ') {
            personalityENFJ.value = true;
          } else if (tmpPersonalityMBTI == 'ENFP') {
            personalityENFP.value = true;
          }
        }
        // issues: #54 별자리 성격정보 입력 추가 - ellee
        if (userData.personality?.personalityStarSign?.giveCheckCoin == true) {
          personalityStarSign.value = true;
          userPersonalityInfoCount + 1;
        }
      }

      // issues: #55 경제정보 컨트롤러 - ellee
      userEconomicInfoCount = 0.obs;
      if (userData.economic != null) {
        if (userData.economic?.economicProperty?.giveCheckCoin == true) {
          userEconomicInfoCount + 1;
          economicProperty.value = true;
          String? tmpEconomicProperty =
              userData.economic?.economicProperty?.economicProperty;
          if (tmpEconomicProperty == 'MyHouse') {
            economicMyHouse.value = true;
          } else if (tmpEconomicProperty == 'Jeonse') {
            economicJeonse.value = true;
          }
        }
        if (userData.economic?.economicCar?.economicCar != 'none') {
          economicCar.value = true;
          String? tmpEconomicCar = userData.economic?.economicCar?.economicCar;
          if (tmpEconomicCar == 'MyCar') {
            economicMyCar.value = true;
          } else if (tmpEconomicCar == 'RentCar') {
            economicRentCar.value = true;
          } else if (tmpEconomicCar == 'LeaseCar') {
            economicLeaseCar.value = true;
          }
          if (userData.economic?.economicCar?.giveCheckCoin == true) {
            userEconomicInfoCount + 1;
            economicCar.value = true;
            String? tmpEconomicCarFuel =
                userData.economic?.economicCar?.economicCarFuel;
            if (tmpEconomicCarFuel == 'Electric') {
              economicCarElectric.value = true;
            } else if (tmpEconomicCarFuel == 'LPG') {
              economicCarLPG.value = true;
            } else if (tmpEconomicCarFuel == 'Gasolin') {
              economicCarGasolin.value = true;
            } else if (tmpEconomicCarFuel == 'Diesel') {
              economicCarDiesel.value = true;
            }
          }
        }
      }
    }
    totalCount.value = (userBasicInfoCount.value +
            userBodyInfoCount.value +
            userHealthInfoCount.value +
            userEducationInfoCount.value +
            userPersonalityInfoCount.value +
            userEconomicInfoCount.value -
            20) *
        -1;
  }

  // Controller UserModel에 담겨져 있는 Coin값을 변경
  // 서버에 있는데이터는 변경 안함
  // Cloud Function을 이용하여 User의 Coin값을 변경
  updatePlusCoin(num point) {
    num userCoin = userModel.value.coin!;
    userModel.update((_user) {
      _user!.coin = userCoin + point;
      update();
    });
  }

  updateSubCoin(num point) {
    num userCoin = userModel.value.coin!;
    userModel.update((_user) {
      _user!.coin = userCoin - point;
      update();
    });
  }

  // 서버에 있는 이메일 주소 업데이트
  // 컨트롤러 유저모델 email 업데이트
  // Anonymous 계정일 때 함수 사용
  Future updateEmailAddress(String email) async {
    userModel.update((_user) {
      _user!.email = email;
    }); // 컨트롤러 이메일 주소 변경
    await UserRepository.updateEmailAddress(email); // 서버데이터 이메일 주소 변경
  }

  // 서버에 있는 성별 정보를 갱신하고 포인트 지급
  // 유저모델 gender 업데이트
  Future setGender(String data, num addPoint) async {
    userModel.update((_user) {
      _user!.gender!.gender = data;
    }); // userModel에서 업데이트
    await UserRepository.setGender(data, addPoint);
  }

  // 서버에 있는 국적 정보를 갱신하고 포인트 지급
  // 유저모델 nationality 업데이트
  Future setNationality(String data, num addPoint) async {
    userModel.update((_user) {
      _user!.nationality!.nationality = data;
    }); // userModel에서 업데이트
    await UserRepository.setNationality(data, addPoint);
  }

  // 서버에 있는 결혼유무 정보를 갱신하고 포인트 지급
  // 유저모델 maritalstatus 업데이트
  Future setMaritalstatus(String data, num addPoint) async {
    userModel.update((_user) {
      _user!.maritalStatus!.maritalstatus = data;
    }); // userModel에서 업데이트
    await UserRepository.setMaritalstatus(data, addPoint);
  }

  // 서버에 있는 아이유무 정보를 갱신하고 포인트 지급
  // 유저모델 children 업데이트
  Future setChildren(String data, num addPoint) async {
    userModel.update((_user) {
      _user!.children!.children = data;
    }); // userModel에서 업데이트
    await UserRepository.setChildren(data, addPoint);
  }

  // Birth가 Null일 때 생성
  Future addBirth() async {
    userModel.update((_user) async {
      if (_user!.birth == null) {
        await UserRepository.createBirth();
      }
    });
  }

  // Address가 Null일 때 생성
  Future addAddress() async {
    userModel.update((_user) async {
      if (_user!.address == null) {
        await UserRepository.createAddress();
      }
    });
  }

  // body가 null일 때 생성
  Future addBody() async {
    userModel.update((_user) async {
      if (_user!.body == null) {
        await UserRepository.createBody();
      }
    });
  }

  // issues: #45 건강정보 입력, 검색 생성 - ellee
  // Health가 null일 때 생성
  Future addHealth() async {
    userModel.update((_user) async {
      if (_user!.health == null) {
        await UserRepository.createHealth();
      }
    });
  }

  // issues: #46 학력정보 입력, 검색 생성 - ellee
  // education null일때 생성
  Future addEducation() async {
    userModel.update((_user) async {
      if (_user!.education == null) {
        await UserRepository.createEducation();
      }
    });
  }

  // issues: #51 성격정보 입력, 검색 생성 - ellee
  Future addPersonality() async {
    userModel.update((_user) async {
      if (_user!.personality == null) {
        await UserRepository.createPersonality();
      }
    });
  }

  // issues: #55 경제정보 입력 모델링 - ellee
  Future addEconomic() async {
    userModel.update((_user) async {
      if (_user!.economic == null) {
        await UserRepository.createEconomic();
      }
    });
  }

  Future createPremiumUser() async {
    userModel.update((_user) async {
      if (_user!.premiumUser == null) {
        await UserRepository.createPremiumUser();
      }
    });
  }

  Future setBirth(String data, num addPoint) async {
    userModel.update((_user) {
      _user!.birth!.birth = data;
    }); // userModel에서 업데이트
    await UserRepository.setBirth(data, addPoint);
  }

  // issues: #46 학력정보 입력, 검색 생성 - ellee
  Future setEducation(String data, num addPoint) async {
    userModel.update((_user) {
      _user!.education!.education = data;
    });
    await UserRepository.setEducation(data, addPoint);
  }

  // 유저모델 키 업데이트
  Future setBodyHeight(num data, num addPoint) async {
    userModel.update((_user) {
      _user!.body!.bodyHeight!.bodyHeight = data;
    });
    await UserRepository.setBodyHeight(data, addPoint);
  }

  // 유저모델 키 업데이트
  Future setBodyWeight(num data, num addPoint) async {
    userModel.update((_user) {
      _user!.body!.bodyWeight!.bodyWeight = data;
    });
    await UserRepository.setBodyWeight(data, addPoint);
  }

  // 유저모델 시력 좌 업데이트
  Future setBodyLeftVision(
      double data, double rightVision, num addPoint) async {
    userModel.update((_user) {
      _user!.body!.bodyVision!.bodyLeftVision = data;
    });
    await UserRepository.setBodyLeftVision(data, rightVision, addPoint);
  }

  // 유저모델 시력 우 업데이트
  Future setBodyRightVision(
      double data, double leftVision, num addPoint) async {
    userModel.update((_user) {
      _user!.body!.bodyVision!.bodyRightVision = data;
    });
    await UserRepository.setBodyRightVision(data, leftVision, addPoint);
  }

  // 유저모델 혈액형 업데이트
  Future setbodyBloodType(String data, num addPoint) async {
    userModel.update((_user) {
      _user!.body!.bodyBloodType!.bodyBloodType = data;
    });
    await UserRepository.setbodyBloodType(data, addPoint);
  }

  // 유저모델 신발사이즈 업데이트
  Future setBodyFootSize(num data, num addPoint) async {
    userModel.update((_user) {
      _user!.body!.bodyFootSize!.bodyFootSize = data;
    });
    await UserRepository.setBodyFootSize(data, addPoint);
  }

  // issues: #45 건강정보 입력, 검색 생성 - ellee
  // 유저 모델 흡연량
  Future setHealthTabacco(num data, num addPoint) async {
    userModel.update((_user) {
      _user!.health!.healthTabacco!.healthTabacco = data;
    });
    await UserRepository.setHealthTabacco(data, addPoint);
  }

  // 유저모델 주량
  Future setHealthAlcohol(String data, num addPoint) async {
    userModel.update((_user) {
      _user!.health!.healthAlcohol!.healthAlcohol = data;
    });
    await UserRepository.setHealthAlcohol(data, addPoint);
  }

  // 유저모델 운동량
  Future setHealthExercise(num data, num addPoint) async {
    userModel.update((_user) {
      _user!.health!.healthExercise!.healthExercise = data;
    });
    await UserRepository.setHealthExercise(data, addPoint);
  }

// issues: #51 성격정보 입력, 검색 생성 - ellee
// 유저모델 MBTI
  Future setPersonalityMBTI(String data, num addPoint) async {
    userModel.update((_user) {
      _user!.personality!.personalityMBTI!.personalityMBTI = data;
    });
    await UserRepository.setPersonalityMBTI(data, addPoint);
  }

  // issues: #54 별자리 성격정보 입력 - ellee
  Future setPersonalityStarSign(String data, num addPoint) async {
    userModel.update((_user) {
      _user!.personality!.personalityStarSign!.personalityStarSign = data;
    });
    await UserRepository.setPersonalityStarSign(data, addPoint);
  }

  // issues: #55 경제정보 입력 - ellee
  Future setEconomicProperty(String data, num addPoint) async {
    userModel.update((_user) {
      _user!.economic!.economicProperty!.economicProperty = data;
    });
    await UserRepository.setEconomicProperty(data, addPoint);
  }

  // 차량정보만 입력할 경우에는 포인트 지급하지 않고 검색되지않음, 차량정보는 db저장됨
  Future setEconomicCarInfo(String data) async {
    userModel.update((_user) {
      _user!.economic!.economicCar!.economicCar = data;
    });
    await UserRepository.setEconomicCarInfo(data);
  }

  // 연료정보까지 입력해야 포인트 지급됨
  Future setEconomicCar(String data, num addPoint) async {
    userModel.update((_user) {
      _user!.economic!.economicCar!.economicCarFuel = data;
    });
    await UserRepository.setEconomicCar(data, addPoint);
  }

  // 서버에 있는 포인트 정보를 가져오는 함수
  Future<num> getPoint() async {
    return await UserRepository.getPoint();
  }

  // 해당 유저에게 포인트 지급
  Future addMyPoint(String userKey, num addPoint, String itemName) async {
    await PointReportRepository.createNewItem(userKey, addPoint, itemName);
    return await UserRepository.addMyPoint(userKey, addPoint);
  }

  // 해당 유저에게 QR 포인트 지급
  Future addOtherUserPoint(
      String userKey, num addPoint, String itemName) async {
    await PointReportRepository.createNewItem(userKey, addPoint, itemName);
    return await UserRepository.addOtherUserPoint(userKey, addPoint);
  }

  // 해당 유저에게 포인트 차감
  Future subPoint(String userKey, num subPoint, String itemName) async {
    await PointReportRepository.createNewItem(userKey, -subPoint, itemName);
    return await UserRepository.subPoint(userKey, subPoint);
  }

  // 상점등록 유저 등록
  Future setPremiumUser(String userKey) async {
    return await UserRepository.setPremiumUser(userKey);
  }

  // 상점등록 유저 해제
  Future delPremiumUser(String userKey) async {
    return await UserRepository.delPremiumUser(userKey);
  }

  // issues: #50 로그아웃 시 FCM 토큰 초기화 - ellee
  Future logoutDeleteFCMToken() async {
    await UserRepository.logoutDeleteFCMToken();
  }

  // 유저정보 삭제 함수 (회원탈퇴) : 해당 유저의 Document & Authentication을 삭제
  Future deleteUser() async {
    await UserRepository.deleteUser();
  }
}
