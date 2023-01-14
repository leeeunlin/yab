// 기본정보에 국적 정보 구조체 정보.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class Nationality {
  String? nationality; // 국적
  DateTime? updateTime; // 업데이트 시간
  bool? giveCheckCoin; // 최초 정보 입력시 코인 지급 유/무 확인

  Nationality({this.nationality, this.updateTime, this.giveCheckCoin});

  factory Nationality.init() {
    var time = DateTime.now();
    return Nationality(
        nationality: DATA_NONE, updateTime: time, giveCheckCoin: false);
  }

  factory Nationality.fromJson(Map<String, dynamic> json) => Nationality(
        nationality: json[FIELD_NATIONALITY] == null
            ? ''
            : json[FIELD_NATIONALITY] as String,
        updateTime: json[FIELD_UPDATETIME] == null
            ? DateTime.now()
            : (json[FIELD_UPDATETIME] as Timestamp).toDate(),
        giveCheckCoin: json[FIELD_GIVECHECKCOIN] == null
            ? false
            : json[FIELD_GIVECHECKCOIN] as bool,
      );

  Map<String, dynamic> toJson() {
    return {
      FIELD_NATIONALITY: nationality,
      FIELD_UPDATETIME: updateTime,
      FIELD_GIVECHECKCOIN: giveCheckCoin
    };
  }
}

const Map<String, String> nationalityMapEngToKor = {
  'none': '국적을 선택해주세요',
  'local': '내국인',
  'foreigner': '외국인'
};

const Map<String, String> nationalityMapKorToEng = {
  '국적을 선택해주세요': 'none',
  '내국인': 'local',
  '외국인': 'foreigner'
};
