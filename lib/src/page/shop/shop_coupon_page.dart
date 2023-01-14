import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:yab_v2/src/page/shop/shop_controller.dart';
import 'package:get/get.dart';

class ShopCouponPage extends GetView<ShopController> {
  const ShopCouponPage(this.index, {Key? key}) : super(key: key);

  final int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle:
            false, // android : default값은 왼쪽 정렬 / IOS : default값은 가운데 정렬
        title: const Text('쿠폰 사용하기'),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: PhotoView(
                imageProvider: NetworkImage(
                  controller.shopBuyListdata[index!].cuponImgUrl.toString(),
                ),
                backgroundDecoration: const BoxDecoration(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
