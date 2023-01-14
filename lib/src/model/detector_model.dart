import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/model/detector_info/select_user_model.dart';
import 'package:yab_v2/src/model/detector_info/select_user_token_model.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class DetectorModel {
  String? detectorKey; // 디텍터 키값
  String? userKey; // 유저 키값
  String? mode; // 글 모드
  String? birth;
  String? gender; // 찾는 성별 값
  String? nationality; // 찾는 국적 값
  String? maritalstatus; // 찾는 결혼 유무 값
  String? children; // 찾는 아이 유무 값
  // issues: #46 학력정보 데이터
  String? education;
  // issues: #41 신체정보 이상, 이하 UI선택 및 적용 - ellee
  num? heightStart;
  num? heightEnd;
  num? weightStart;
  num? weightEnd;
  num? leftVisionStart;
  num? leftVisionEnd;
  num? rightVisionStart;
  num? rightVisionEnd;
  String? bloodType;
  num? footSizeStart;
  num? footSizeEnd;
  num? healthTabaccoStart;
  num? healthTabaccoEnd;
  String? healthAlcohol;
  num? healthExerciseStart;
  num? healthExerciseEnd;
  // issues: #51 성격정보 board 리스트 저장
  List<String>? personalityMBTI;
  // issues: #54 성격정보 별자리 리스트 저장
  List<String>? personalityStarSign;
  // issues: #55 경제정보 리스트 저장
  List<String>? economicProperty;
  List<String>? economicCar;
  List<String>? economicCarFuel;
  List<String>? users; // 찾은 유저 목록
  String? title; // 글 제목
  List<String>? detail; // 글 내용
  num? price; // 가격
  num? fullPrice; // 차감 될 전체 금액
  num? firstPrice; // 1차 지급금액 (정보 사용료)
  // issues: #47 오탈자 수정 - ellee
  num? secondPrice; // 2차 지급금액 (2차 제공료)
  num? fcmViewPrice; // FCM 메시지에 보여줄 금액
  num? refundPrice; // 환불 금액
  num? counter; // 인원수
  String? expiredDay; // 만료일수
  List<String>? imageDownloadUrls; // 일반 글 일때 올리는 사진 URL값
  DateTime? createdDate; // 생성 시간 값
  DateTime? expiredDate; // 만료 시간 값
  DateTime? reservationDate; // 예약 시간 값
  String? reservationId; // Cloud task API의 taskID값
  bool? refundCheck; // 환불 확인 플래그
  SelectUserModel? selectUserModel; // VS & Muliti 유저 키값을 저장
  List<String>? fcmTokens; // 필터에 적용된 fcmtoken을 저장하는 값
  SelectUserTokenModel? selectUserTokenModel; // 토큰 키값을 저장
  bool? postView;
  DocumentReference? reference;

  DetectorModel({
    this.detectorKey,
    this.userKey,
    this.mode,
    this.birth,
    // issues: #46 학력정보 검색 - ellee
    this.education,
    this.gender,
    this.nationality,
    this.maritalstatus,
    this.children,
    this.heightStart,
    this.heightEnd,
    this.weightStart,
    this.weightEnd,
    this.leftVisionStart,
    this.leftVisionEnd,
    this.rightVisionStart,
    this.rightVisionEnd,
    this.bloodType,
    this.footSizeStart,
    this.footSizeEnd,
    this.healthTabaccoStart,
    this.healthTabaccoEnd,
    this.healthAlcohol,
    this.healthExerciseStart,
    this.healthExerciseEnd,
    // issues: #51 성격정보 검색 - ellee
    this.personalityMBTI,
    // issues: #54 별자리 성격정보 검색 - ellee
    this.personalityStarSign,
    // issues: #55 경제정보 검색 - ellee
    this.economicProperty,
    this.economicCar,
    this.economicCarFuel,
    this.users,
    this.title,
    this.detail,
    this.price,
    this.fullPrice,
    this.firstPrice,
    this.secondPrice,
    this.fcmViewPrice,
    this.refundPrice,
    this.counter,
    this.expiredDay,
    this.imageDownloadUrls,
    this.createdDate,
    this.expiredDate,
    this.reservationDate,
    this.reservationId,
    this.selectUserModel,
    this.fcmTokens,
    this.selectUserTokenModel,
    this.postView,
    this.reference,
  });

  factory DetectorModel.fromJson(Map<String, dynamic> json) {
    return DetectorModel(
      detectorKey: json[FIELD_DETECTORKEY] == null
          ? ''
          : json[FIELD_DETECTORKEY] as String,
      userKey: json[FIELD_USERKEY] == null ? '' : json[FIELD_USERKEY] as String,
      mode: json[FIELD_MODE] == null ? '' : json[FIELD_MODE] as String,
      birth: json[FIELD_BIRTH] == null ? '' : json[FIELD_BIRTH] as String,
      // issues: #46 학력정보 검색값 넣기 - ellee
      education:
          json[FIELD_EDUCATION] == null ? '' : json[FIELD_EDUCATION] as String,
      gender: json[FIELD_GENDER] == null ? '' : json[FIELD_GENDER] as String,
      nationality: json[FIELD_NATIONALITY] == null
          ? ''
          : json[FIELD_NATIONALITY] as String,
      maritalstatus: json[FIELD_MARITALSTATUS] == null
          ? ''
          : json[FIELD_MARITALSTATUS] as String,
      children:
          json[FIELD_CHILDREN] == null ? '' : json[FIELD_CHILDREN] as String,
      heightStart: json[FIELD_BODYHEIGHTSTART] == null
          ? null
          : json[FIELD_BODYHEIGHTSTART] as num,
      heightEnd: json[FIELD_BODYHEIGHTEND] == null
          ? null
          : json[FIELD_BODYHEIGHTEND] as num,
      weightStart: json[FIELD_BODYWEIGHTSTART] == null
          ? null
          : json[FIELD_BODYWEIGHTSTART] as num,
      weightEnd: json[FIELD_BODYWEIGHTEND] == null
          ? null
          : json[FIELD_BODYWEIGHTEND] as num,
      leftVisionStart: json[FIELD_BODYLEFTVISIONSTART] == null
          ? null
          : json[FIELD_BODYLEFTVISIONSTART] as num,
      leftVisionEnd: json[FIELD_BODYLEFTVISIONEND] == null
          ? null
          : json[FIELD_BODYLEFTVISIONEND] as num,
      rightVisionStart: json[FIELD_BODYRIGHTVISIONSTART] == null
          ? null
          : json[FIELD_BODYRIGHTVISIONSTART] as num,
      rightVisionEnd: json[FIELD_BODYRIGHTVISIONEND] == null
          ? null
          : json[FIELD_BODYRIGHTVISIONEND] as num,
      bloodType: json[FIELD_BODYBLOODTYPE] == null
          ? ''
          : json[FIELD_BODYBLOODTYPE] as String,
      footSizeStart: json[FIELD_BODYFOOTSIZESTART] == null
          ? null
          : json[FIELD_BODYFOOTSIZESTART] as num,
      footSizeEnd: json[FIELD_BODYFOOTSIZEEND] == null
          ? null
          : json[FIELD_BODYFOOTSIZEEND] as num,
      healthTabaccoStart: json[FIELD_HEALTHTABACCOSTART] == null
          ? null
          : json[FIELD_HEALTHTABACCOSTART] as num,
      healthTabaccoEnd: json[FIELD_HEALTHTABACCOEND] == null
          ? null
          : json[FIELD_HEALTHTABACCOEND] as num,
      healthAlcohol: json[FIELD_HEALTHALCOHOL] == null
          ? null
          : json[FIELD_HEALTHALCOHOL] as String,
      healthExerciseStart: json[FIELD_HEALTHEXERCISESTART] == null
          ? null
          : json[FIELD_HEALTHEXERCISESTART] as num,
      healthExerciseEnd: json[FIELD_HEALTHEXERCISEEND] == null
          ? null
          : json[FIELD_HEALTHEXERCISEEND] as num,
      personalityMBTI: json[FIELD_PERSONALITYMBTI] != null
          ? json[FIELD_PERSONALITYMBTI].cast<String>()
          : [],
      personalityStarSign: json[FIELD_PERSONALITYSTARSIGN] != null
          ? json[FIELD_PERSONALITYSTARSIGN].cast<String>()
          : [],
      // issues : #55 경제정보 검색 - ellee
      economicProperty: json[FIELD_ECONOMICPROPERTY] != null
          ? json[FIELD_ECONOMICPROPERTY].cast<String>()
          : [],
      economicCar: json[FIELD_ECONOMICCAR] != null
          ? json[FIELD_ECONOMICCAR].cast<String>()
          : [],
      economicCarFuel: json[FIELD_ECONOMICCARFUEL] != null
          ? json[FIELD_ECONOMICCARFUEL].cast<String>()
          : [],
      users: json[FIELD_USERLIST] != null
          ? json[FIELD_USERLIST].cast<String>()
          : [],
      title: json[FIELD_TITLE] == null ? '' : json[FIELD_TITLE] as String,
      detail:
          json[FIELD_DETAIL] != null ? json[FIELD_DETAIL].cast<String>() : [],
      // issues: #47 전부 동일한 DB보고 있던 문제 수정 - ellee
      price: json[FIELD_PRICE] == null ? 0 : json[FIELD_PRICE] as num,
      fullPrice: json[FIELD_PRICE] == null ? 0 : json[FIELD_PRICE] as num,
      firstPrice:
          json[FIELD_FIRSTPRICE] == null ? 0 : json[FIELD_FIRSTPRICE] as num,
      secondPrice: json[FIELD_SECOUNDPRICE] == null
          ? 0
          : json[FIELD_SECOUNDPRICE] as num,
      fcmViewPrice: json[FIELD_FCMVIEWPRICE] == null
          ? 0
          : json[FIELD_FCMVIEWPRICE] as num,
      refundPrice:
          json[FIELD_REFUNDPRICE] == null ? 0 : json[FIELD_REFUNDPRICE] as num,
      counter: json[FIELD_COUNTER] == null ? 0 : json[FIELD_COUNTER] as num,
      expiredDay: json[FIELD_EXPIREDDAY] == null
          ? ''
          : json[FIELD_EXPIREDDAY] as String,
      imageDownloadUrls: json[FIELD_IMAGEDOWNLOADURLS] != null
          ? json[FIELD_IMAGEDOWNLOADURLS].cast<String>()
          : [],
      createdDate: json[FIELD_CREATEDDATE] == null
          ? DateTime.now()
          : (json[FIELD_CREATEDDATE] as Timestamp).toDate(),
      expiredDate: json[FIELD_EXPIREDDATE] == null
          ? DateTime.now()
          : (json[FIELD_EXPIREDDATE] as Timestamp).toDate(),
      reservationDate: json[FIELD_RESERVATIONDATE] == null
          ? null
          : (json[FIELD_RESERVATIONDATE] as Timestamp).toDate(),
      reservationId: json[FIELD_RESERVATIONID] == null
          ? ''
          : json[FIELD_RESERVATIONID] as String,
      selectUserModel: json[STRUCT_SELECTUSERLIST] == null
          ? null
          : SelectUserModel.fromJson(json[STRUCT_SELECTUSERLIST]),
      fcmTokens: json[FIELD_FCMTOKENLIST] != null
          ? json[FIELD_FCMTOKENLIST].cast<String>()
          : [],
      selectUserTokenModel: json[STRUCT_SELECTUSERTOKENLIST] == null
          ? null
          : SelectUserTokenModel.fromJson(json[STRUCT_SELECTUSERTOKENLIST]),
      postView:
          json[FIELD_POSTVIEW] == null ? null : json[FIELD_POSTVIEW] as bool,
      reference: json['reference'],
    );
  }

  factory DetectorModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return DetectorModel.fromJson(snapshot.data()!);
  }

  Map<String, dynamic> toMap() {
    return {
      FIELD_DETECTORKEY: detectorKey,
      FIELD_USERKEY: userKey,
      FIELD_MODE: mode,
      FIELD_BIRTH: birth,
      // issues: #46 학력정보 검색값 넣기 - ellee
      FIELD_EDUCATION: education,
      FIELD_GENDER: gender,
      FIELD_NATIONALITY: nationality,
      FIELD_MARITALSTATUS: maritalstatus,
      FIELD_CHILDREN: children,
      FIELD_USERLIST: users,
      // issues: #41 신체정보 모델(이상 이하) - ellee
      FIELD_BODYHEIGHTSTART: heightStart,
      FIELD_BODYHEIGHTEND: heightEnd,
      FIELD_BODYWEIGHTSTART: weightStart,
      FIELD_BODYWEIGHTEND: weightEnd,
      FIELD_BODYLEFTVISIONSTART: leftVisionStart,
      FIELD_BODYLEFTVISIONEND: leftVisionEnd,
      FIELD_BODYRIGHTVISIONSTART: rightVisionStart,
      FIELD_BODYRIGHTVISIONEND: rightVisionEnd,
      FIELD_BODYBLOODTYPE: bloodType,
      FIELD_BODYFOOTSIZESTART: footSizeStart,
      FIELD_BODYFOOTSIZEEND: footSizeEnd,
      // issues: #45 건강정보 검색 - ellee
      FIELD_HEALTHTABACCOSTART: healthTabaccoStart,
      FIELD_HEALTHTABACCOEND: healthTabaccoEnd,
      FIELD_HEALTHALCOHOL: healthAlcohol,
      FIELD_HEALTHEXERCISESTART: healthExerciseStart,
      FIELD_HEALTHEXERCISEEND: healthExerciseEnd,
      // issues : #54 별자리 성격정보 검색 - ellee
      FIELD_PERSONALITYSTARSIGN: personalityStarSign,
      FIELD_PERSONALITYMBTI: personalityMBTI,
      // issues: #55 경제정보 검색 - ellee
      FIELD_ECONOMICPROPERTY: economicProperty,
      FIELD_ECONOMICCAR: economicCar,
      FIELD_ECONOMICCARFUEL: economicCarFuel,
      FIELD_TITLE: title,
      FIELD_DETAIL: detail,
      FIELD_PRICE: price,
      FIELD_FULLPRICE: fullPrice,
      FIELD_FIRSTPRICE: firstPrice,
      FIELD_SECOUNDPRICE: secondPrice,
      FIELD_FCMVIEWPRICE: fcmViewPrice,
      FIELD_REFUNDPRICE: refundPrice,
      FIELD_COUNTER: counter,
      FIELD_EXPIREDDAY: expiredDay,
      FIELD_IMAGEDOWNLOADURLS: imageDownloadUrls,
      FIELD_CREATEDDATE: createdDate,
      FIELD_EXPIREDDATE: expiredDate,
      FIELD_RESERVATIONDATE: reservationDate,
      FIELD_RESERVATIONID: reservationId,
      FIELD_FCMTOKENLIST: fcmTokens,
      STRUCT_SELECTUSERLIST: selectUserModel!.toJson(),
      STRUCT_SELECTUSERTOKENLIST: selectUserTokenModel!.toJson(),
    };
  }

  // 내게 온 게시물 맵형식으로 만들기
  //user Collection -> [USERKEY] -> board_receive_list SUB_Collection -> [SEARCHKEY] -> [DATAFIELD]
  // => 제목, 사진, 생성시간, 가격, 모드, 봤는지 안봤는지 플래그
  Map<String, dynamic> toReceiveBoardMap() {
    return {
      FIELD_TITLE: title,
      FIELD_IMAGEDOWNLOADURLS: imageDownloadUrls,
      FIELD_CREATEDDATE: createdDate,
      FIELD_PRICE: price,
      FIELD_MODE: mode,
      // issue: #35 내게 온 게시글 퍼포먼스 향상 - ellee
      // 게시글 보낼때 만료날짜 만료일수 추가
      FIELD_EXPIREDDATE: expiredDate,
      FIELD_EXPIREDDAY: expiredDay,
      FIELD_DETECTORKEY: detectorKey,
      FIELD_COUNTER: counter,
      STRUCT_SELECTUSERLIST: selectUserModel!.toJson(),
      FIELD_DETAIL: detail,
      FIELD_POSTVIEW: false
    };
  }

  // 코인 목록 맵형식으로 만들기
  Map<String, dynamic> toCoinBoardMap() {
    return {
      FIELD_MODE: mode,
      FIELD_PRICE: price,
      FIELD_CREATEDDATE: createdDate,
    };
  }

  // 내가 보낸 게시물 맵형식으로 만들기
  Map<String, dynamic> toSendBoardMap() {
    return {
      FIELD_TITLE: title,
      FIELD_IMAGEDOWNLOADURLS: imageDownloadUrls,
      FIELD_CREATEDDATE: createdDate,
      FIELD_PRICE: price,
      FIELD_MODE: mode,
      FIELD_EXPIREDDATE: expiredDate,
      FIELD_EXPIREDDAY: expiredDay,
      FIELD_REFUND: false,
    };
  }

  static String generateDetectorKey(String uid) {
    String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    return '${uid}_$timeInMilli';
  }
}
