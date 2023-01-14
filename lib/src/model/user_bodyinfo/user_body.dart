import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class Body {
  // 기본정보에 성별 정보 구조체 정보.
  BodyHeight? bodyHeight;
  BodyWeight? bodyWeight;
  BodyVision? bodyVision;
  BodyBloodType? bodyBloodType;
  BodyFootSize? bodyFootSize;
  DateTime? updateTime; // 업데이트 시간
  bool? giveCheckCoin; // 최초 정보 입력시 코인 지급 유/무 확인

  Body(
      {this.bodyHeight,
      this.bodyWeight,
      this.bodyVision,
      this.bodyBloodType,
      this.bodyFootSize,
      this.updateTime});

  factory Body.init() {
    DateTime time = DateTime.now();
    return Body(
      updateTime: time,
    );
  }

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        bodyHeight: json[STRUCT_BODYHEIGHT] == null
            ? null
            : BodyHeight.fromJson(json[STRUCT_BODYHEIGHT]),
        bodyWeight: json[STRUCT_BODYWEIGHT] == null
            ? null
            : BodyWeight.fromJson(json[STRUCT_BODYWEIGHT]),
        bodyVision: json[STRUCT_BODYVISION] == null
            ? null
            : BodyVision.fromJson(json[STRUCT_BODYVISION]),
        bodyBloodType: json[STRUCT_BODYBLOODTYPE] == null
            ? null
            : BodyBloodType.fromJson(json[STRUCT_BODYBLOODTYPE]),
        bodyFootSize: json[STRUCT_BODYFOOTSIZE] == null
            ? null
            : BodyFootSize.fromJson(json[STRUCT_BODYFOOTSIZE]),
        updateTime: json[FIELD_UPDATETIME] == null
            ? DateTime.now()
            : (json[FIELD_UPDATETIME] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() {
    DateTime time = DateTime.now();
    return {
      STRUCT_BODYHEIGHT: bodyHeight ?? BodyHeight().toJson(),
      STRUCT_BODYWEIGHT: bodyWeight ?? BodyWeight().toJson(),
      STRUCT_BODYVISION: bodyVision ?? BodyVision().toJson(),
      STRUCT_BODYBLOODTYPE: bodyBloodType ?? BodyBloodType().toJson(),
      STRUCT_BODYFOOTSIZE: bodyFootSize ?? BodyFootSize().toJson(),
      FIELD_UPDATETIME: updateTime ?? time,
    };
  }
}

// 키
class BodyHeight {
  num? bodyHeight;
  DateTime? updateTime;
  bool? giveCheckCoin;

  BodyHeight({this.bodyHeight, this.updateTime, this.giveCheckCoin});

  factory BodyHeight.init() {
    DateTime time = DateTime.now();
    return BodyHeight(bodyHeight: 0, updateTime: time, giveCheckCoin: false);
  }
  factory BodyHeight.fromJson(Map<String, dynamic> json) => BodyHeight(
        bodyHeight: json[FIELD_BODYHEIGHT] == null
            ? null
            : json[FIELD_BODYHEIGHT] as num,
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
      FIELD_BODYHEIGHT: bodyHeight ?? 0,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false
    };
  }
}

// 몸무게
class BodyWeight {
  num? bodyWeight;
  DateTime? updateTime;
  bool? giveCheckCoin;

  BodyWeight({this.bodyWeight, this.updateTime, this.giveCheckCoin});

  factory BodyWeight.init() {
    DateTime time = DateTime.now();
    return BodyWeight(bodyWeight: 0, updateTime: time, giveCheckCoin: false);
  }
  factory BodyWeight.fromJson(Map<String, dynamic> json) => BodyWeight(
        bodyWeight: json[FIELD_BODYWEIGHT] == null
            ? null
            : json[FIELD_BODYWEIGHT] as num,
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
      FIELD_BODYWEIGHT: bodyWeight ?? 0,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false
    };
  }
}

// 시력 (좌 우 콤마로 구분 스트링으로 적용)
class BodyVision {
  double? bodyLeftVision;
  double? bodyRightVision;
  DateTime? updateTime;
  bool? giveCheckCoin;
  bool? giveCheckCoinVision;

  BodyVision(
      {this.bodyLeftVision,
      this.bodyRightVision,
      this.updateTime,
      this.giveCheckCoin,
      this.giveCheckCoinVision});

  factory BodyVision.init() {
    DateTime time = DateTime.now();
    return BodyVision(
        bodyLeftVision: 0.0,
        bodyRightVision: 0.0,
        updateTime: time,
        giveCheckCoin: false,
        giveCheckCoinVision: false);
  }
  factory BodyVision.fromJson(Map<String, dynamic> json) => BodyVision(
        bodyLeftVision: json[FIELD_BODYLEFTVISION] == null
            ? null
            : json[FIELD_BODYLEFTVISION] as double,
        bodyRightVision: json[FIELD_BODYRIGHTVISION] == null
            ? null
            : json[FIELD_BODYRIGHTVISION] as double,
        updateTime: json[FIELD_UPDATETIME] == null
            ? DateTime.now()
            : (json[FIELD_UPDATETIME] as Timestamp).toDate(),
        giveCheckCoin: json[FIELD_GIVECHECKCOIN] == null
            ? false
            : json[FIELD_GIVECHECKCOIN] as bool,
        giveCheckCoinVision: json[FIELD_GIVECHECKCOINVISION] == null
            ? false
            : json[FIELD_GIVECHECKCOINVISION] as bool,
      );
  Map<String, dynamic> toJson() {
    DateTime time = DateTime.now();
    return {
      FIELD_BODYLEFTVISION: bodyLeftVision ?? 0.0,
      FIELD_BODYRIGHTVISION: bodyRightVision ?? 0.0,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false,
      FIELD_GIVECHECKCOINVISION: giveCheckCoinVision ?? false
    };
  }
}

// 혈액형
class BodyBloodType {
  String? bodyBloodType;
  DateTime? updateTime;
  bool? giveCheckCoin;

  BodyBloodType({this.bodyBloodType, this.updateTime, this.giveCheckCoin});

  factory BodyBloodType.init() {
    DateTime time = DateTime.now();
    return BodyBloodType(
        bodyBloodType: DATA_NONE, updateTime: time, giveCheckCoin: false);
  }
  factory BodyBloodType.fromJson(Map<String, dynamic> json) => BodyBloodType(
        bodyBloodType: json[FIELD_BODYBLOODTYPE] == null
            ? DATA_NONE
            : json[FIELD_BODYBLOODTYPE] as String,
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
      FIELD_BODYBLOODTYPE: bodyBloodType ?? DATA_NONE,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false
    };
  }
}

// 발사이즈
class BodyFootSize {
  num? bodyFootSize;
  DateTime? updateTime;
  bool? giveCheckCoin;

  BodyFootSize({this.bodyFootSize, this.updateTime, this.giveCheckCoin});

  factory BodyFootSize.init() {
    DateTime time = DateTime.now();
    return BodyFootSize(
        bodyFootSize: 0, updateTime: time, giveCheckCoin: false);
  }
  factory BodyFootSize.fromJson(Map<String, dynamic> json) => BodyFootSize(
        bodyFootSize: json[FIELD_BODYFOOTSIZE] == null
            ? null
            : json[FIELD_BODYFOOTSIZE] as num,
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
      FIELD_BODYFOOTSIZE: bodyFootSize ?? 0,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false
    };
  }
}
