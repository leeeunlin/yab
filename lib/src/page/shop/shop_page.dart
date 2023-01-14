import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/page/shop/shop_controller.dart';
import 'package:yab_v2/src/page/shop/shop_detail_model.dart';
import 'package:yab_v2/src/page/shop/shop_listpage.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/page/shop/shop_report_page.dart';

class ShopPage extends GetView<UserController> {
  const ShopPage({Key? key}) : super(key: key);

  InkWell shopItem(ShopDetailModel shopModel) {
    var f = NumberFormat('###,###,###,###'); // 숫자 자르기
    return InkWell(
      onTap: () async {
        await Get.to(() => ShopListPage(
            shopModel.goodsName.toString(),
            shopModel.goodsImgS.toString(),
            shopModel.realPrice == null
                ? 0
                : num.parse(shopModel.realPrice.toString()),
            shopModel.content.toString(),
            shopModel.goodsCode.toString()));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1))),
        child: Row(
          children: [
            Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(shopModel.goodsImgS.toString())))),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: AutoSizeText(
                      '[${shopModel.brandName}]\n${shopModel.goodsName.toString()}',
                      style: Get.theme.textTheme.subtitle1,
                      minFontSize: 1,
                    ),
                  ),
                  SizedBox(
                    child: AutoSizeText(
                      shopModel.realPrice == null
                          ? '0'
                          : '${f.format(shopModel.realPrice)} YAB',
                      style: Get.theme.textTheme.subtitle1,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    BannerAd banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {},
        onAdLoaded: (_) {},
      ),
      size: AdSize.banner,
      adUnitId: kReleaseMode
          ? GetPlatform.isIOS
              ? 'ca-app-pub-2175953775265407/8979275892'
              : 'ca-app-pub-2175953775265407/7757978979'
          : GetPlatform.isIOS
              ? 'ca-app-pub-3940256099942544/6300978111'
              : 'ca-app-pub-3940256099942544/6300978111',
      request: const AdRequest(),
    )..load();

    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          centerTitle:
              false, // android : default값은 왼쪽 정렬 / IOS : default값은 가운데 정렬
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('상점'),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      backgroundColor: Colors.black.withOpacity(0),
                      shadowColor: Colors.black.withOpacity(0)),
                  onPressed: () async {
                    ShopController.to.reload();
                    await Get.to(() => const ShopReportPage());
                  },
                  child: const Text('구매내역',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)))
            ],
          )),
      body: SafeArea(
        child: Column(
          // alignment: Alignment.bottomCenter,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: [
                      // issues: #56 상점 API 정보 (항목 추가부분)
                      shopItem(ShopController.to.starbucksDetailModel.value),
                      shopItem(ShopController.to.bananamilkModel.value),
                      shopItem(ShopController.to.chickenModel.value),
                      shopItem(ShopController.to.hamburgerModel.value),
                      shopItem(ShopController.to.icecreamModel.value),
                      shopItem(ShopController.to.donutModel.value),
                      shopItem(ShopController.to.movieModel.value),

                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: const Text('상품은 점점 더 늘어날 예정입니다.'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: banner.size.width.toDouble(),
              height: banner.size.height.toDouble(),
              child: AdWidget(ad: banner),
            ),
          ],
        ),
      ),
    );
  }
}
