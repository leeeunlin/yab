import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class Address {
  // 기본정보에 주소 정보 구조체
  RoadAddress? roadAddress; // 도로명 주소 구조체
  ParcelAddress? parcelAddress; // 지번 주소 구조체
  double? lat;
  double? lot;
  GeoFirePoint? geoFirePoint;
  DateTime? updateTime; // 업데이트 시간
  bool? giveCheckCoin; // 최초 정보 입력시 코인 지급 유/무 확인

  Address(
      {this.roadAddress,
      this.parcelAddress,
      this.geoFirePoint,
      this.updateTime,
      this.giveCheckCoin});

  factory Address.init() {
    DateTime time = DateTime.now();
    return Address(
        // roadAddress: RoadAddress.init(),
        // parcelAddress: ParcelAddress.init(),
        // geoFirePoint: GeoFirePoint(0, 0),
        updateTime: time,
        giveCheckCoin: false);
  }

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        roadAddress: json[STRUCT_ROAD] == null
            ? null
            : RoadAddress.fromJson(json[STRUCT_ROAD]),
        parcelAddress: json[STRUCT_PARCEL] == null
            ? null
            : ParcelAddress.fromJson(json[STRUCT_PARCEL]),
        geoFirePoint: json[FIELD_GEOFIREPOINT] == null
            ? GeoFirePoint(0, 0)
            : GeoFirePoint((json[FIELD_GEOFIREPOINT]['geopoint']).latitude,
                (json[FIELD_GEOFIREPOINT]['geopoint']).longitude),
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
      STRUCT_ROAD: roadAddress ?? RoadAddress().toJson(),
      STRUCT_PARCEL: parcelAddress ?? ParcelAddress().toJson(),
      FIELD_GEOFIREPOINT: geoFirePoint ?? GeoFirePoint(0, 0).data,
      FIELD_UPDATETIME: updateTime ?? time,
      FIELD_GIVECHECKCOIN: giveCheckCoin ?? false
    };
  }
}

// 도로명 주소 구조체
// level1   => 서울특별시
// level2   => 서초구
// level4A  => 방배4동
// level4L  => 서초대로
// level5   => 101
// text     => 서울특별시 서초구 서초대로 101 (방배동,대성빌딩)
class RoadAddress {
  String? level1; // 시 도 ex) 서울특별시
  String? level2; // 시 군 구 ex) 서초구
  String? level4A; // (도로)행정읍 면 동 명 (지번)지원안함 ex) 방배1동
  String? level4L; // (도로)도로명, (지번)법정읍 면 동 명 ex) 방배동
  String? level5; // (도로)길, (지번)번지 ex) 897-2
  String? text; // 전체 주소

  RoadAddress(
      {this.level1,
      this.level2,
      this.level4A,
      this.level4L,
      this.level5,
      this.text});

  factory RoadAddress.init() {
    return RoadAddress(
        level1: '', level2: '', level4A: '', level4L: '', level5: '', text: '');
  }

  factory RoadAddress.fromJson(Map<String, dynamic> json) => RoadAddress(
        level1: json[FIELD_LEVEL1] == null ? '' : json[FIELD_LEVEL1] as String,
        level2: json[FIELD_LEVEL2] == null ? '' : json[FIELD_LEVEL2] as String,
        level4A:
            json[FIELD_LEVEL4A] == null ? '' : json[FIELD_LEVEL4A] as String,
        level4L:
            json[FIELD_LEVEL4L] == null ? '' : json[FIELD_LEVEL4L] as String,
        level5: json[FIELD_LEVEL5] == null ? '' : json[FIELD_LEVEL5] as String,
        text: json[FIELD_TEXT] == null ? '' : json[FIELD_TEXT] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      FIELD_LEVEL1: level1 ?? '',
      FIELD_LEVEL2: level2 ?? '',
      FIELD_LEVEL4A: level4A ?? '',
      FIELD_LEVEL4L: level4L ?? '',
      FIELD_LEVEL5: level5 ?? '',
      FIELD_TEXT: text ?? ''
    };
  }
}

// 지번 주소 구조체
// level1   => 서울특별시
// level2   => 서초구
// level4A  => 방배4동
// level4L  => 방배동
// level5   => 874-10
// text     => 서울특별시 서초구 방배동 874-10
class ParcelAddress {
  String? level1; // 시 도 ex) 서울특별시
  String? level2; // 시 군 구 ex) 서초구
  String? level4A; // (도로)행정읍 면 동 명 (지번)지원안함 ex) 방배1동
  String? level4L; // (도로)도로명, (지번)법정읍 면 동 명 ex) 방배동
  String? level5; // (도로)길, (지번)번지 ex) 897-2
  String? text; // 전체 주소

  ParcelAddress(
      {this.level1,
      this.level2,
      this.level4A,
      this.level4L,
      this.level5,
      this.text});

  factory ParcelAddress.init() {
    return ParcelAddress(
        level1: '', level2: '', level4A: '', level4L: '', level5: '', text: '');
  }

  factory ParcelAddress.fromJson(Map<String, dynamic> json) => ParcelAddress(
        level1: json[FIELD_LEVEL1] == null ? '' : json[FIELD_LEVEL1] as String,
        level2: json[FIELD_LEVEL2] == null ? '' : json[FIELD_LEVEL2] as String,
        level4A:
            json[FIELD_LEVEL4A] == null ? '' : json[FIELD_LEVEL4A] as String,
        level4L:
            json[FIELD_LEVEL4L] == null ? '' : json[FIELD_LEVEL4L] as String,
        level5: json[FIELD_LEVEL5] == null ? '' : json[FIELD_LEVEL5] as String,
        text: json[FIELD_TEXT] == null ? '' : json[FIELD_TEXT] as String,
      );

  Map<String, dynamic> toJson() {
    return {
      FIELD_LEVEL1: level1 ?? '',
      FIELD_LEVEL2: level2 ?? '',
      FIELD_LEVEL4A: level4A ?? '',
      FIELD_LEVEL4L: level4L ?? '',
      FIELD_LEVEL5: level5 ?? '',
      FIELD_TEXT: text ?? ''
    };
  }
}
