import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/bottom_navigation_controller.dart';
import 'package:yab_v2/src/controller/receive_board_controller.dart';
import 'package:yab_v2/src/controller/send_board_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';

class TradeListWidget extends StatelessWidget {
  const TradeListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            spreadRadius: 1.0,
            offset: Offset(
              2,
              2,
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text(' 도착한 소식', style: Get.theme.textTheme.titleMedium),
          ),
          Obx(
            () => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tradeListGrid(
                      '받은 소식',
                      ReceiveBoardController.to.receiveViewCount.value,
                      const Icon(
                        Icons.chat_outlined,
                        size: 30,
                      ),
                      '/ReceiveItemListPage'),
                  tradeListGrid(
                      '작성한 글',
                      0,
                      // '${SendBoardController.to.sendItemList.length}',
                      const Icon(Icons.send_outlined, size: 30),
                      '/SendItemListPage'),
                  tradeListGrid(
                      '내 정보',
                      UserController.to.totalCount.value,
                      // '${SendBoardController.to.sendItemList.length}',
                      const Icon(Icons.badge_outlined, size: 30),
                      '/UserInfoPage'),
                  // !GetPlatform.isAndroid
                  //     ? Container()
                  //     : tradeListGrid(
                  //         '상점',
                  //         0,
                  //         const Icon(Icons.shopping_cart_outlined, size: 30),
                  //         '/ShopPage'),
                  tradeListGrid(
                      '상점',
                      0,
                      const Icon(Icons.shopping_cart_outlined, size: 30),
                      '/ShopPage'),
                  // tradeListGrid(
                  //     '내정보 거래내역', '1/10', const Icon(Icons.chat_outlined), ''),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded tradeListGrid(String title, int count, Icon icons, String path) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          if (path == '/ReceiveItemListPage') {
            ReceiveBoardController.to.reload();
            await Get.toNamed(path);
          } else if (path == '/SendItemListPage') {
            SendBoardController.to.reload();
            await Get.toNamed(path);
          } else if (path == '/UserInfoPage') {
            await Get.toNamed(path);
          } else if (path == '/ShopPage') {
            BottomNavigationController.to.offAllPage(2);
          }
        },
        child: SizedBox(
          child: Column(
            children: [
              Badge(
                  position: BadgePosition.topEnd(top: 0, end: 0),
                  showBadge: count == 0 ? false : true,
                  badgeContent: Text(count.toString(),
                      style: const TextStyle(color: Colors.white)),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: icons,
                  )),
              AutoSizeText(
                title,
                maxLines: 1,
                style: Get.theme.textTheme.subtitle1,
                minFontSize: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
