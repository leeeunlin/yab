import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';
import 'package:yab_v2/src/model/detector_model.dart';
import 'package:yab_v2/src/utils/data_keys.dart';
import 'package:yab_v2/src/utils/logger.dart';

final String userKey =
    FirebaseAuth.instance.currentUser!.uid; // 로그인된 유저 키값을 가져 옴

class DetectorRepository {
  // detectorModel UserKey를 이용하여 detectorModel.generateDetectorKey을 이용하여 만듬
  // Board Collection의 새로운 게시물을 생성
  static Future createNewItem(
      DetectorModel detectorModel, String detectorKey, String userKey) async {
    // board Collection 안에 generateDetectorKey를 이용한 키값으로 Document를 만드는 과정 (전체 게시물)
    DocumentReference<Map<String, dynamic>> detectorDocReference =
        FirebaseFirestore.instance.collection(COL_BOARD).doc(detectorKey);
    await detectorDocReference.set(detectorModel.toMap());
  }

  // User키를 서버에서 필터를 하여 찾는 함수
  static Future<List<String>> detectorUser(
      String birth,
      String education,
      String gender,
      String nationality,
      String maritalstatus,
      String children) async {
    Query<Map<String, dynamic>> _collectionRef =
        FirebaseFirestore.instance.collection(COL_USERS);
    // QuerySnapshot querySnapshot;
    //issues: #44 생년월일에 따른 연령 필터생성 -ellee
    Query<Map<String, dynamic>> _collectionRefBirth;
    // issues: #46 학력정보 검색 필터 생성 - ellee
    Query<Map<String, dynamic>> _collectionRefEducation;
    Query<Map<String, dynamic>> _collectionRefGender;
    Query<Map<String, dynamic>> _collectionRefNationality;
    Query<Map<String, dynamic>> _collectionRefMaritalstatus;
    Query<Map<String, dynamic>> _collectionRefChildren;
    // issues: #44 생년월일에 따른 연령 필터생성 -ellee
    // firebase에서 글자 크기값을 비교할 수 있는 내용 확인 ㄱ보다 ㅎ가 크고 z보다 a가 작음
    if (birth != 'all') {
      if (birth == '10') {
        // 생년월일을 입력하지 않으면 'nono'값이 들어감 string값이 아닌 datetime을 넣을 경우 firebase에서 기본으로 오늘 날짜를 넣어버림
        // none값을 제외 하고 검색
        _collectionRefBirth = _collectionRef
            .where('$STRUCT_BIRTH.$FIELD_BIRTH',
                isGreaterThanOrEqualTo:
                    '${DateTime.now().year - int.parse(birth)}-01-01')
            .where('$STRUCT_BIRTH.$FIELD_BIRTH', isNotEqualTo: 'none');
      } else if (birth == '60') {
        // 60대 이상의 검색으로 오늘 년도에서 60을 뺀 값임 년도는 적을수록 나이가 많아져 lessthan을 사용
        _collectionRefBirth = _collectionRef.where('$STRUCT_BIRTH.$FIELD_BIRTH',
            isLessThanOrEqualTo:
                '${DateTime.now().year - int.parse(birth)}-12-31');
      } else {
        // 20대 ~ 50대는 나이가 정해져있고 년도에 맞춰 필터링 할 수 있도록 함, 해당 년도에서 9를 빼면 나이가나옴
        // ex) 20대 선택 시 20 ~ 29살 까지 / 2022년 기준 1993 ~ 2002년 까지
        _collectionRefBirth = _collectionRef
            .where('$STRUCT_BIRTH.$FIELD_BIRTH',
                isGreaterThanOrEqualTo:
                    '${DateTime.now().year - int.parse(birth) - 9}-01-01')
            .where('$STRUCT_BIRTH.$FIELD_BIRTH',
                isLessThanOrEqualTo:
                    '${DateTime.now().year - (int.parse(birth))}-12-31');
      }
    } else {
      _collectionRefBirth = _collectionRef;
    }
    // issues: #46 학력정보 값 검색 - ellee
    if (education != 'all') {
      _collectionRefEducation = _collectionRef
          .where('$STRUCT_EDUCATION.$FIELD_EDUCATION', isEqualTo: education);
    } else {
      _collectionRefEducation = _collectionRef;
    }
    if (gender != 'all') {
      _collectionRefGender = _collectionRef
          .where('$STRUCT_GENDER.$FIELD_GENDER', isEqualTo: gender);
    } else {
      _collectionRefGender = _collectionRef;
    }
    if (nationality != 'all') {
      _collectionRefNationality = _collectionRef.where(
          '$STRUCT_NATIONALITY.$FIELD_NATIONALITY',
          isEqualTo: nationality);
    } else {
      _collectionRefNationality = _collectionRef;
    }
    if (maritalstatus != 'all') {
      _collectionRefMaritalstatus = _collectionRef.where(
          '$STRUCT_MARITALSTATUS.$FIELD_MARITALSTATUS',
          isEqualTo: maritalstatus);
    } else {
      _collectionRefMaritalstatus = _collectionRef;
    }
    if (children != 'all') {
      _collectionRefChildren = _collectionRef
          .where('$STRUCT_CHILDREN.$FIELD_CHILDREN', isEqualTo: children);
    } else {
      _collectionRefChildren = _collectionRef;
    }

    QuerySnapshot birthSnapshot = await _collectionRefBirth.get();
    // issues: #46 학력정보 값 검색 - ellee
    QuerySnapshot educationSnapshot = await _collectionRefEducation.get();
    QuerySnapshot genderSnapshot = await _collectionRefGender.get();
    QuerySnapshot nationalitySnapshot = await _collectionRefNationality.get();
    QuerySnapshot maritalstatusSnapshot =
        await _collectionRefMaritalstatus.get();
    QuerySnapshot childrenSnapshot = await _collectionRefChildren.get();

    // 기본정보 필터
    final birthUser = birthSnapshot.docs.map((doc) => doc.id).toList();
    final educationUser = educationSnapshot.docs.map((doc) => doc.id).toList();
    final genderUser = genderSnapshot.docs.map((doc) => doc.id).toList();
    final nationalityUser =
        nationalitySnapshot.docs.map((doc) => doc.id).toList();
    final maritalstatusUser =
        maritalstatusSnapshot.docs.map((doc) => doc.id).toList();
    final childrenUser = childrenSnapshot.docs.map((doc) => doc.id).toList();

    List<String> allUsers = [];
    List<String> tmpUsers = [];
    // 기본정보 필터 시작
    for (int i = 0; i < birthUser.length; i++) {
      if (educationUser.contains(birthUser[i])) {
        allUsers.add(birthUser[i]);
      }
    }
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < tmpUsers.length; i++) {
      if (genderUser.contains(tmpUsers[i])) {
        allUsers.add(tmpUsers[i]);
      }
    }
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < tmpUsers.length; i++) {
      if (nationalityUser.contains(tmpUsers[i])) {
        allUsers.add(tmpUsers[i]);
      }
    }
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < tmpUsers.length; i++) {
      if (maritalstatusUser.contains(tmpUsers[i])) {
        allUsers.add(tmpUsers[i]);
      }
    }
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < tmpUsers.length; i++) {
      if (childrenUser.contains(tmpUsers[i])) {
        allUsers.add(tmpUsers[i]);
      }
    }

    return allUsers;
  }

  // 신체정보 필터 함수
  static Future<List<String>> detectorBodyUser(
      RangeValues bodyHeight,
      RangeValues bodyWeight,
      RangeValues bodyLeftVision,
      RangeValues bodyRightVision,
      String bodyBloodType,
      RangeValues bodyFootSize) async {
    Query<Map<String, dynamic>> _collectionRef =
        FirebaseFirestore.instance.collection(COL_USERS);
    Query<Map<String, dynamic>> _collectionRefBodyHeight;
    Query<Map<String, dynamic>> _collectionRefBodyWeight;
    Query<Map<String, dynamic>> _collectionRefBodyLeftVision;
    Query<Map<String, dynamic>> _collectionRefBodyRightVision;
    Query<Map<String, dynamic>> _collectionRefBodyBloodType;
    Query<Map<String, dynamic>> _collectionRefBodyFootSize;
    // issues: #41 신체정보 이상, 이하 UI선택 및 적용 - ellee
    if (UserInfoDetectorController.to.bodyHeightFilter.value == true) {
      _collectionRefBodyHeight = _collectionRef
          .where('$STRUCT_BODY.$STRUCT_BODYHEIGHT.$FIELD_BODYHEIGHT',
              isGreaterThanOrEqualTo: bodyHeight.start)
          .where('$STRUCT_BODY.$STRUCT_BODYHEIGHT.$FIELD_BODYHEIGHT',
              isLessThanOrEqualTo: bodyHeight.end);
    } else {
      _collectionRefBodyHeight = _collectionRef;
    }
    if (UserInfoDetectorController.to.bodyWeightFilter.value == true) {
      _collectionRefBodyWeight = _collectionRef
          .where('$STRUCT_BODY.$STRUCT_BODYWEIGHT.$FIELD_BODYWEIGHT',
              isGreaterThanOrEqualTo: bodyWeight.start)
          .where('$STRUCT_BODY.$STRUCT_BODYWEIGHT.$FIELD_BODYWEIGHT',
              isLessThanOrEqualTo: bodyWeight.end);
    } else {
      _collectionRefBodyWeight = _collectionRef;
    }
    if (UserInfoDetectorController.to.bodyVisionFilter.value == true) {
      _collectionRefBodyLeftVision = _collectionRef
          .where('$STRUCT_BODY.$STRUCT_BODYVISION.$FIELD_BODYLEFTVISION',
              isGreaterThanOrEqualTo: bodyLeftVision.start)
          .where('$STRUCT_BODY.$STRUCT_BODYVISION.$FIELD_BODYLEFTVISION',
              isLessThanOrEqualTo: bodyLeftVision.end);
      _collectionRefBodyRightVision = _collectionRef
          .where('$STRUCT_BODY.$STRUCT_BODYVISION.$FIELD_BODYRIGHTVISION',
              isGreaterThanOrEqualTo: bodyRightVision.start)
          .where('$STRUCT_BODY.$STRUCT_BODYVISION.$FIELD_BODYRIGHTVISION',
              isGreaterThanOrEqualTo: bodyRightVision.end);
    } else {
      _collectionRefBodyLeftVision = _collectionRef;
      _collectionRefBodyRightVision = _collectionRef;
    }
    if (bodyBloodType != 'all') {
      _collectionRefBodyBloodType = _collectionRef.where(
          '$STRUCT_BODY.$STRUCT_BODYBLOODTYPE.$FIELD_BODYBLOODTYPE',
          isEqualTo: bodyBloodType);
    } else {
      _collectionRefBodyBloodType = _collectionRef;
    }
    if (UserInfoDetectorController.to.bodyFootSizeFilter.value == true) {
      _collectionRefBodyFootSize = _collectionRef
          .where('$STRUCT_BODY.$STRUCT_BODYFOOTSIZE.$FIELD_BODYFOOTSIZE',
              isGreaterThanOrEqualTo: bodyFootSize.start)
          .where('$STRUCT_BODY.$STRUCT_BODYFOOTSIZE.$FIELD_BODYFOOTSIZE',
              isLessThanOrEqualTo: bodyFootSize.end);
    } else {
      _collectionRefBodyFootSize = _collectionRef;
    }

    QuerySnapshot bodyHeightSnapshot = await _collectionRefBodyHeight.get();
    QuerySnapshot bodyWeightSnapshot = await _collectionRefBodyWeight.get();
    QuerySnapshot bodyLeftVisionSnapshot =
        await _collectionRefBodyLeftVision.get();
    QuerySnapshot bodyRightVisionSnapshot =
        await _collectionRefBodyRightVision.get();
    QuerySnapshot bodyBloodTypeSnapshot =
        await _collectionRefBodyBloodType.get();
    QuerySnapshot bodyFootSizeSnapshot = await _collectionRefBodyFootSize.get();

    // 신체정보 필터
    final bodyHeightUser =
        bodyHeightSnapshot.docs.map((doc) => doc.id).toList();
    final bodyWeightUser =
        bodyWeightSnapshot.docs.map((doc) => doc.id).toList();
    final bodyLeftVisionUser =
        bodyLeftVisionSnapshot.docs.map((doc) => doc.id).toList();
    final bodyRightVisionUser =
        bodyRightVisionSnapshot.docs.map((doc) => doc.id).toList();
    final bodyBloodTypeUser =
        bodyBloodTypeSnapshot.docs.map((doc) => doc.id).toList();
    final bodyFootsizeUser =
        bodyFootSizeSnapshot.docs.map((doc) => doc.id).toList();

    List<String> allUsers = [];
    List<String> tmpUsers = [];
    // 신체정보 필터 시작
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < bodyHeightUser.length; i++) {
      if (bodyWeightUser.contains(bodyHeightUser[i])) {
        allUsers.add(bodyHeightUser[i]);
      }
    }
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < tmpUsers.length; i++) {
      if (bodyLeftVisionUser.contains(tmpUsers[i])) {
        allUsers.add(tmpUsers[i]);
      }
    }
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < tmpUsers.length; i++) {
      if (bodyRightVisionUser.contains(tmpUsers[i])) {
        allUsers.add(tmpUsers[i]);
      }
    }
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < tmpUsers.length; i++) {
      if (bodyBloodTypeUser.contains(tmpUsers[i])) {
        allUsers.add(tmpUsers[i]);
      }
    }
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < tmpUsers.length; i++) {
      if (bodyFootsizeUser.contains(tmpUsers[i])) {
        allUsers.add(tmpUsers[i]);
      }
    }
    return allUsers;
  }

  static Future<List<String>> detectorHealthUser(RangeValues healthTabacco,
      String healthAlcohol, RangeValues healthExercise) async {
    Query<Map<String, dynamic>> _collectionRef =
        FirebaseFirestore.instance.collection(COL_USERS);
    Query<Map<String, dynamic>> _collectionRefhealthTabacco;
    Query<Map<String, dynamic>> _collectionRefhealthAlcohol;
    Query<Map<String, dynamic>> _collectionRefhealthExercise;
    // issues: #41 신체정보 이상, 이하 UI선택 및 적용 - ellee
    if (UserInfoDetectorController.to.healthTabaccoFilter.value == true) {
      _collectionRefhealthTabacco = _collectionRef
          .where('$STRUCT_HEALTH.$STRUCT_HEALTHTABACCO.$FIELD_HEALTHTABACCO',
              isGreaterThanOrEqualTo: healthTabacco.start)
          .where('$STRUCT_HEALTH.$STRUCT_HEALTHTABACCO.$FIELD_HEALTHTABACCO',
              isLessThanOrEqualTo: healthTabacco.end);
    } else {
      _collectionRefhealthTabacco = _collectionRef;
    }
    if (healthAlcohol != 'all') {
      _collectionRefhealthAlcohol = _collectionRef.where(
          '$STRUCT_HEALTH.$STRUCT_HEALTHALCOHOL.$FIELD_HEALTHALCOHOL',
          isEqualTo: healthAlcohol);
    } else {
      _collectionRefhealthAlcohol = _collectionRef;
    }
    if (UserInfoDetectorController.to.healthExerciseFilter.value == true) {
      _collectionRefhealthExercise = _collectionRef
          .where('$STRUCT_HEALTH.$STRUCT_HEALTHEXERCISE.$FIELD_HEALTHEXERCISE',
              isGreaterThanOrEqualTo: healthExercise.start)
          .where('$STRUCT_HEALTH.$STRUCT_HEALTHEXERCISE.$FIELD_HEALTHEXERCISE',
              isLessThanOrEqualTo: healthExercise.end);
    } else {
      _collectionRefhealthExercise = _collectionRef;
    }

    QuerySnapshot healthTabaccoSnapshot =
        await _collectionRefhealthTabacco.get();

    QuerySnapshot healthAlcoholSnapshot =
        await _collectionRefhealthAlcohol.get();
    QuerySnapshot healthExerciseSnapshot =
        await _collectionRefhealthExercise.get();

    // 신체정보 필터
    final healthTabaccoUser =
        healthTabaccoSnapshot.docs.map((doc) => doc.id).toList();
    final healthAlcoholUser =
        healthAlcoholSnapshot.docs.map((doc) => doc.id).toList();
    final healthExerciseUser =
        healthExerciseSnapshot.docs.map((doc) => doc.id).toList();

    List<String> allUsers = [];
    List<String> tmpUsers = [];
    // 신체정보 필터 시작
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < healthTabaccoUser.length; i++) {
      if (healthAlcoholUser.contains(healthTabaccoUser[i])) {
        allUsers.add(healthTabaccoUser[i]);
      }
    }
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < tmpUsers.length; i++) {
      if (healthExerciseUser.contains(tmpUsers[i])) {
        allUsers.add(tmpUsers[i]);
      }
    }
    return allUsers;
  }

  // issues: #51 성격정보 입력, 검색 생성 - ellee
  static Future<List<String>> detectorPersonalityUser(
      List<dynamic> mbti, List<dynamic> starSign) async {
    Query<Map<String, dynamic>> _collectionRef =
        FirebaseFirestore.instance.collection(COL_USERS);
    Query<Map<String, dynamic>> _collectionRefPersonalityMBTI;
    Query<Map<String, dynamic>> _collectionRefPersonalityStarSign;
    List<String> mbtiUsers = [];
    List<String> starSingUsers = [];
    List<String> allUsers = [];

    if (UserInfoDetectorController.to.personalityMBTI.isNotEmpty) {
      // issues: #51 성격정보 검색 MBTI 선택이 10개가 넘을 경우
      if (mbti.length > 10) {
        Query<Map<String, dynamic>> _collectionRefPersonalityMBTI0;
        Query<Map<String, dynamic>> _collectionRefPersonalityMBTI1;

        List<dynamic> whereinlimit0 = [];
        List<dynamic> whereinlimit1 = [];

        // whereIn 의 리스트는 10개가 넘을경우 에러발생함
        for (int i = 0; i < 10; i++) {
          whereinlimit0.add(mbti[i]);
        }
        for (int j = 10; j < mbti.length; j++) {
          whereinlimit1.add(mbti[j]);
        }
        _collectionRefPersonalityMBTI0 = _collectionRef.where(
            '$STRUCT_PERSONALITY.$STRUCT_PERSONALITYMBTI.$FIELD_PERSONALITYMBTI',
            whereIn: whereinlimit0);
        _collectionRefPersonalityMBTI1 = _collectionRef.where(
            '$STRUCT_PERSONALITY.$STRUCT_PERSONALITYMBTI.$FIELD_PERSONALITYMBTI',
            whereIn: whereinlimit1);

        QuerySnapshot personalityMBTI0Snapshot =
            await _collectionRefPersonalityMBTI0.get();
        QuerySnapshot personalityMBTI1Snapshot =
            await _collectionRefPersonalityMBTI1.get();
        final personalityMBTI0User =
            personalityMBTI0Snapshot.docs.map((doc) => doc.id).toList();
        final personalityMBTI1User =
            personalityMBTI1Snapshot.docs.map((doc) => doc.id).toList();
        mbtiUsers = personalityMBTI0User; // MBTI 선택 중 10개를 먼저 검색
        mbtiUsers.addAll(personalityMBTI1User); // 추가된 갯수만큼 allusers에 추가
      } else {
        // 10개가 넘지 않을 경우 기존과 동일한 루틴
        _collectionRefPersonalityMBTI = _collectionRef.where(
            '$STRUCT_PERSONALITY.$STRUCT_PERSONALITYMBTI.$FIELD_PERSONALITYMBTI',
            whereIn: mbti);

        QuerySnapshot personalityMBTISnapshot =
            await _collectionRefPersonalityMBTI.get();
        // 성격정보 필터
        final personalityMBTIUser =
            personalityMBTISnapshot.docs.map((doc) => doc.id).toList();
        mbtiUsers = personalityMBTIUser;
      }
    } else {
      // 필터를 선택하지 않을 경우
      _collectionRefPersonalityMBTI = _collectionRef;
      QuerySnapshot personalityMBTISnapshot =
          await _collectionRefPersonalityMBTI.get();
      final personalityMBTIUser =
          personalityMBTISnapshot.docs.map((doc) => doc.id).toList();
      mbtiUsers = personalityMBTIUser;
    }
    // issues: #54 별자리 검색 쿼리 - ellee
    if (UserInfoDetectorController.to.personalityStarSign.isNotEmpty) {
      if (starSign.length > 10) {
        Query<Map<String, dynamic>> _collectionRefPersonalityStarSign0;
        Query<Map<String, dynamic>> _collectionRefPersonalityStarSign1;

        List<dynamic> whereinlimit0 = [];
        List<dynamic> whereinlimit1 = [];

        // whereIn 의 리스트는 10개가 넘을경우 에러발생함
        for (int i = 0; i < 10; i++) {
          whereinlimit0.add(starSign[i]);
        }
        for (int j = 10; j < starSign.length; j++) {
          whereinlimit1.add(starSign[j]);
        }
        _collectionRefPersonalityStarSign0 = _collectionRef.where(
            '$STRUCT_PERSONALITY.$STRUCT_PERSONALITYSTARSIGN.$FIELD_PERSONALITYSTARSIGN',
            whereIn: whereinlimit0);
        _collectionRefPersonalityStarSign1 = _collectionRef.where(
            '$STRUCT_PERSONALITY.$STRUCT_PERSONALITYSTARSIGN.$FIELD_PERSONALITYSTARSIGN',
            whereIn: whereinlimit1);

        QuerySnapshot personalityStarSign0Snapshot =
            await _collectionRefPersonalityStarSign0.get();
        QuerySnapshot personalityStarSign1Snapshot =
            await _collectionRefPersonalityStarSign1.get();
        final personalityStarSign0User =
            personalityStarSign0Snapshot.docs.map((doc) => doc.id).toList();
        final personalityStarSign1User =
            personalityStarSign1Snapshot.docs.map((doc) => doc.id).toList();
        starSingUsers = personalityStarSign0User; // MBTI 선택 중 10개를 먼저 검색
        starSingUsers.addAll(personalityStarSign1User); // 추가된 갯수만큼 allusers에 추가
      } else {
        // 10개가 넘지 않을 경우 기존과 동일한 루틴
        _collectionRefPersonalityStarSign = _collectionRef.where(
            '$STRUCT_PERSONALITY.$STRUCT_PERSONALITYSTARSIGN.$FIELD_PERSONALITYSTARSIGN',
            whereIn: starSign);

        QuerySnapshot personalityStarSignSnapshot =
            await _collectionRefPersonalityStarSign.get();
        // 성격정보 필터
        final personalityStarSignUser =
            personalityStarSignSnapshot.docs.map((doc) => doc.id).toList();
        starSingUsers = personalityStarSignUser;
      }
    } else {
      // 별자리 필터를 선택하지 않을 경우
      _collectionRefPersonalityStarSign = _collectionRef;
      QuerySnapshot personalityStarSignSnapshot =
          await _collectionRefPersonalityStarSign.get();
      final personalityStarSignUser =
          personalityStarSignSnapshot.docs.map((doc) => doc.id).toList();
      starSingUsers = personalityStarSignUser;
    }

    for (int i = 0; i < mbtiUsers.length; i++) {
      if (starSingUsers.contains(mbtiUsers[i])) {
        allUsers.add(mbtiUsers[i]);
      }
    }
    return allUsers;
  }

  // issues: #55 경제정보 쿼리 - ellee
  static Future<List<String>> detectorEconomicUser(
      List<dynamic> economicProperty,
      List<dynamic> economicCar,
      List<dynamic> economicCarFuel) async {
    Query<Map<String, dynamic>> _collectionRef =
        FirebaseFirestore.instance.collection(COL_USERS);
    Query<Map<String, dynamic>> _collectionRefEconomicProperty;
    Query<Map<String, dynamic>> _collectionRefEconomicCar;
    Query<Map<String, dynamic>> _collectionRefEconomicCarFuel;
    List<String> propertyUsers = [];
    List<String> carUsers = [];
    List<String> carFuelUsers = [];
    List<String> allUsers = [];
    // 부동산 정보
    if (UserInfoDetectorController.to.economicProperty.isNotEmpty) {
      _collectionRefEconomicProperty = _collectionRef.where(
          '$STRUCT_ECONOMIC.$STRUCT_ECONOMICPROPERTY.$FIELD_ECONOMICPROPERTY',
          whereIn: economicProperty);

      QuerySnapshot economicPropertySnapshot =
          await _collectionRefEconomicProperty.get();
      final economicPropertyUsers =
          economicPropertySnapshot.docs.map((doc) => doc.id).toList();
      propertyUsers = economicPropertyUsers;
    } else {
      _collectionRefEconomicProperty = _collectionRef;
      QuerySnapshot economicPropertySnapshot =
          await _collectionRefEconomicProperty.get();
      final economicPropertyUser =
          economicPropertySnapshot.docs.map((doc) => doc.id).toList();
      propertyUsers = economicPropertyUser;
    }
    // 차량 정보
    if (UserInfoDetectorController.to.economicCar.isNotEmpty) {
      _collectionRefEconomicCar = _collectionRef.where(
          '$STRUCT_ECONOMIC.$STRUCT_ECONOMICCAR.$FIELD_ECONOMICCAR',
          whereIn: economicCar);

      QuerySnapshot economicCarSnapshot = await _collectionRefEconomicCar.get();
      // 성격정보 필터
      final economicCarUsers =
          economicCarSnapshot.docs.map((doc) => doc.id).toList();
      carUsers = economicCarUsers;
    } else {
      _collectionRefEconomicCar = _collectionRef;
      QuerySnapshot economicCarSnapshot = await _collectionRefEconomicCar.get();
      final economicCarUser =
          economicCarSnapshot.docs.map((doc) => doc.id).toList();
      carUsers = economicCarUser;
    }
    // 차량 연료 정보
    if (UserInfoDetectorController.to.economicCarFuel.isNotEmpty) {
      _collectionRefEconomicCarFuel = _collectionRef.where(
          '$STRUCT_ECONOMIC.$STRUCT_ECONOMICCAR.$FIELD_ECONOMICCARFUEL',
          whereIn: economicCarFuel);

      QuerySnapshot economicCarFuelSnapshot =
          await _collectionRefEconomicCarFuel.get();
      // 성격정보 필터
      final economicCarFuelUsers =
          economicCarFuelSnapshot.docs.map((doc) => doc.id).toList();
      carFuelUsers = economicCarFuelUsers;
    } else {
      _collectionRefEconomicCarFuel = _collectionRef;
      QuerySnapshot economicCarFuelSnapshot =
          await _collectionRefEconomicCarFuel.get();
      final economicCarFuelUser =
          economicCarFuelSnapshot.docs.map((doc) => doc.id).toList();
      carFuelUsers = economicCarFuelUser;
    }

    List<String> tmpUsers = [];
    for (int i = 0; i < propertyUsers.length; i++) {
      if (carUsers.contains(propertyUsers[i])) {
        allUsers.add(propertyUsers[i]);
      }
    }
    tmpUsers = allUsers;
    allUsers = [];
    for (int i = 0; i < tmpUsers.length; i++) {
      if (carFuelUsers.contains(tmpUsers[i])) {
        allUsers.add(tmpUsers[i]);
      }
    }
    return allUsers;
  }

  // FCM토큰을 서버에서 필터를 하여 찾는 함수
  static Future<List<String>> detectorToken(
      List<String> userSelectFCMKey) async {
    List<String> detectorTokenList = [];
    for (int i = 0; i < userSelectFCMKey.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> userKeytoFCMkey =
          await FirebaseFirestore.instance
              .collection(COL_USERS)
              .doc(userSelectFCMKey[i])
              .get();

      detectorTokenList.add(userKeytoFCMkey.data()![FIELD_FCMTOKEN]);
    }

    return detectorTokenList;
  }

  static Future<List<String>> uploadImages(
      List<dynamic> images, String detectorKey) async {
    var metaData = SettableMetadata(contentType: 'image/jpeg'); // 전송할 컨텐트 타입 설정

    List<String> downloadUrls = [];

    for (int i = 0; i < images.length; i++) {
      Reference ref = FirebaseStorage.instance
          .ref('images/$detectorKey/$i.jpg'); //파이어베이스에 저장할명 설정

      if (images.isNotEmpty) {
        await ref.putData(images[i], metaData).catchError((onError) {
          logger.e(onError.toString());
        });
        downloadUrls.add(await ref.getDownloadURL()); // 다운로드 URL 가져오기;
      }
    }
    return downloadUrls;
  }
}
