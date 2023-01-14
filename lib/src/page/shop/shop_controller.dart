import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/page/shop/shop_detail_model.dart';
import 'package:yab_v2/src/page/shop/shop_report_repository.dart';
import 'package:yab_v2/src/utils/api_keys.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class ShopController extends GetxController {
  static ShopController get to => Get.find();

// issues: #56 상점 API 정보
  Rx<ShopBuyErrorReport> apiErrorModel = ShopBuyErrorReport().obs;
  Rx<ShopBuyReport> buyModel = ShopBuyReport().obs;
  Rx<ShopDetailModel> starbucksDetailModel =
      ShopDetailModel().obs; // 스타벅스 아메리카노
  Rx<ShopDetailModel> bananamilkModel = ShopDetailModel().obs;
  Rx<ShopDetailModel> chickenModel = ShopDetailModel().obs;
  Rx<ShopDetailModel> hamburgerModel = ShopDetailModel().obs;
  Rx<ShopDetailModel> icecreamModel = ShopDetailModel().obs;
  Rx<ShopDetailModel> donutModel = ShopDetailModel().obs;
  Rx<ShopDetailModel> movieModel = ShopDetailModel().obs;

  // issues: #56 상점 구매내역 리스트
  RxList<ShopBuyReport> shopBuyListdata = <ShopBuyReport>[].obs; // 구매내역 리스트
  RxList<ShopCouponDetailModel> shopCouponDetailModelData =
      <ShopCouponDetailModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool hasMore = false.obs;
  Rx<ScrollController> scrollController = ScrollController().obs;
  RxInt testtest = 0.obs;

  Future<List<ShopBuyReport>> getShopBuyListdata() async {
    return await ShopReportRepository.getShopBuyList();
  }

  void inc(a) {
    testtest(a++);
    update();
  }

  @override
  void onInit() async {
    if (!isLoading.value) {
      await onRefres();
      isLoading(true);
      update();
    }

    await getShopCoffee();
    await getShopBananamilk();
    await getShopChicken();
    await getShopHambuger();
    await getShopIcecream();
    await getShopDonut();
    await getShopMovie();

    _getData();
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          hasMore.value) {
        _getData();
      }
    });

    super.onInit();
  }

  _getData() async {
    isLoading.value = true;

    shopBuyListdata.addAll(await ShopReportRepository.getShopBuyList());
    if (shopBuyListdata.isEmpty) {
      shopCouponDetailModelData.add(ShopCouponDetailModel());
    }
    for (int i = 0; i < shopBuyListdata.length; i++) {
      await getCouponsDetail(shopBuyListdata[i].trId.toString());
    }
    isLoading.value = false;
    hasMore.value = shopBuyListdata.length < shopBuyListdata.length;
  }

  reload() async {
    isLoading.value = true;
    shopBuyListdata.clear();
    shopCouponDetailModelData.clear();
    _getData();
  }

  Future<void> onRefres() async {
    shopBuyListdata.clear();
    shopCouponDetailModelData.clear();
    shopBuyListdata.addAll(await ShopReportRepository.getShopBuyList());
  }

  Future<void> getShopCoffee() async {
    // 스타벅스 아메리카노
    Map<String, dynamic> queryparameter = {
      'api_code': SHOP_DETAILCODE,
      'custom_auth_code': SHOP_KEY,
      'custom_auth_token': SHOP_TOKEN,
      'dev_yn': 'N',
    };
    dynamic response = await Dio().post(
        'https://bizapi.giftishow.com/bizApi/goods/$SHOP_STARBUCKS',
        queryParameters: queryparameter);
    starbucksDetailModel.value =
        ShopDetailModel.fromJson(response.data[SHOP_RESULT][SHOP_GOODSDETAIL]);
  }

  Future<void> getShopBananamilk() async {
    Map<String, dynamic> queryparameter = {
      'api_code': SHOP_DETAILCODE,
      'custom_auth_code': SHOP_KEY,
      'custom_auth_token': SHOP_TOKEN,
      'dev_yn': 'N',
    };
    dynamic response = await Dio().post(
        'https://bizapi.giftishow.com/bizApi/goods/$SHOP_BANANAMILK',
        queryParameters: queryparameter);
    bananamilkModel.value =
        ShopDetailModel.fromJson(response.data[SHOP_RESULT][SHOP_GOODSDETAIL]);
  }

  Future<void> getShopChicken() async {
    Map<String, dynamic> queryparameter = {
      'api_code': SHOP_DETAILCODE,
      'custom_auth_code': SHOP_KEY,
      'custom_auth_token': SHOP_TOKEN,
      'dev_yn': 'N',
    };
    dynamic response = await Dio().post(
        'https://bizapi.giftishow.com/bizApi/goods/$SHOP_CHICKEN',
        queryParameters: queryparameter);
    chickenModel.value =
        ShopDetailModel.fromJson(response.data[SHOP_RESULT][SHOP_GOODSDETAIL]);
  }

  Future<void> getShopHambuger() async {
    Map<String, dynamic> queryparameter = {
      'api_code': SHOP_DETAILCODE,
      'custom_auth_code': SHOP_KEY,
      'custom_auth_token': SHOP_TOKEN,
      'dev_yn': 'N',
    };
    dynamic response = await Dio().post(
        'https://bizapi.giftishow.com/bizApi/goods/$SHOP_HAMBURGER',
        queryParameters: queryparameter);
    hamburgerModel.value =
        ShopDetailModel.fromJson(response.data[SHOP_RESULT][SHOP_GOODSDETAIL]);
  }

  Future<void> getShopIcecream() async {
    Map<String, dynamic> queryparameter = {
      'api_code': SHOP_DETAILCODE,
      'custom_auth_code': SHOP_KEY,
      'custom_auth_token': SHOP_TOKEN,
      'dev_yn': 'N',
    };
    dynamic response = await Dio().post(
        'https://bizapi.giftishow.com/bizApi/goods/$SHOP_ICECREAM',
        queryParameters: queryparameter);
    icecreamModel.value =
        ShopDetailModel.fromJson(response.data[SHOP_RESULT][SHOP_GOODSDETAIL]);
  }

  Future<void> getShopDonut() async {
    Map<String, dynamic> queryparameter = {
      'api_code': SHOP_DETAILCODE,
      'custom_auth_code': SHOP_KEY,
      'custom_auth_token': SHOP_TOKEN,
      'dev_yn': 'N',
    };
    dynamic response = await Dio().post(
        'https://bizapi.giftishow.com/bizApi/goods/$SHOP_DONUT',
        queryParameters: queryparameter);
    donutModel.value =
        ShopDetailModel.fromJson(response.data[SHOP_RESULT][SHOP_GOODSDETAIL]);
  }

  Future<void> getShopMovie() async {
    Map<String, dynamic> queryparameter = {
      'api_code': SHOP_DETAILCODE,
      'custom_auth_code': SHOP_KEY,
      'custom_auth_token': SHOP_TOKEN,
      'dev_yn': 'N',
    };
    dynamic response = await Dio().post(
        'https://bizapi.giftishow.com/bizApi/goods/$SHOP_MOVIE',
        queryParameters: queryparameter);
    movieModel.value =
        ShopDetailModel.fromJson(response.data[SHOP_RESULT][SHOP_GOODSDETAIL]);
  }

  Future<void> shopBuy(String goodsCode) async {
    String trId =
        '${num.parse(DateFormat('yyyyMMddkkmmss').format(DateTime.now()))}_${UserController.to.userModel.value.userKey?.substring(0, 8)}';
    Map<String, dynamic> queryparameter = {
      'api_code': SHOP_BUYCODE,
      'custom_auth_code': SHOP_KEY,
      'custom_auth_token': SHOP_TOKEN,
      'dev_yn': 'N',
      'goods_code': goodsCode,
      'callback_no': '15886474', // 기프티쇼 발신번호
      'phone_no': '01234567890',
      'mms_title': '기프티콘',
      'mms_msg': '발송',
      'tr_id': trId,
      'template_id': SHOP_CARDID,
      'banner_id': SHOP_BANNERID,
      'gubun': 'I',
      'user_id': SELLDY_EMAIL,
      // 'rev_info_yn': 'Y',
      // 'rev_info_date':
      //     '${num.parse(DateFormat('yyyyMMdd').format(DateTime.now()))}',
      // 'rev_info_time': '1000'
    };
    dynamic response = await Dio().post(
        'https://bizapi.giftishow.com/bizApi/send',
        queryParameters: queryparameter);
    apiErrorModel.value = ShopBuyErrorReport.fromJson(response.data);
    if (apiErrorModel.value.code == '0000') {
      buyModel.value =
          ShopBuyReport.fromJson(response.data[SHOP_RESULT][SHOP_RESULT]);

      ShopReportRepository.shopBuyItem(
          buyModel.value.orderNo.toString(),
          buyModel.value.pinNo.toString(),
          buyModel.value.cuponImgUrl.toString(),
          trId);
    }
  }

  Future<void> getCouponsDetail(String trid) async {
    Map<String, dynamic> queryparameter = {
      'api_code': SHOP_COUPONSCODE,
      'custom_auth_code': SHOP_KEY,
      'custom_auth_token': SHOP_TOKEN,
      'dev_yn': 'N',
      'tr_id': trid
    };
    dynamic response = await Dio().post(
        'https://bizapi.giftishow.com/bizApi/coupons/',
        queryParameters: queryparameter);
    shopCouponDetailModelData.add(ShopCouponDetailModel.fromJson(
        response.data[SHOP_RESULT][0][SHOP_COUPON_INFOLIST][0]));
    // shopCouponDetailModelData.add(ShopCouponDetailModel.fromJson(
    //     response.data[SHOP_RESULT][0][SHOP_COUPON_INFOLIST]));
  }
}
