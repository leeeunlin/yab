import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yab_v2/src/controller/event_controller.dart';
import 'package:yab_v2/src/page/event/attendance_check_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class EventPage extends GetView<EventController> {
  const EventPage({Key? key}) : super(key: key);

  Container subTitle(String title) {
    return Container(
        color: Colors.black12,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Text(title, style: Get.theme.textTheme.subtitle1));
  }

  InkWell progressEventList(String path, Widget page) {
    return InkWell(
      onTap: () async {
        await Get.to(() => page);
      },
      child: Center(
        child: Image.asset(
          path,
          width: double.infinity,
        ),
      ),
    );
  }

  InkWell endEventList(String path, Widget page) {
    return InkWell(
      onTap: () async {
        await Get.to(() => page);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(path, fit: BoxFit.cover),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.progressEvent.value = true;

    BannerAd banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {},
        onAdLoaded: (_) {},
      ),
      size: AdSize.banner,
      adUnitId: kReleaseMode
          ? GetPlatform.isIOS
              ? 'ca-app-pub-2175953775265407/6197485299'
              : 'ca-app-pub-2175953775265407/9102850239'
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
        title: const Text(
          '이벤트',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: [
                subTitle('\u{1F4CC} 공지사항'),
                InkWell(
                  onTap: () {
                    _sendEmail();
                  },
                  child: SizedBox(
                      width: double.infinity,
                      child: Image.asset('assets/images/event/1.png')),
                ),
                const Divider(height: 3, color: Colors.grey, thickness: 2),
                Center(
                  child: Image.asset(
                    'assets/images/event/2.png',
                    width: double.infinity,
                  ),
                ),
                subTitle('\u{1F389} 진행중 이벤트 \u{1F38A} (1)'),
                progressEventList(
                    'assets/images/event/3.png', const AttendanceCheckWidget()),
                subTitle('\u{1F389} 종료된 이벤트 \u{1F38A} (0)'),
              ],
            )),
          ),
          SizedBox(
            width: banner.size.width.toDouble(),
            height: banner.size.height.toDouble(),
            child: AdWidget(ad: banner),
          ),
        ],
      ),
    );
  }

  void _sendEmail() async {
    final Email email = Email(
      body:
          '- 성함:\n\n- 사업자 등록번호:\n\n\n\n사업자등록증 사진을 함께 첨부하여 메일로 보내주세요.\n\n공휴일 제외한 72시간 이내 보내주신 이메일 주소로 회신드리겠습니다.',
      subject: '[광고주 가입문의]',
      recipients: ['sales@selldy.co.kr'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );
    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      String title = '기본 메일 앱을 사용할 수 없습니다.';
      String message = '아래 이메일로 연락주시면 답변드리겠습니다.\nsales@selldy.co.kr';
      detectorDialog(title, message);
    }
  }

  void detectorDialog(String title, String message) async {
    await Get.defaultDialog(
      title: title,
      middleText: message,
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.black.withOpacity(0),
                shadowColor: Colors.black.withOpacity(0)),
            onPressed: () {
              Get.back(); // 팝업창 닫기
            },
            child: const Text('닫기')),
      ],
    );
  }
}
