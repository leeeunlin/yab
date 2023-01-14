// 기본정보에 결혼 유/무 구조체 정보
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class MaritalStatus {
  String? maritalstatus; // 결혼 유/무
  DateTime? updateTime; // 업데이트 시간
  bool? giveCheckCoin; // 최초 정보 입력시 코인 지급 유/무 확인

  MaritalStatus({this.maritalstatus, this.updateTime, this.giveCheckCoin});

  factory MaritalStatus.init() {
    var time = DateTime.now();
    return MaritalStatus(
        maritalstatus: DATA_NONE, updateTime: time, giveCheckCoin: false);
  }

  factory MaritalStatus.fromJson(Map<String, dynamic> json) => MaritalStatus(
        maritalstatus: json[FIELD_MARITALSTATUS] == null
            ? ''
            : json[FIELD_MARITALSTATUS] as String,
        updateTime: json[FIELD_UPDATETIME] == null
            ? DateTime.now()
            : (json[FIELD_UPDATETIME] as Timestamp).toDate(),
        giveCheckCoin: json[FIELD_GIVECHECKCOIN] == null
            ? false
            : json[FIELD_GIVECHECKCOIN] as bool,
      );

  Map<String, dynamic> toJson() {
    return {
      FIELD_MARITALSTATUS: maritalstatus,
      FIELD_UPDATETIME: updateTime,
      FIELD_GIVECHECKCOIN: giveCheckCoin
    };
  }
}

const Map<String, String> maritalstatusMapEngToKor = {
  'none': '혼인여부를 선택해주세요',
  'married': '기혼',
  'single': '미혼'
};

const Map<String, String> maritalstatusMapKorToEng = {
  '혼인여부를 선택해주세요': 'none',
  '기혼': 'married',
  '미혼': 'single'
};
