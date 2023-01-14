import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/page/shop/shop_controller.dart';
import 'package:yab_v2/src/page/shop/shop_coupon_page.dart';
import 'package:yab_v2/src/page/shop/shop_detail_model.dart';
import 'package:yab_v2/src/utils/api_keys.dart';

class ShopBuyItemWidget extends GetView<ShopController> {
  const ShopBuyItemWidget(this.index, {Key? key}) : super(key: key);

  final int? index;

  Widget shopItem(ShopDetailModel shopModel) {
    String datetimeOrigin =
        controller.shopCouponDetailModelData[index!].validPrdEndDt.toString();
    String datetimeCustom =
        datetimeOrigin.substring(0, 8) + 'T' + datetimeOrigin.substring(8, 14);

    Dialog expDialog() {
      return const Dialog(
          child: SizedBox(
              height: 50, child: Center(child: Text('사용 불가능한 쿠폰 입니다.'))));
    }

    return Obx(
      () => InkWell(
        onTap: () async {
          if (controller.shopCouponDetailModelData[index!].pinStatusCd
                  .toString() ==
              '01') {
            await Get.to(() => ShopCouponPage(index));
          } else {
            Get.dialog(expDialog());
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Row(
            children: [
              Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              NetworkImage(shopModel.goodsImgS.toString())))),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: AutoSizeText(
                        '[${shopModel.brandName}] ${shopModel.goodsName.toString()}',
                        maxLines: 1,
                        minFontSize: 1,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      child: AutoSizeText(
                        controller.shopCouponDetailModelData[index!].pinStatusCd
                                    .toString() ==
                                '01'
                            ? '${DateFormat('yyyy-MM-dd').format(DateTime.parse(datetimeCustom)).toString()} 까지 사용가능'
                            : controller.shopCouponDetailModelData[index!]
                                        .pinStatusCd
                                        .toString() ==
                                    '02'
                                ? '사용 완료'
                                : controller.shopCouponDetailModelData[index!]
                                            .pinStatusCd
                                            .toString() ==
                                        '08'
                                    ? '기간만료'
                                    : '사용불가',
                        style: TextStyle(
                          color: controller.shopCouponDetailModelData[index!]
                                      .pinStatusCd
                                      .toString() ==
                                  '01'
                              ? Colors.grey
                              : Colors.red,
                        ),
                        maxLines: 1,
                        minFontSize: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          height: Get.size.height / 7,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => Column(
                    children: [
                      if (controller
                              .shopCouponDetailModelData[index!].goodsCd ==
                          SHOP_STARBUCKS)
                        shopItem(controller.starbucksDetailModel.value),
                      if (controller
                              .shopCouponDetailModelData[index!].goodsCd ==
                          SHOP_BANANAMILK)
                        shopItem(controller.bananamilkModel.value),
                      if (controller
                              .shopCouponDetailModelData[index!].goodsCd ==
                          SHOP_CHICKEN)
                        shopItem(controller.chickenModel.value),
                      if (controller
                              .shopCouponDetailModelData[index!].goodsCd ==
                          SHOP_HAMBURGER)
                        shopItem(controller.hamburgerModel.value),
                      if (controller
                              .shopCouponDetailModelData[index!].goodsCd ==
                          SHOP_ICECREAM)
                        shopItem(controller.icecreamModel.value),
                      if (controller
                              .shopCouponDetailModelData[index!].goodsCd ==
                          SHOP_DONUT)
                        shopItem(controller.donutModel.value),
                      if (controller
                              .shopCouponDetailModelData[index!].goodsCd ==
                          SHOP_MOVIE)
                        shopItem(controller.movieModel.value)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
