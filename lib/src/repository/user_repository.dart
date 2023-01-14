import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/notification_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/model/user_bodyinfo/user_body.dart';
import 'package:yab_v2/src/model/user_economicinfo/user_economic.dart';
import 'package:yab_v2/src/model/user_healthinfo/user_health.dart';
import 'package:yab_v2/src/model/user_info/address.dart';
import 'package:yab_v2/src/model/user_info/birth.dart';
import 'package:yab_v2/src/model/user_info/children.dart';
import 'package:yab_v2/src/model/user_info/education.dart';
import 'package:yab_v2/src/model/user_info/gender.dart';
import 'package:yab_v2/src/model/user_info/maritalstatus.dart';
import 'package:yab_v2/src/model/user_info/nationality.dart';
import 'package:yab_v2/src/model/user_model.dart';
import 'package:yab_v2/src/model/user_personalityinfo/user_personality.dart';
import 'package:yab_v2/src/utils/data_keys.dart';
import 'package:yab_v2/src/utils/logger.dart';

final String userKey =
    FirebaseAuth.instance.currentUser!.uid; // 로그인된 유저 키값을 가져 옴

class UserRepository {
  // FCM토큰을 가져와 해당 유저의 Document에 fcm_token Field에 값을 넣는 함수
  static Future<void> updateFCMToken(String uid) async {
    String? token = await NotificationController.to.getToken(); // FCM토큰 가져오기
    await FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(uid)
        .update({FIELD_FCMTOKEN: token});
  }

  // USERS COLLECTION 안에 해당 uid 값이 있는지 확인 하는 함수 있으면 UserModel을 가져옴
  static Future<UserModel?> loginUserByUid(String uid) async {
    QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
        .collection(COL_USERS)
        .where(FIELD_USERKEY, isEqualTo: uid)
        .get();

    if (data.size == 0) {
      return null;
    } else {
      return UserModel.fromJson(data.docs.first.data());
    }
  }

  // 신규유저인지 아닌지 확인하는 함수
  // 신규유저이면 데이터베이스에 저장 (저장위치 : users COLLECTION => [KEY] Document => FIELD값)
  // 기존유저이면 데이터베이스에 저장하지 않음
  static Future<bool> signup(UserModel userModel) async {
    try {
      UserModel? userData = await loginUserByUid(userModel
          .userKey!); // uid값을 가지고 USERS COLLECTION => [KEY] => userKey값이 있는지 확인 (있으면 기존 유저 / 없으면 신규 유저)
      // userData가 null이 아니면 기존유저
      if (userData != null) {
        return true; // 기존 유저
      } else {
        // userData가 null이면 신규유저이므로 데이터베이스에 저장 함.
        await FirebaseFirestore.instance
            .collection(COL_USERS)
            .doc(userModel.userKey)
            .set(userModel.toJson());
        return true; // 신규 유저
      }
    } catch (e) {
      logger.i(e);
      return false; // 에러 발생 Crashlytics
    }
  }

  // 나의 페이지에서 성별 정보를 입력하고 서버 데이터 갱신 및 포인트 지급
  static Future<void> setGender(String data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // // giveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_GENDER][FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userBasicInfoCount + 1;
    }

    await docRef.update({
      STRUCT_GENDER:
          Gender(gender: data, updateTime: DateTime.now(), giveCheckCoin: true)
              .toJson()
    });
  }

  // 나의 페이지에서 국적 정보를 입력하고 서버 데이터 갱신 및 포인트 지급
  static Future<void> setNationality(String data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // // giveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_NATIONALITY][FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userBasicInfoCount + 1;
    }

    await docRef.update({
      STRUCT_NATIONALITY: Nationality(
              nationality: data,
              updateTime: DateTime.now(),
              giveCheckCoin: true)
          .toJson()
    });
  }

  // 나의 페이지에서 결혼 유무 정보를 입력하고 서버 데이터 갱신 및 포인트 지급
  static Future<void> setMaritalstatus(String data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // // giveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_MARITALSTATUS][FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userBasicInfoCount + 1;
    }

    await docRef.update({
      STRUCT_MARITALSTATUS: MaritalStatus(
              maritalstatus: data,
              updateTime: DateTime.now(),
              giveCheckCoin: true)
          .toJson()
    });
  }

  // 나의 페이지에서 자녀 유무 정보를 입력하고 서버 데이터 갱신 및 포인트 지급
  static Future<void> setChildren(String data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // // giveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_CHILDREN][FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userBasicInfoCount + 1;
    }

    await docRef.update({
      STRUCT_CHILDREN: Children(
              children: data, updateTime: DateTime.now(), giveCheckCoin: true)
          .toJson()
    });
  }

  // Anonymous -> Google 변경 시 이메일 주소값 변경
  static Future<void> updateEmailAddress(String email) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    // DocumentSnapshot<Map<String, dynamic>> docSnapshot =
    //     await docRef.get(); // 유저모델을 가져오기 위함

    await docRef.update({FIELD_EMAIL: email});
  }

  // birth 구조체 만드는 부분
  static Future<void> createBirth() async {
    await FirebaseFirestore.instance.collection(COL_USERS).doc(userKey).set(
        {STRUCT_BIRTH: Birth().toJson()},
        SetOptions(merge: true)); // db 생성부분 체크필요
  }

  // education 구조체 만드는 부분
  static Future<void> createEducation() async {
    await FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(userKey)
        .set({STRUCT_EDUCATION: Education().toJson()}, SetOptions(merge: true));
  }

  // address 구조체 만드는 부분
  static Future<void> createAddress() async {
    await FirebaseFirestore.instance.collection(COL_USERS).doc(userKey).set(
        {STRUCT_ADDRESS: Address().toJson()},
        SetOptions(merge: true)); // db 생성부분 체크필요
  }

// body 구조체 만드는 부분
  static Future<void> createBody() async {
    await FirebaseFirestore.instance.collection(COL_USERS).doc(userKey).set(
        {STRUCT_BODY: Body().toJson()},
        SetOptions(merge: true)); // db 생성부분 체크필요
  }

  // health 구조체 만드는 부분
  static Future<void> createHealth() async {
    await FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(userKey)
        .set({STRUCT_HEALTH: Health().toJson()}, SetOptions(merge: true));
  }

  // issues: #51 성격정보 입력, 검색 생성 - ellee
  static Future<void> createPersonality() async {
    await FirebaseFirestore.instance.collection(COL_USERS).doc(userKey).set(
        {STRUCT_PERSONALITY: Personality().toJson()}, SetOptions(merge: true));
  }

  // issues: #55 경제정보 입력 모델 생성 - ellee
  static Future<void> createEconomic() async {
    await FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(userKey)
        .set({STRUCT_ECONOMIC: Economic().toJson()}, SetOptions(merge: true));
  }

  // 상점등록유저 필드 만드는 부분
  static Future<void> createPremiumUser() async {
    await FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(userKey)
        .update({FIELD_PREMIUMUSER: false});
  }

  // address 정보를 서버 데이터 갱신 및 포인트 지급
  static Future<void> setAddress(num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // giveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_ADDRESS][FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userBasicInfoCount + 1;
    }

    // address 구조체 서버 갱신
    await docRef.update({
      STRUCT_ADDRESS: {
        STRUCT_ROAD: RoadAddress(
                level1: UserController
                    .to.userModel.value.address!.roadAddress!.level1,
                level2: UserController
                    .to.userModel.value.address!.roadAddress!.level2,
                level4A: UserController
                    .to.userModel.value.address!.roadAddress!.level4A,
                level4L: UserController
                    .to.userModel.value.address!.roadAddress!.level4L,
                level5: UserController
                    .to.userModel.value.address!.roadAddress!.level5,
                text: UserController
                    .to.userModel.value.address!.roadAddress!.text)
            .toJson(),
        STRUCT_PARCEL: ParcelAddress(
                level1: UserController
                    .to.userModel.value.address!.parcelAddress!.level1,
                level2: UserController
                    .to.userModel.value.address!.parcelAddress!.level2,
                level4A: UserController
                    .to.userModel.value.address!.parcelAddress!.level4A,
                level4L: UserController
                    .to.userModel.value.address!.parcelAddress!.level4L,
                level5: UserController
                    .to.userModel.value.address!.parcelAddress!.level5,
                text: UserController
                    .to.userModel.value.address!.parcelAddress!.text)
            .toJson(),
        FIELD_GEOFIREPOINT: GeoFirePoint(
                UserController
                    .to.userModel.value.address!.geoFirePoint!.latitude,
                UserController
                    .to.userModel.value.address!.geoFirePoint!.longitude)
            .data,
        FIELD_UPDATETIME: DateTime.now(),
        FIELD_GIVECHECKCOIN: true,
      },
    });
  }

// 나의 페이지에서 생년월일 정보를 입력하고 서버 데이터 갱신 및 포인트 지급
  static Future<void> setBirth(String data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // // giveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_BIRTH][FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userBasicInfoCount + 1;
    }

    await docRef.update({
      STRUCT_BIRTH:
          Birth(birth: data, updateTime: DateTime.now(), giveCheckCoin: true)
              .toJson()
    });
  }

  // issues: #46 학력정보 입력, 검색 생성 - ellee
  static Future<void> setEducation(String data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // // giveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_EDUCATION][FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userEducationInfoCount + 1;
    }

    await docRef.update({
      STRUCT_EDUCATION: Education(
              education: data, updateTime: DateTime.now(), giveCheckCoin: true)
          .toJson()
    });
  }

// 신체정보 키 업데이트
  static Future<void> setBodyHeight(num data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // // giveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_BODY][STRUCT_BODYHEIGHT]
        [FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userBodyInfoCount + 1;
    }

    await docRef.set({
      STRUCT_BODY: {
        STRUCT_BODYHEIGHT: BodyHeight(
                bodyHeight: data,
                updateTime: DateTime.now(),
                giveCheckCoin: true)
            .toJson()
      }
    }, SetOptions(merge: true));
  }

// 신체정보 몸무게 업데이트
  static Future<void> setBodyWeight(num data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // // giveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_BODY][STRUCT_BODYWEIGHT]
        [FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userBodyInfoCount + 1;
    }

    await docRef.set({
      STRUCT_BODY: {
        STRUCT_BODYWEIGHT: BodyWeight(
                bodyWeight: data,
                updateTime: DateTime.now(),
                giveCheckCoin: true)
            .toJson()
      }
    }, SetOptions(merge: true));
  }

  //신체정보 시력(좌) 업데이트
  static Future<void> setBodyLeftVision(
      double data, double rightVision, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // giveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_BODY][STRUCT_BODYVISION]
        [FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      if (!docSnapshot.data()![STRUCT_BODY][STRUCT_BODYVISION]
          [FIELD_GIVECHECKCOINVISION]) {
        UserController.to.userBodyInfoCount + 1;
      }
    }
    bool pointCheck = docSnapshot.data()![STRUCT_BODY][STRUCT_BODYVISION]
        [FIELD_GIVECHECKCOINVISION];
    await docRef.set({
      STRUCT_BODY: {
        STRUCT_BODYVISION: BodyVision(
                bodyLeftVision: data,
                bodyRightVision: rightVision,
                updateTime: DateTime.now(),
                giveCheckCoin: true,
                giveCheckCoinVision: pointCheck)
            .toJson()
      }
    }, SetOptions(merge: true));
  }

  // 신체정보 시력(우) 업데이트
  static Future<void> setBodyRightVision(
      double data, double leftVision, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // giveCheckCoinVision이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_BODY][STRUCT_BODYVISION]
        [FIELD_GIVECHECKCOINVISION]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      if (!docSnapshot.data()![STRUCT_BODY][STRUCT_BODYVISION]
          [FIELD_GIVECHECKCOIN]) {
        UserController.to.userBodyInfoCount + 1;
      }
    }
    bool pointCheck = docSnapshot.data()![STRUCT_BODY][STRUCT_BODYVISION]
        [FIELD_GIVECHECKCOIN];
    await docRef.set({
      STRUCT_BODY: {
        STRUCT_BODYVISION: BodyVision(
                bodyLeftVision: leftVision,
                bodyRightVision: data,
                updateTime: DateTime.now(),
                giveCheckCoin: pointCheck,
                giveCheckCoinVision: true)
            .toJson()
      }
    }, SetOptions(merge: true));
  }

  // 신체정보 혈액형 업데이트
  static Future<void> setbodyBloodType(String data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // giveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_BODY][STRUCT_BODYBLOODTYPE]
        [FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userBodyInfoCount + 1;
    }

    await docRef.set({
      STRUCT_BODY: {
        STRUCT_BODYBLOODTYPE: BodyBloodType(
                bodyBloodType: data,
                updateTime: DateTime.now(),
                giveCheckCoin: true)
            .toJson()
      }
    }, SetOptions(merge: true));
  }

  // 신체정보 발 사이즈
  static Future<void> setBodyFootSize(num data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // GiveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_BODY][STRUCT_BODYFOOTSIZE]
        [FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userBodyInfoCount + 1;
    }

    await docRef.set({
      STRUCT_BODY: {
        STRUCT_BODYFOOTSIZE: BodyFootSize(
                bodyFootSize: data,
                updateTime: DateTime.now(),
                giveCheckCoin: true)
            .toJson()
      }
    }, SetOptions(merge: true));
  }

  // 건강정보 담배
  static Future<void> setHealthTabacco(num data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // GiveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_HEALTH][STRUCT_HEALTHTABACCO]
        [FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userHealthInfoCount + 1;
    }

    await docRef.set({
      STRUCT_HEALTH: {
        STRUCT_HEALTHTABACCO: HealthTabacco(
                healthTabacco: data,
                updateTime: DateTime.now(),
                giveCheckCoin: true)
            .toJson()
      }
    }, SetOptions(merge: true));
  }

  // 건강정보 주량
  static Future<void> setHealthAlcohol(String data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // GiveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_HEALTH][STRUCT_HEALTHALCOHOL]
        [FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userHealthInfoCount + 1;
    }

    await docRef.set({
      STRUCT_HEALTH: {
        STRUCT_HEALTHALCOHOL: HealthAlcohol(
                healthAlcohol: data,
                updateTime: DateTime.now(),
                giveCheckCoin: true)
            .toJson()
      }
    }, SetOptions(merge: true));
  }

  // 건강정보 운동시간
  static Future<void> setHealthExercise(num data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // GiveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_HEALTH][STRUCT_HEALTHEXERCISE]
        [FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userHealthInfoCount + 1;
    }

    await docRef.set({
      STRUCT_HEALTH: {
        STRUCT_HEALTHEXERCISE: HealthExercise(
                healthExercise: data,
                updateTime: DateTime.now(),
                giveCheckCoin: true)
            .toJson()
      }
    }, SetOptions(merge: true));
  }

  // issues: #51 성격정보 입력, 검색 생성 - ellee

  static Future<void> setPersonalityMBTI(String data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // GiveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_PERSONALITY][STRUCT_PERSONALITYMBTI]
        [FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userPersonalityInfoCount + 1;
    }

    await docRef.set({
      STRUCT_PERSONALITY: {
        STRUCT_PERSONALITYMBTI: PersonalityMBTI(
                personalityMBTI: data,
                updateTime: DateTime.now(),
                giveCheckCoin: true)
            .toJson()
      }
    }, SetOptions(merge: true));
  }

  // issues: #54 별자리 성격정보 입력 - ellee
  static Future<void> setPersonalityStarSign(String data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    // GiveCheckCoin이 false일때 포인트 지급
    if (!docSnapshot.data()![STRUCT_PERSONALITY][STRUCT_PERSONALITYSTARSIGN]
        [FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userPersonalityInfoCount + 1;
    }

    await docRef.set({
      STRUCT_PERSONALITY: {
        STRUCT_PERSONALITYSTARSIGN: PersonalityStarSign(
                personalityStarSign: data,
                updateTime: DateTime.now(),
                giveCheckCoin: true)
            .toJson()
      }
    }, SetOptions(merge: true));
  }

  // issues: #55 경제정보 입력 - ellee
  static Future<void> setEconomicProperty(String data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함
    if (!docSnapshot.data()![STRUCT_ECONOMIC][STRUCT_ECONOMICPROPERTY]
        [FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userEconomicInfoCount + 1;
    }
    await docRef.set({
      STRUCT_ECONOMIC: {
        STRUCT_ECONOMICPROPERTY: EconomicProperty(
                economicProperty: data,
                updateTime: DateTime.now(),
                giveCheckCoin: true)
            .toJson()
      }
    }, SetOptions(merge: true));
  }

  // 차량정보만 입력할 경우에는 포인트 지급하지 않고 검색되지않음, 차량정보는 db저장됨
  static Future<void> setEconomicCarInfo(String data) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함

    await docRef.set({
      STRUCT_ECONOMIC: {
        STRUCT_ECONOMICCAR: EconomicCar(
                economicCar: data,
                economicCarFuel: docSnapshot.data()![STRUCT_ECONOMIC]
                    [STRUCT_ECONOMICCAR][FIELD_ECONOMICCARFUEL],
                updateTime: DateTime.now(),
                giveCheckCoin: docSnapshot.data()![STRUCT_ECONOMIC]
                    [STRUCT_ECONOMICCAR][FIELD_GIVECHECKCOIN])
            .toJson()
      }
    }, SetOptions(merge: true));
  }

  // 연료정보까지 입력해야 포인트 지급됨
  static Future<void> setEconomicCar(String data, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함
    String carInfo = docSnapshot.data()![STRUCT_ECONOMIC][STRUCT_ECONOMICCAR]
        [FIELD_ECONOMICCAR];
    if (!docSnapshot.data()![STRUCT_ECONOMIC][STRUCT_ECONOMICCAR]
        [FIELD_GIVECHECKCOIN]) {
      await UserController.to.addMyPoint(userKey, addPoint, 'info');
      Get.snackbar('YAB 지급', '$addPoint YAB 이 지급 되었습니다.');
      UserController.to.userEconomicInfoCount + 1;
    }
    await docRef.set({
      STRUCT_ECONOMIC: {
        STRUCT_ECONOMICCAR: EconomicCar(
                economicCar: carInfo,
                economicCarFuel: data,
                updateTime: DateTime.now(),
                giveCheckCoin: true)
            .toJson()
      }
    }, SetOptions(merge: true));
  }

  // 유저의 포인트 지급 하는 함수
  static Future<void> addMyPoint(String userKey, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함
    await docRef.update({FIELD_COIN: docSnapshot[FIELD_COIN] + addPoint});

    UserController.to.userModel.update((_user) {
      _user!.coin = docSnapshot[FIELD_COIN] + addPoint;
    });
  }

  // 유저의 포인트 QR로 지급 하는 함수
  static Future<void> addOtherUserPoint(String userKey, num addPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함
    await docRef.update({FIELD_COIN: docSnapshot[FIELD_COIN] + addPoint});
  }

  // 유저의 포인트 차감 하는 함수
  static Future<void> subPoint(String userKey, num subPoint) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함
    await docRef.update({FIELD_COIN: docSnapshot[FIELD_COIN] - subPoint});

    UserController.to.userModel.update((_user) {
      _user!.coin = docSnapshot[FIELD_COIN] - subPoint;
    });
  }

  // 유저의 포인트를 가져오는 함수
  static Future<num> getPoint() async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get(); // 유저모델을 가져오기 위함
    num point = docSnapshot[FIELD_COIN];

    return point;
  }

  //상점등록 유저 등록
  static Future<void> setPremiumUser(String userKey) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    await docRef.update({FIELD_PREMIUMUSER: true});
  }

  //상점등록 유저 해제
  static Future<void> delPremiumUser(String userKey) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    await docRef.update({FIELD_PREMIUMUSER: false});
  }

  // issues: #50 로그아웃 시 FCM 토큰 초기화 - ellee
  static Future<void> logoutDeleteFCMToken() async {
    await FirebaseFirestore.instance
        .collection(COL_USERS)
        .doc(userKey)
        .update({FIELD_FCMTOKEN: ''});
  }

  // 유저정보 삭제 함수 (회원탈퇴)
  static Future<void> deleteUser() async {
    CollectionReference colRefUsers =
        FirebaseFirestore.instance.collection(COL_USERS);
    await colRefUsers.doc(userKey).delete(); // 해당 유저의 Document를 삭제
    User user = FirebaseAuth.instance.currentUser!;
    await user.delete(); // 해당 유저의 Authentication을 삭제
  }
}
