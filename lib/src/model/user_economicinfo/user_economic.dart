import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class Economic {
  // issues: #55 경제정보 입력 모델링
  EconomicProperty? economicProperty;
  EconomicCar? economicCar;
  DateTime? updateTime; // 업데이트 시간
  bool? giveCheckCoin; // 최초 정보 입력시 코인 지급 유/무 확인

  Economic({this.economicProperty, this.economicCar, this.updateTime});

  factory Economic.init() {
    DateTime time = DateTime.now();
    return Economic(
      updateTime: time,
    );
  }

  factory Economic.fromJson(Map<String, dynamic> json) => Economic(
        economicProperty: json[STRUCT_ECONOMICPROPERTY] == null
            ? null
            : EconomicProperty.fromJson(json[STRUCT_ECONOMICPROPERTY]),
        // issues: #54 별자리 성격정보 입력 추가
        economicCar: json[STRUCT_ECONOMICCAR] == null
            ? null
            : EconomicCar.fromJson(json[STRUCT_ECONOMICCAR]),
        updateTime: json[FIELD_UPDATETIME] == null
            ? DateTime.now()
            : (json[FIELD_UPDATETIME] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() {
    DateTime time = DateTime.now();
    return {
      STRUCT_ECONOMICPROPERTY: economicProperty ?? EconomicProperty().toJson(),
      STRUCT_ECONOMICCAR: economicCar ?? EconomicCar().toJson(),
      FIELD_UPDATETIME: updateTime ?? time,
    };
  }
}

// 성격정보
class EconomicProperty {
  String? economicProperty;
  DateTime? updateTime;
  bool? giveCheckCoin;

  EconomicProperty(
      {this.economicProperty, this.updateTime, this.giveCheckCoin});

  factory EconomicProperty.init() {
    DateTime time = DateTime.now();
    return EconomicProperty(
        economicProperty: DATA_NONE, updateTime: time, giveCheckCoin: false);
  }
  factory EconomicProperty.fromJson(Map<String, dynamic> json) =>
      EconomicProperty(
        economicProperty: json[FIELD_ECONOMICPROPERTY] == null
            ? null
            : json[FIELD_ECONOMICPROPERTY] as String,
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
      FIELD_ECONOMICPROPERTY: economicProperty ?? DATA_NONE,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false
    };
  }
}

class EconomicCar {
  String? economicCar;
  String? economicCarFuel;
  DateTime? updateTime;
  bool? giveCheckCoin;

  EconomicCar(
      {this.economicCar,
      this.economicCarFuel,
      this.updateTime,
      this.giveCheckCoin});

  factory EconomicCar.init() {
    DateTime time = DateTime.now();
    return EconomicCar(
        economicCar: DATA_NONE, updateTime: time, giveCheckCoin: false);
  }
  factory EconomicCar.fromJson(Map<String, dynamic> json) => EconomicCar(
        economicCar: json[FIELD_ECONOMICCAR] == null
            ? null
            : json[FIELD_ECONOMICCAR] as String,
        economicCarFuel: json[FIELD_ECONOMICCARFUEL] == null
            ? null
            : json[FIELD_ECONOMICCARFUEL] as String,
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
      FIELD_ECONOMICCAR: economicCar ?? DATA_NONE,
      FIELD_ECONOMICCARFUEL: economicCarFuel ?? DATA_NONE,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false
    };
  }
}
