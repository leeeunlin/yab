import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/page/shop/shop_controller.dart';

class ShopListPage extends GetView<UserController> {
  const ShopListPage(
      this.name, this.imgsrc, this.price, this.detail, this.goodsCode,
      {Key? key})
      : super(key: key);
  final String name;
  final String imgsrc;
  final String detail;
  final String goodsCode;
  final num price;

  void pointCheck(String name, num price) async {
    var f = NumberFormat('###,###,###,###');
    await Get.defaultDialog(
      titlePadding: const EdgeInsets.all(20),
      titleStyle: const TextStyle(fontSize: 17),
      title: name,
      middleText: controller.userModel.value.coin! < price
          ? '${f.format(price - controller.userModel.value.coin!)} YAB이 더 필요합니다.'
          : '$name 구매로 \n ${f.format(price)} YAB이 차감됩니다.\n\n구매하시겠습니까?',
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.black.withOpacity(0),
                shadowColor: Colors.black.withOpacity(0)),
            onPressed: () {
              Get.back(); // 팝업창 닫기
            },
            child: const Text('아니오')),
        if (controller.userModel.value.coin! >= price)
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.black.withOpacity(0),
                  shadowColor: Colors.black.withOpacity(0)),
              onPressed: () async {
                await ShopController.to.shopBuy(goodsCode);
                if (ShopController.to.apiErrorModel.value.code == 'E0010') {
                  Get.back();
                  Get.snackbar('구매중 문제가 발생하였습니다.', 'YAB 고객센터로 문의하세요');
                } else if (ShopController.to.apiErrorModel.value.code !=
                    '0000') {
                  Get.back();
                  Get.snackbar('구매중 문제가 발생하였습니다.', '상품정보의 기프티쇼 고객센터로 문의하세요');
                } else {
                  await controller.subPoint(
                      controller.userModel.value.userKey!, price, 'buy_shop');
                  Get.back(); // 팝업창 닫기
                  Get.back();
                  Get.snackbar('구매를 완료 하였습니다.', '상점페이지의 구매내역에서 확인해주세요');
                }
              },
              child: const Text('예')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###'); // 숫자 자르기
    return Scaffold(
      appBar: AppBar(
        centerTitle:
            false, // android : default값은 왼쪽 정렬 / IOS : default값은 가운데 정렬
        title: const Text('상품정보'),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black, width: 2),
                        image: DecorationImage(image: NetworkImage(imgsrc)))),
                const SizedBox(height: 20),
                Text(name),
                const SizedBox(height: 10),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: f.format(price),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  const TextSpan(
                      text: ' YAB', style: TextStyle(color: Colors.grey))
                ]))
              ],
            ),
          ),
          preferredSize: Size.fromHeight(Get.size.height / 4),
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Card(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                            '\u{26A0} 상품 가격은 YAB 가격 변동에 따라 바뀔 수 있습니다.',
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  detail,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    height: 2.0,
                                  ),
                                )),
                          ],
                        )
                      ],
                    ))),
            Card(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(5),
                                child: const Text('\u{1F6A8} 중요안내',
                                    textAlign: TextAlign.start)),
                            Container(
                                padding:
                                    const EdgeInsets.only(left: 20, bottom: 20),
                                child: const Text(
                                    '- 상품 구입 후 유효기간은 30일입니다.\n- 상품 구입 후 취소/교환/환불은 불가능합니다\n- 모바일 쿠폰 사용에 대한 문의는 발행처에 문의해주세요(기프티쇼 고객센터 1588-0108)',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 10,
                                      height: 2.0,
                                    ))),
                          ],
                        )
                      ],
                    ))),
            Container(
                padding: const EdgeInsets.only(bottom: 15),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      pointCheck(name, price);
                    },
                    child: const Text('구매하기'))),
            // Container(
            //     padding: const EdgeInsets.only(bottom: 15),
            //     width: double.infinity,
            //     child: ElevatedButton(
            //         onPressed: () {
            //           ShopController.to.shopCancel();
            //         },
            //         child: const Text('테스트용취소'))),
          ],
        ),
      )),
    );
  }
}
