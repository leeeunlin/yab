import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class Personality {
  // 기본정보에 성별 정보 구조체 정보.
  PersonalityMBTI? personalityMBTI;
  // issues: #54 별자리 성격정보 입력 추가 - ellee
  PersonalityStarSign? personalityStarSign;
  DateTime? updateTime; // 업데이트 시간
  bool? giveCheckCoin; // 최초 정보 입력시 코인 지급 유/무 확인

  Personality(
      {this.personalityMBTI, this.personalityStarSign, this.updateTime});

  factory Personality.init() {
    DateTime time = DateTime.now();
    return Personality(
      updateTime: time,
    );
  }

  factory Personality.fromJson(Map<String, dynamic> json) => Personality(
        personalityMBTI: json[STRUCT_PERSONALITYMBTI] == null
            ? null
            : PersonalityMBTI.fromJson(json[STRUCT_PERSONALITYMBTI]),
        // issues: #54 별자리 성격정보 입력 추가
        personalityStarSign: json[STRUCT_PERSONALITYSTARSIGN] == null
            ? null
            : PersonalityStarSign.fromJson(json[STRUCT_PERSONALITYSTARSIGN]),
        updateTime: json[FIELD_UPDATETIME] == null
            ? DateTime.now()
            : (json[FIELD_UPDATETIME] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() {
    DateTime time = DateTime.now();
    return {
      STRUCT_PERSONALITYMBTI: personalityMBTI ?? PersonalityMBTI().toJson(),
      // issues: #54 별자리 성격정보 입력 추가
      STRUCT_PERSONALITYSTARSIGN:
          personalityStarSign ?? PersonalityStarSign().toJson(),
      FIELD_UPDATETIME: updateTime ?? time,
    };
  }
}

// 성격정보
class PersonalityMBTI {
  String? personalityMBTI;
  DateTime? updateTime;
  bool? giveCheckCoin;

  PersonalityMBTI({this.personalityMBTI, this.updateTime, this.giveCheckCoin});

  factory PersonalityMBTI.init() {
    DateTime time = DateTime.now();
    return PersonalityMBTI(
        personalityMBTI: DATA_NONE, updateTime: time, giveCheckCoin: false);
  }
  factory PersonalityMBTI.fromJson(Map<String, dynamic> json) =>
      PersonalityMBTI(
        personalityMBTI: json[FIELD_PERSONALITYMBTI] == null
            ? null
            : json[FIELD_PERSONALITYMBTI] as String,
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
      FIELD_PERSONALITYMBTI: personalityMBTI ?? DATA_NONE,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false
    };
  }
}

// issues: #54 별자리 성격정보 입력 추가 - ellee
class PersonalityStarSign {
  String? personalityStarSign;
  DateTime? updateTime;
  bool? giveCheckCoin;

  PersonalityStarSign(
      {this.personalityStarSign, this.updateTime, this.giveCheckCoin});

  factory PersonalityStarSign.init() {
    DateTime time = DateTime.now();
    return PersonalityStarSign(
        personalityStarSign: DATA_NONE, updateTime: time, giveCheckCoin: false);
  }
  factory PersonalityStarSign.fromJson(Map<String, dynamic> json) =>
      PersonalityStarSign(
        personalityStarSign: json[FIELD_PERSONALITYSTARSIGN] == null
            ? null
            : json[FIELD_PERSONALITYSTARSIGN] as String,
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
      FIELD_PERSONALITYSTARSIGN: personalityStarSign ?? DATA_NONE,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false
    };
  }
}
