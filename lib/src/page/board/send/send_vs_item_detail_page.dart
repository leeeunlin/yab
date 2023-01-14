import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/app.dart';
import 'package:yab_v2/src/controller/send_board_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';
import 'package:yab_v2/src/size_config.dart';
import 'package:yab_v2/src/utils/data_keys.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SendVSItemDetailPage extends GetView<SendBoardController> {
  const SendVSItemDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = int.parse(Get.parameters['index']!); // 파라미터 index값을 가져온다.

    num selectTimeComparison = num.parse(DateFormat('yyyyMMddkkmm').format(
        DateTime.parse(
            controller.sendItemListdata[index].reservationDate.toString())));
    num todayTimeComparison =
        num.parse(DateFormat('yyyyMMddkkmm').format(DateTime.now()));

    void nextPageA() async {
      // bool refundCheck = await controller
      //     .getRefundCheck(controller.sendItemListdata[index].detectorKey!);
      // if (refundCheck == true) {
      //   Get.snackbar('게시 종료 안내', '게시물이 게시종료되어 다시 보낼 수 없습니다.');
      //   return;
      // }
      if (controller.sendItemListdata[index].selectUserModel!
              .toJson()[FIELD_A]
              .length ==
          0) {
        Get.snackbar('답변자수 부족', '답변자수가 없어 보낼 수 없습니다.');
        return;
      }

      UserInfoDetectorController.to
          .detectorControllerInit(); // 버튼을 누르게 되면 detector가 초기화 됨
      await UserInfoDetectorController.to
          .reDetector(controller.sendItemListdata[index].selectUserModel!.A!);
      UserInfoDetectorController.to
          .setReGenderSelected(controller.sendItemListdata[index].gender!);
      UserInfoDetectorController.to.setReNationalitySelected(
          controller.sendItemListdata[index].nationality!);
      UserInfoDetectorController.to.setReMaritalStatusSelected(
          controller.sendItemListdata[index].maritalstatus!);
      UserInfoDetectorController.to
          .setReChildrenSelected(controller.sendItemListdata[index].children!);
      UserInfoDetectorController.to.setModeSelected(DATA_PROMOTION);
      await Get.toNamed('/SelectWriteModePage');
    }

    void nextPageB() async {
      // bool refundCheck = await controller
      //     .getRefundCheck(controller.sendItemListdata[index].detectorKey!);
      // if (refundCheck == true) {
      //   Get.snackbar('게시 종료 안내', '게시물이 게시종료되어 다시 보낼 수 없습니다.');
      //   return;
      // }
      if (controller.sendItemListdata[index].selectUserModel!
              .toJson()[FIELD_B]
              .length ==
          0) {
        Get.snackbar('답변자수 부족', '답변자수가 없어 보낼 수 없습니다.');
        return;
      }

      UserInfoDetectorController.to
          .detectorControllerInit(); // 버튼을 누르게 되면 detector가 초기화 됨
      await UserInfoDetectorController.to
          .reDetector(controller.sendItemListdata[index].selectUserModel!.B!);

      UserInfoDetectorController.to
          .setReGenderSelected(controller.sendItemListdata[index].gender!);
      UserInfoDetectorController.to.setReNationalitySelected(
          controller.sendItemListdata[index].nationality!);
      UserInfoDetectorController.to.setReMaritalStatusSelected(
          controller.sendItemListdata[index].maritalstatus!);
      UserInfoDetectorController.to
          .setReChildrenSelected(controller.sendItemListdata[index].children!);

      await Get.toNamed('/SelectWriteModePage');
    }

    int allAnswerCount() {
      return (controller.sendItemListdata[index].selectUserModel!
                  .toJson()[FIELD_A])
              .length +
          (controller.sendItemListdata[index].selectUserModel!
                  .toJson()[FIELD_B])
              .length;
    }

    Container detectorResultContainer(String title, String value) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black12, width: 2)),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5),
        width: Get.size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Get.theme.textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(value),
            )
          ],
        ),
      );
    }

    SizedBox buttonSizedBox(
        int sendItemListdata, String field_, String nextPage_) {
      return SizedBox(
        height: Get.size.height / 5,
        width: Get.size.width / 2.2,
        child: ElevatedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.size.height / 8,
                child: AutoSizeText(
                  controller.sendItemListdata[index].detail![sendItemListdata],
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                    '${(controller.sendItemListdata[index].selectUserModel!.toJson()[field_]).length.toString()} 명 답변'),
              )
            ],
          ),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              )),
          onPressed: () {
            if (nextPage_ == 'A') {
              nextPageA();
            }
            if (nextPage_ == 'B') {
              nextPageB();
            }
          },
        ),
      );
    }

    void cancelReservationDialog() async {
      await Get.defaultDialog(
        titlePadding: const EdgeInsets.all(20),
        titleStyle: const TextStyle(fontSize: 17),
        title: '예약 게시물 취소',
        middleText: '예약 게시물을\n 취소하시겠습니까?',
        actions: [
          Obx(
            () => controller.cancelReservationLoading.value == true
                ? Container()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.black.withOpacity(0),
                        shadowColor: Colors.black.withOpacity(0)),
                    onPressed: () async {
                      Get.back(); // 팝업창 닫기
                    },
                    child: const Text('아니오')),
          ),
          Obx(
            () => controller.cancelReservationLoading.value == true
                ? const Center(child: RefreshProgressIndicator())
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        backgroundColor: Colors.black.withOpacity(0),
                        shadowColor: Colors.black.withOpacity(0)),
                    onPressed: () async {
                      String taskId =
                          controller.sendItemListdata[index].reservationId!;
                      String userKey =
                          controller.sendItemListdata[index].userKey!;
                      String boardId =
                          controller.sendItemListdata[index].detectorKey!;
                      controller.cancelReservationLoading.value = true;
                      final HttpsCallableResult result =
                          await FirebaseFunctions.instanceFor(
                                  region: 'asia-northeast3')
                              .httpsCallable('reservationCancel')
                              .call(<String, dynamic>{
                        'taskId': taskId,
                        'userKey': userKey,
                        'boardId': boardId
                      });
                      if (result.data == RETURN_SUCCESS) {
                        UserController.to.updatePlusCoin(controller
                            .sendItemListdata[index]
                            .fullPrice!); // 취소 성공이므로 컨트롤러의 코인값을 올려줌
                        await controller.reload();
                        Get.offAll(const App());
                        Get.snackbar('예약 취소 완료.', '예약 취소를 완료하였습니다.');
                      } else {
                        Get.back();
                        Get.snackbar('예약 취소 실패.', '예약 취소를 실패하였습니다.');
                      }
                    },
                    child: const Text('예')),
          )
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('밸런스 게임'),
          ), // 게시글 제목
          body: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Obx(
              () => ListView(
                children: <Widget>[
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: Text(
                                  controller.sendItemListdata[index].title!,
                                  style: Get.theme.textTheme.titleLarge,
                                  textAlign: TextAlign.start,
                                )),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buttonSizedBox(0, FIELD_A, 'A'),
                                buttonSizedBox(1, FIELD_B, 'B')
                              ],
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('결과',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  detectorResultContainer('대상자',
                                      '${controller.sendItemListdata[index].users!.length} 명'),
                                  detectorResultContainer(
                                      '참여인원', '${allAnswerCount()} 명'),
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    width: double.infinity,
                                    child: Text(
                                        selectTimeComparison <
                                                todayTimeComparison
                                            ? controller.sendItemListdata[index]
                                                        .users!.length ==
                                                    allAnswerCount()
                                                ? '모든 답변이 완료되었습니다.'
                                                : '진행중인 설문 입니다.'
                                            : '예약 게시글 입니다.',
                                        textAlign: TextAlign.center),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                        selectTimeComparison <
                                                todayTimeComparison
                                            ? '답변자에게 재 질문을 원하시면 버튼을 선택 해주세요'
                                            : '${DateFormat('yyyy-MM-dd kk:mm').format(DateTime.parse(controller.sendItemListdata[index].reservationDate.toString()))} 에 게시가 시작됩니다.',
                                        textAlign: TextAlign.center),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    width: double.infinity,
                                    child: selectTimeComparison <
                                            todayTimeComparison
                                        ? ElevatedButton(
                                            onPressed: () async {
                                              controller.repeatWrite.value =
                                                  true;
                                              UserInfoDetectorController.to
                                                  .modeChangePaymentInit();
                                              UserInfoDetectorController.to
                                                  .setModeSelected(controller
                                                      .sendItemListdata[index]
                                                      .mode!);

                                              UserInfoDetectorController
                                                      .to.vsTitle.text =
                                                  controller
                                                      .sendItemListdata[index]
                                                      .title
                                                      .toString();
                                              UserInfoDetectorController
                                                      .to.vsADetail.text =
                                                  controller
                                                      .sendItemListdata[index]
                                                      .detail!
                                                      .elementAt(0);
                                              UserInfoDetectorController
                                                      .to.vsBDetail.text =
                                                  controller
                                                      .sendItemListdata[index]
                                                      .detail!
                                                      .elementAt(1);

                                              await Get.toNamed(
                                                  '/DetectorMainPage');
                                            },
                                            child: const Text('게시글 다시 보내기'),
                                          )
                                        : ElevatedButton(
                                            onPressed: () async {
                                              if (controller
                                                      .sendItemListdata[index]
                                                      .reservationId !=
                                                  '') {
                                                cancelReservationDialog();
                                                controller
                                                    .cancelReservationLoading
                                                    .value = false;
                                              } else {
                                                Get.snackbar('예약 전송 완료',
                                                    '이미 전송이 완료된 게시물입니다.\n새로고침을 해주시기 바랍니다.');
                                              }
                                            },
                                            child: const Text('예약 취소'),
                                          ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
