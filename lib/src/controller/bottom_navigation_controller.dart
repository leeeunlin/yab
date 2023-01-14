import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: constant_identifier_names
enum PageName { HOME, MAP, EVENT, SHOP, SEARCH, MYPAGE }

class BottomNavigationController extends GetxController {
  static BottomNavigationController get to => Get.find();

  RxInt pageIndex = 0.obs; // 네비게이션바의 페이지 번호
  GlobalKey<NavigatorState> searchPageNaviationKey =
      GlobalKey<NavigatorState>();
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.HOME:
      case PageName.MAP: // 게시판으로 변경필요
      case PageName.EVENT:
      case PageName.SHOP:
      case PageName.SEARCH:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void offAllPage(int value) {
    pageIndex(value);
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
    }
  }

  Future<bool> willPopAction() async {
    bool exitFlag = false;
    await Get.defaultDialog(
      titlePadding: const EdgeInsets.all(20),
      titleStyle: const TextStyle(fontSize: 17),
      title: 'YAB 종료',
      middleText: '"예" 버튼을 누르면 YAB이 종료됩니다.',
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.black.withOpacity(0),
                shadowColor: Colors.black.withOpacity(0)),
            onPressed: () async {
              Get.back(); // 팝업창 닫기
              exitFlag = false; // false면 앱 종료 안함
            },
            child: const Text('아니오')),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.black.withOpacity(0),
                shadowColor: Colors.black.withOpacity(0)),
            onPressed: () async {
              Get.back(); // 팝업창 닫기
              exitFlag = true; // true면 앱이 종료
            },
            child: const Text('예')),
      ],
    );
    return exitFlag;
  }
}
