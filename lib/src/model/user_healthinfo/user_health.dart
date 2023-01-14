import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class Health {
  // 기본정보에 성별 정보 구조체 정보.
  HealthTabacco? healthTabacco;
  HealthAlcohol? healthAlcohol;
  HealthExercise? healthExercise;
  DateTime? updateTime; // 업데이트 시간
  bool? giveCheckCoin; // 최초 정보 입력시 코인 지급 유/무 확인

  Health(
      {this.healthTabacco,
      this.healthAlcohol,
      this.healthExercise,
      this.updateTime});

  factory Health.init() {
    DateTime time = DateTime.now();
    return Health(
      updateTime: time,
    );
  }

  factory Health.fromJson(Map<String, dynamic> json) => Health(
        healthTabacco: json[STRUCT_HEALTHTABACCO] == null
            ? null
            : HealthTabacco.fromJson(json[STRUCT_HEALTHTABACCO]),
        healthAlcohol: json[STRUCT_HEALTHALCOHOL] == null
            ? null
            : HealthAlcohol.fromJson(json[STRUCT_HEALTHALCOHOL]),
        healthExercise: json[STRUCT_HEALTHEXERCISE] == null
            ? null
            : HealthExercise.fromJson(json[STRUCT_HEALTHEXERCISE]),
        updateTime: json[FIELD_UPDATETIME] == null
            ? DateTime.now()
            : (json[FIELD_UPDATETIME] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() {
    DateTime time = DateTime.now();
    return {
      STRUCT_HEALTHTABACCO: healthTabacco ?? HealthTabacco().toJson(),
      STRUCT_HEALTHALCOHOL: healthAlcohol ?? HealthAlcohol().toJson(),
      STRUCT_HEALTHEXERCISE: healthExercise ?? HealthExercise().toJson(),
      FIELD_UPDATETIME: updateTime ?? time,
    };
  }
}

// 담배
class HealthTabacco {
  num? healthTabacco;
  DateTime? updateTime;
  bool? giveCheckCoin;

  HealthTabacco({this.healthTabacco, this.updateTime, this.giveCheckCoin});

  factory HealthTabacco.init() {
    DateTime time = DateTime.now();
    return HealthTabacco(
        healthTabacco: null, updateTime: time, giveCheckCoin: false);
  }
  factory HealthTabacco.fromJson(Map<String, dynamic> json) => HealthTabacco(
        healthTabacco: json[FIELD_HEALTHTABACCO] == null
            ? null
            : json[FIELD_HEALTHTABACCO] as num,
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
      FIELD_HEALTHTABACCO: healthTabacco ?? -1,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false
    };
  }
}

// 술
class HealthAlcohol {
  String? healthAlcohol;
  DateTime? updateTime;
  bool? giveCheckCoin;

  HealthAlcohol({this.healthAlcohol, this.updateTime, this.giveCheckCoin});

  factory HealthAlcohol.init() {
    DateTime time = DateTime.now();
    return HealthAlcohol(
        healthAlcohol: DATA_NONE, updateTime: time, giveCheckCoin: false);
  }
  factory HealthAlcohol.fromJson(Map<String, dynamic> json) => HealthAlcohol(
        healthAlcohol: json[FIELD_HEALTHALCOHOL] == null
            ? null
            : json[FIELD_HEALTHALCOHOL] as String,
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
      FIELD_HEALTHALCOHOL: healthAlcohol ?? DATA_NONE,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false
    };
  }
}

// 운동시간
class HealthExercise {
  num? healthExercise;
  DateTime? updateTime;
  bool? giveCheckCoin;

  HealthExercise({this.healthExercise, this.updateTime, this.giveCheckCoin});

  factory HealthExercise.init() {
    DateTime time = DateTime.now();
    return HealthExercise(
        healthExercise: null, updateTime: time, giveCheckCoin: false);
  }
  factory HealthExercise.fromJson(Map<String, dynamic> json) => HealthExercise(
        healthExercise: json[FIELD_HEALTHEXERCISE] == null
            ? null
            : json[FIELD_HEALTHEXERCISE] as num,
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
      FIELD_HEALTHEXERCISE: healthExercise ?? -1,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false
    };
  }
}
