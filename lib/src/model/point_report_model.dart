import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class PointReportModel {
  String? mode; // 포인트 사용처 안내
  num? price;
  DateTime? createdDate;
  PointReportModel({this.mode, this.price, this.createdDate});

  factory PointReportModel.fromJson(Map<String, dynamic> json) {
    return PointReportModel(
      mode: json[FIELD_MODE] == null ? '' : json[FIELD_MODE] as String,
      price: json[FIELD_PRICE] == null ? 0 : json[FIELD_PRICE] as num,
      createdDate: json[FIELD_CREATEDDATE] == null
          ? DateTime.now()
          : (json[FIELD_CREATEDDATE] as Timestamp).toDate(),
    );
  }
  factory PointReportModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return PointReportModel.fromJson(snapshot.data()!);
  }
  Map<String, dynamic> toMap(
      num subPoint, String itemName, DateTime createdDate) {
    return {
      FIELD_MODE: itemName,
      FIELD_PRICE: subPoint,
      FIELD_CREATEDDATE: createdDate
    };
  }
}

const Map<String, String> pointReportMapEngToKor = {
  'buy_shop': '상점 구매',
  'info': '정보 수정',
  'send': '게시글 작성',
  'receive': '게시물 확인',
  'charge': '포인트 충전',
  'information_use': '정보활용 지급',
  'refund': '만료일 환불',
  'attendance': '출석체크',
  'send_qr_yab': '출금',
  'Receive_qr_yab': '입금',
  'cancel_reservation': '예약 게시 취소'
};

const Map<String, String> pointReportMapKorToEng = {
  '상점 구매': 'buy_shop',
  '정보 수정': 'info',
  '게시글 작성': 'send',
  '게시물 확인': 'receive',
  '포인트 충전': 'charge',
  '정보활용 지급': 'information_use',
  '만료일 환불': 'refund',
  '출석체크': 'attendance',
  '출금': 'send_qr_yab',
  '입금': 'Receive_qr_yab',
  '예약 게시 취소': 'cancel_reservation'
};
