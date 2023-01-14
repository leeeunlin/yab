// 기본정보에 성별 정보 구조체 정보.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class Gender {
  String? gender; // 성별
  DateTime? updateTime; // 업데이트 시간
  bool? giveCheckCoin; // 최초 정보 입력시 코인 지급 유/무 확인
  Gender({this.gender, this.updateTime, this.giveCheckCoin});

  factory Gender.init() {
    var time = DateTime.now();
    return Gender(gender: DATA_NONE, updateTime: time, giveCheckCoin: false);
  }

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        gender: json[FIELD_GENDER] == null ? '' : json[FIELD_GENDER] as String,
        updateTime: json[FIELD_UPDATETIME] == null
            ? DateTime.now()
            : (json[FIELD_UPDATETIME] as Timestamp).toDate(),
        giveCheckCoin: json[FIELD_GIVECHECKCOIN] == null
            ? false
            : json[FIELD_GIVECHECKCOIN] as bool,
      );

  Map<String, dynamic> toJson() {
    return {
      FIELD_GENDER: gender,
      FIELD_UPDATETIME: updateTime,
      FIELD_GIVECHECKCOIN: giveCheckCoin
    };
  }
}

const Map<String, String> genderMapEngToKor = {
  'none': '성별을 선택해주세요',
  'male': '남성',
  'woman': '여성'
};

const Map<String, String> genderMapKorToEng = {
  '성별을 선택해주세요': 'none',
  '남성': 'male',
  '여성': 'woman'
};
