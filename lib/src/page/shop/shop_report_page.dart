import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/page/shop/shop_buyitem_widget.dart';
import 'package:yab_v2/src/page/shop/shop_controller.dart';

class ShopReportPage extends GetView<ShopController> {
  const ShopReportPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:
            false, // android : default값은 왼쪽 정렬 / IOS : default값은 가운데 정렬
        title: const Text('구매내역'),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async {
            await controller.reload();
          },
          child: ListView.separated(
            controller: controller.scrollController.value,
            itemBuilder: (_, index) {
              if (index < controller.shopCouponDetailModelData.length) {
                if (controller.shopCouponDetailModelData[0].pinStatusCd ==
                    null) {
                  return Container();
                } else {
                  return ShopBuyItemWidget(index);
                }
              }
              if (controller.hasMore.value || controller.isLoading.value) {
                return const Center(child: RefreshProgressIndicator());
                // return ElevatedButton(
                //     onPressed: () {
                //       controller.inc(3);
                //       //controller.testtest.value++;
                //     },
                //     child: Text(controller.testtest.value.toString()));
              }

              return Container(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    children: const [
                      Text('30일 이내 구매내역만 표시되며\n사용하지 않은 쿠폰은 30일 이후 만료됩니다.'),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, index) {
              return Divider(
                height: 0, //기본패딩 제거
                thickness: 1,
                color: Colors.grey[300],
              );
            },
            itemCount: controller.shopCouponDetailModelData.length + 1,
          ),
        ),
      ),
    );
  }
}
