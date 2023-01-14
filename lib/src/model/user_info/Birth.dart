import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class Birth {
  // 기본정보에 생일 정보 구조체 정보.
  String? birth; // 생일
  DateTime? updateTime; // 업데이트 시간
  bool? giveCheckCoin; // 최초 정보 입력시 코인 지급 유/무 확인

  Birth({this.birth, this.updateTime, this.giveCheckCoin});

  factory Birth.init() {
    DateTime time = DateTime.now();
    return Birth(birth: DATA_NONE, updateTime: time, giveCheckCoin: false);
  }

  factory Birth.fromJson(Map<String, dynamic> json) => Birth(
        birth: json[FIELD_BIRTH] == null ? '' : json[FIELD_BIRTH] as String,
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
      FIELD_BIRTH: birth ?? DATA_NONE,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false
    };
  }
}
