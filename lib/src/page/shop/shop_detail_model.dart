import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

// issues: #56 상점 API 정보
class ShopDetailModel {
  String? goodsImgS;
  String? brandName;
  String? goodsName;
  String? goodsCode;
  String? content;
  num? realPrice;
  ShopDetailModel({
    this.goodsImgS,
    this.brandName,
    this.goodsName,
    this.goodsCode,
    this.content,
    this.realPrice,
  });

  factory ShopDetailModel.fromJson(Map<String, dynamic> json) {
    return ShopDetailModel(
      goodsImgS:
          json[SHOP_GOODSIMGS] == null ? '' : json[SHOP_GOODSIMGS] as String,
      brandName:
          json[SHOP_BRANDNAME] == null ? '' : json[SHOP_BRANDNAME] as String,
      goodsName:
          json[SHOP_GOODSNAME] == null ? '' : json[SHOP_GOODSNAME] as String,
      goodsCode:
          json[SHOP_GOODSCODE] == null ? '' : json[SHOP_GOODSCODE] as String,
      content: json[SHOP_CONTENT] == null ? '' : json[SHOP_CONTENT] as String,
      realPrice:
          json[SHOP_REALPRICE] == null ? 0 : json[SHOP_REALPRICE] * 100 as num,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      SHOP_GOODSIMGS: goodsImgS,
      SHOP_BRANDNAME: brandName,
      SHOP_GOODSNAME: goodsName,
      SHOP_GOODSCODE: goodsCode,
      SHOP_CONTENT: content,
      SHOP_REALPRICE: realPrice
    };
  }
}

// issues: #56 상점 구매정보 DB저장
class ShopBuyReport {
  String? orderNo;
  String? pinNo;
  String? cuponImgUrl;
  String? trId;
  DateTime? createdDate;
  ShopBuyReport(
      {this.orderNo,
      this.pinNo,
      this.cuponImgUrl,
      this.trId,
      this.createdDate});
  factory ShopBuyReport.fromJson(Map<String, dynamic> json) {
    return ShopBuyReport(
      orderNo: json[FIELD_ORDERNO] == null ? '' : json[FIELD_ORDERNO] as String,
      pinNo: json[FIELD_PINNO] == null ? '' : json[FIELD_PINNO] as String,
      cuponImgUrl: json[FIELD_CUPONIMGURL] == null
          ? ''
          : json[FIELD_CUPONIMGURL] as String,
      trId: json[FIELD_TRID] == null ? '' : json[FIELD_TRID] as String,
      createdDate: json[FIELD_CREATEDDATE] == null
          ? DateTime.now()
          : (json[FIELD_CREATEDDATE] as Timestamp).toDate(),
    );
  }
  Map<String, dynamic> toMap(String orderNo, String pinNo, String cuponImgUrl,
      String trId, DateTime createdDate) {
    return {
      FIELD_ORDERNO: orderNo,
      FIELD_PINNO: pinNo,
      FIELD_CUPONIMGURL: cuponImgUrl,
      FIELD_TRID: trId,
      FIELD_CREATEDDATE: createdDate
    };
  }
}

class ShopCouponDetailModel {
  String? goodsCd;
  String? pinStatusCd;
  String? goodsNm;
  String? brandNm;
  String? mmsBrandThumImg;
  String? validPrdEndDt;

  ShopCouponDetailModel({
    this.goodsCd,
    this.pinStatusCd,
    this.goodsNm,
    this.brandNm,
    this.mmsBrandThumImg,
    this.validPrdEndDt,
  });

  factory ShopCouponDetailModel.fromJson(Map<String, dynamic> json) {
    return ShopCouponDetailModel(
      goodsCd: json[SHOP_COUPON_GOODSCD] == null
          ? ''
          : json[SHOP_COUPON_GOODSCD] as String,
      pinStatusCd: json[SHOP_COUPON_PINSTATUSCD] == null
          ? ''
          : json[SHOP_COUPON_PINSTATUSCD] as String,
      goodsNm: json[SHOP_COUPON_GOODSNM] == null
          ? ''
          : json[SHOP_COUPON_GOODSNM] as String,
      brandNm: json[SHOP_COUPON_BRANDNM] == null
          ? ''
          : json[SHOP_COUPON_BRANDNM] as String,
      mmsBrandThumImg: json[SHOP_COUPON_MMSBRANDTHUMIMG] == null
          ? ''
          : json[SHOP_COUPON_MMSBRANDTHUMIMG] as String,
      validPrdEndDt: json[SHOP_COUPON_VALIDPRDENDDT] == null
          ? ''
          : json[SHOP_COUPON_VALIDPRDENDDT] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      SHOP_COUPON_GOODSCD: goodsCd,
      SHOP_COUPON_PINSTATUSCD: pinStatusCd,
      SHOP_COUPON_GOODSNM: goodsNm,
      SHOP_COUPON_BRANDNM: brandNm,
      SHOP_COUPON_MMSBRANDTHUMIMG: mmsBrandThumImg,
      SHOP_COUPON_VALIDPRDENDDT: validPrdEndDt,
    };
  }
}

class ShopBuyErrorReport {
  String? code;
  String? message;

  ShopBuyErrorReport({this.code, this.message});

  factory ShopBuyErrorReport.fromJson(Map<String, dynamic> json) {
    return ShopBuyErrorReport(
        code: json[SHOP_CODE] == null ? '' : json[SHOP_CODE] as String,
        message:
            json[SHOP_MESSAGE] == null ? '' : json[SHOP_MESSAGE] as String);
  }
}
