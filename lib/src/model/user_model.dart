import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/model/user_bodyinfo/user_body.dart';
import 'package:yab_v2/src/model/user_economicinfo/user_economic.dart';
import 'package:yab_v2/src/model/user_healthinfo/user_health.dart';
import 'package:yab_v2/src/model/user_info/address.dart';
import 'package:yab_v2/src/model/user_info/birth.dart';
import 'package:yab_v2/src/model/user_info/children.dart';
import 'package:yab_v2/src/model/user_info/education.dart';
import 'package:yab_v2/src/model/user_info/gender.dart';
import 'package:yab_v2/src/model/user_info/maritalstatus.dart';
import 'package:yab_v2/src/model/user_info/nationality.dart';
import 'package:yab_v2/src/model/user_personalityinfo/user_personality.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class UserModel {
  // 유저 정보 모델
  String? userKey; // 유저 키
  String? email; // 이메일
  DateTime? createdDate; // 생성 시간
  num? coin; // 코인
  Gender? gender; // 성별 구조체
  MaritalStatus? maritalStatus; // 결혼 유무 구조체
  Children? children; // 아이 유무 구조체
  Nationality? nationality; // 국적 구조체
  Birth? birth; // 생년월일 구조체
  // issues: #46 학력정보 구조체 생성
  Education? education; // 학력정보 구조체
  Address? address; // 주소 구조체
  Body? body; // 신체정보 구조체
  Health? health;
  Personality? personality; // 성격정보 구조체
  Economic? economic; // 경제정보 구조체
  bool? premiumUser; // 인증받은 유저 값
  String? fcmToken; // 푸시 알림 토큰
  DocumentReference? reference;

  UserModel({
    this.userKey,
    this.email,
    this.createdDate,
    this.coin = 0,
    this.gender,
    this.maritalStatus,
    this.children,
    this.nationality,
    this.birth,
    this.education, // issues: #46 학력정보 입력, 검색 생성 - ellee
    this.address,
    this.body,
    this.health, // issues: #45 건강정보 입력, 검색 생성 - ellee
    this.personality, // issues: #51 성격정보 입력, 검색 생성 - ellee
    this.economic, // issues: #55 경제정보 모델 생성 - ellee
    this.premiumUser,
    this.fcmToken,
    this.reference,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    //, this.userKey, this.reference) {
    return UserModel(
      userKey: json[FIELD_USERKEY] == null ? '' : json[FIELD_USERKEY] as String,
      email:
          json[FIELD_EMAIL] == null ? 'Anonymous' : json[FIELD_EMAIL] as String,
      createdDate: json[FIELD_CREATEDDATE] == null
          ? DateTime.now()
          : (json[FIELD_CREATEDDATE] as Timestamp).toDate(),
      coin: json[FIELD_COIN] == null ? 0 : json[FIELD_COIN] as num,
      premiumUser: json[FIELD_PREMIUMUSER] == null
          ? null
          : json[FIELD_PREMIUMUSER] as bool,
      gender: json[STRUCT_GENDER] == null
          ? null
          : Gender.fromJson(json[STRUCT_GENDER]),
      maritalStatus: json[STRUCT_MARITALSTATUS] == null
          ? null
          : MaritalStatus.fromJson(json[STRUCT_MARITALSTATUS]),
      children: json[STRUCT_CHILDREN] == null
          ? null
          : Children.fromJson(json[STRUCT_CHILDREN]),
      nationality: json[STRUCT_NATIONALITY] == null
          ? null
          : Nationality.fromJson(json[STRUCT_NATIONALITY]),
      birth: json[STRUCT_BIRTH] == null
          ? null
          : Birth.fromJson(json[STRUCT_BIRTH]),
      // issues: #46 학력정보 구조체 생성
      education: json[STRUCT_EDUCATION] == null
          ? null
          : Education.fromJson(json[STRUCT_EDUCATION]),
      address: json[STRUCT_ADDRESS] == null
          ? null
          : Address.fromJson(json[STRUCT_ADDRESS]),
      body: json[STRUCT_BODY] == null ? null : Body.fromJson(json[STRUCT_BODY]),
      // issues: #45 건강정보 입력, 생성 - ellee
      health: json[STRUCT_HEALTH] == null
          ? null
          : Health.fromJson(json[STRUCT_HEALTH]),
      // issues: #51 성격정보 입력, 생성 - ellee
      personality: json[STRUCT_PERSONALITY] == null
          ? null
          : Personality.fromJson(json[STRUCT_PERSONALITY]),
      // issues: #55 경제정보 입력 모델링 - ellee
      economic: json[STRUCT_ECONOMIC] == null
          ? null
          : Economic.fromJson(json[STRUCT_ECONOMIC]),
      fcmToken:
          json[FIELD_FCMTOKEN] == null ? '' : json[FIELD_FCMTOKEN] as String,
      reference: json['reference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FIELD_USERKEY: userKey,
      FIELD_EMAIL: email,
      FIELD_CREATEDDATE: createdDate,
      FIELD_COIN: coin,
      STRUCT_GENDER: gender!.toJson(),
      STRUCT_MARITALSTATUS: maritalStatus!.toJson(),
      STRUCT_CHILDREN: children!.toJson(),
      STRUCT_NATIONALITY: nationality!.toJson(),
      STRUCT_BIRTH: birth!.toJson(),
      // issues: #46 학력정보 구조체 생성
      STRUCT_EDUCATION: education!.toJson(),
      STRUCT_ADDRESS: address!.toJson(),
      STRUCT_BODY: body!.toJson(),
      STRUCT_HEALTH: health!.toJson(),
      // issues: #51 성격정보 입력, 생성 - ellee
      STRUCT_PERSONALITY: personality!.toJson(),
      // issues: #55 경제정보 입력 모델링 - ellee
      STRUCT_ECONOMIC: economic!.toJson(),
      FIELD_FCMTOKEN: fcmToken,
    };
  }
}
