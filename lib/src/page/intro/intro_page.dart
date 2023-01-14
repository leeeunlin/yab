import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yab_v2/src/controller/preferences_controller.dart';
import 'package:yab_v2/src/root.dart';

class IntroPage extends GetView<PreferencesController> {
  const IntroPage({Key? key}) : super(key: key);

  PageViewModel pageViewModel(String imgsrc) {
    return PageViewModel(
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.size.height / 25,
          ),
          Image.asset(imgsrc),
        ],
      ),
      body: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.firstStart(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          // Preferencesrepository에서 firstStart 확인 값이 true 일 경우 페이지 생성 없으면 root페이지 이동
          return IntroductionScreen(
            pages: [
              pageViewModel('assets/images/logo/intro_1.png'),
              pageViewModel('assets/images/logo/intro_2.png'),
              pageViewModel('assets/images/logo/intro_3.png'),
              pageViewModel('assets/images/logo/intro_4.png'),
              pageViewModel('assets/images/logo/intro_5.png'),
              pageViewModel('assets/images/logo/intro_6.png'),
            ],
            showSkipButton: true,
            skip: const Icon(Icons.skip_next),
            next: const Icon(Icons.arrow_forward),
            done: const Text("시작하기"),
            onDone: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool(
                  'firstStart', false); // firstStart 값 false로 지정 후 root페이지로 이동
              await Get.to(() => const Root());
            },
            onSkip: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool(
                  'firstStart', false); // firstStart 값 false로 지정 후 root페이지로 이동
              await Get.to(() => const Root());
            },
            dotsDecorator: const DotsDecorator(
                size: Size(10, 10),
                spacing: EdgeInsets.all(2),
                activeSize: Size(22, 10),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)))),
          );
        } else {
          return const Root();
        }
      },
    );
  }
}
