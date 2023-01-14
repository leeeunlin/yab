import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';
import 'package:yab_v2/src/controller/bottom_navigation_controller.dart';
import 'package:yab_v2/src/page/detector/detector_main_page.dart';
import 'package:yab_v2/src/page/home/home_page.dart';
import 'package:yab_v2/src/page/my/my_page.dart';
import 'package:yab_v2/src/page/event/event_page.dart';
import 'package:yab_v2/src/page/shop/shop_page.dart';

class App extends GetView<BottomNavigationController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appcastURL =
        'https://raw.githubusercontent.com/guksm0723/YAB_V2_Version/main/version.xml';
    final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);

    return UpgradeAlert(
      upgrader: Upgrader(
        countryCode: "KR",
        appcastConfig: cfg,
        debugLogging: true,
        showIgnore: false, // Notice My Ignore 버튼 제거
        showLater: false, // Notice 나중에 버튼 제거
        showReleaseNotes: false, // Notice ReleaseNote 제거
        durationUntilAlertAgain:
            const Duration(seconds: 5), // 시간에 한번씩 체크할것인가 5초마다 한번 체크
        //debugDisplayAlways: true, // 항상 업그레이드를 사용할 수 있도록 강제함
      ),
      child: WillPopScope(
        child: Obx(
          () => Scaffold(
            body: IndexedStack(
              index: controller.pageIndex.value,
              // children: Platform.isAndroid
              //     ? const [
              //         HomePage(),
              //         EventPage(),
              //         ShopPage(),
              //         DetectorMainPage(),
              //         MyPage(),
              //       ]
              //     : const [
              //         HomePage(),
              //         EventPage(),
              //         DetectorMainPage(),
              //         MyPage(),
              //       ],
              children: const [
                HomePage(),
                EventPage(),
                ShopPage(),
                DetectorMainPage(),
                MyPage()
              ],
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.black38, width: 1))),
              child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  currentIndex: controller.pageIndex.value,
                  elevation: 0,
                  onTap: controller.changeBottomNav,
                  // items: Platform.isAndroid
                  //     ? const [
                  //         BottomNavigationBarItem(
                  //           icon: Icon(Icons.home_outlined),
                  //           activeIcon: Icon(Icons.home),
                  //           label: '홈',
                  //         ),
                  //         BottomNavigationBarItem(
                  //           icon: Icon(Icons.favorite_outline_outlined),
                  //           activeIcon: Icon(Icons.favorite),
                  //           label: '이벤트',
                  //         ),
                  //         BottomNavigationBarItem(
                  //           icon: Icon(Icons.shopping_cart_outlined),
                  //           activeIcon: Icon(Icons.shopping_cart),
                  //           label: '상점',
                  //         ),
                  //         BottomNavigationBarItem(
                  //           icon: Icon(Icons.edit_note_outlined),
                  //           activeIcon: Icon(Icons.edit_note),
                  //           label: '찾기',
                  //         ),
                  //         BottomNavigationBarItem(
                  //           icon: Icon(Icons.settings_outlined),
                  //           activeIcon: Icon(Icons.settings),
                  //           label: '설정',
                  //         ),
                  //       ]
                  //     : const [
                  //         BottomNavigationBarItem(
                  //           icon: Icon(Icons.home_outlined),
                  //           activeIcon: Icon(Icons.home),
                  //           label: '홈',
                  //         ),
                  //         BottomNavigationBarItem(
                  //           icon: Icon(Icons.favorite_outline_outlined),
                  //           activeIcon: Icon(Icons.favorite),
                  //           label: '이벤트',
                  //         ),
                  //         BottomNavigationBarItem(
                  //           icon: Icon(Icons.edit_note_outlined),
                  //           activeIcon: Icon(Icons.edit_note),
                  //           label: '찾기',
                  //         ),
                  //         BottomNavigationBarItem(
                  //           icon: Icon(Icons.settings_outlined),
                  //           activeIcon: Icon(Icons.settings),
                  //           label: '설정',
                  //         ),
                  //       ],
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      activeIcon: Icon(Icons.home),
                      label: '홈',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_outline_outlined),
                      activeIcon: Icon(Icons.favorite),
                      label: '이벤트',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart_outlined),
                      activeIcon: Icon(Icons.shopping_cart),
                      label: '상점',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.edit_note_outlined),
                      activeIcon: Icon(Icons.edit_note),
                      label: '찾기',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings_outlined),
                      activeIcon: Icon(Icons.settings),
                      label: '설정',
                    ),
                  ]),
            ),
          ),
        ),
        onWillPop: controller.willPopAction,
      ),
    );
  }
}
