import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/app.dart';
import 'package:yab_v2/src/controller/point_report_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/page/my/userinfo/user_point_report_widget.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/size_config.dart';

class UserPointReport extends GetView<PointReportController> {
  const UserPointReport({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###');
    return Scaffold(
      appBar: AppBar(
        title: const Text('YAB 사용 내역'),
        leading: IconButton(
            onPressed: () {
              Get.offAll(const App());
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Obx(
        () => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.blueGrey,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      '사용 가능 YAB',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(24),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: double.infinity,
                    child: Text(
                      '${f.format(UserController.to.userModel.value.coin!.floor())} YAB',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white),
                                onPressed: () async {
                                  await Get.toNamed('QRCodeScanPage');
                                },
                                child: const Text('YAB 보내기')),
                          ),
                          SizedBox(
                            height: 40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white),
                                onPressed: () async {
                                  if (UserController
                                          .to.userModel.value.premiumUser ==
                                      true) {
                                    await Get.toNamed('QRCodePage');
                                  } else {
                                    detectorDialog();
                                  }
                                },
                                child: const Text('YAB 받기')),
                          )
                        ],
                      ))
                ],
              ),
            ),
            // 차후 이 부분에 포인트 사용관련 검색 필터 생성 필요

            Expanded(
              // issues: #49 Pull Down RefreshIndicator 적용 - ellee
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.reload();
                },
                child: ListView.separated(
                  controller: controller.scrollController.value,
                  itemBuilder: (_, index) {
                    if (index < controller.pointReportItemListdata.length) {
                      return UserPointReportWidget(index);
                    }
                    if (controller.hasMore.value ||
                        controller.isLoading.value) {
                      return const Center(child: RefreshProgressIndicator());
                    }
                    return Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Column(
                          children: [
                            const Text('더 이상 사용내역이 없어요'),
                            IconButton(
                              onPressed: () {
                                controller.reload();
                              },
                              icon: const Icon(Icons.refresh_outlined),
                            ),
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
                  itemCount: controller.pointReportItemListdata.length + 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void detectorDialog() async {
    await Get.defaultDialog(
      title: '상점등록 유저 전용',
      middleText: 'YAB 받기 기능은 상점등록 유저 전용 입니다.\n\n유저 등록을 진행 하시겠습니까?',
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
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.black.withOpacity(0),
                shadowColor: Colors.black.withOpacity(0)),
            onPressed: () {
              Get.back(); // 팝업창 닫기
              _sendEmail();
            },
            child: const Text('예')),
      ],
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
      detectorEmailDialog(title, message);
    }
  }

  void detectorEmailDialog(String title, String message) async {
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
