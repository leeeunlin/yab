import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class Education {
  // issues: #46 학력정보 유저 모델 생성.
  String? education; // 학력정보
  DateTime? updateTime; // 업데이트 시간
  bool? giveCheckCoin; // 최초 정보 입력시 코인 지급 유/무 확인

  Education({this.education, this.updateTime, this.giveCheckCoin});

  factory Education.init() {
    DateTime time = DateTime.now();
    return Education(
        education: DATA_NONE, updateTime: time, giveCheckCoin: false);
  }

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        education: json[FIELD_EDUCATION] == null
            ? ''
            : json[FIELD_EDUCATION] as String,
        updateTime: json[FIELD_UPDATETIME] == null
            ? DateTime.now()
            : (json[FIELD_UPDATETIME] as Timestamp).toDate(),
        giveCheckCoin: json[FIELD_GIVECHECKCOIN] == null
            ? false
            : json[FIELD_GIVECHECKCOIN] as bool,
      );

  Map<String, dynamic> toJson() {
    DateTime time = DateTime.now();
    return {
      FIELD_EDUCATION: education ?? DATA_NONE,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false
    };
  }
}
