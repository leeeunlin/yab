import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/app.dart';
import 'package:yab_v2/src/controller/send_board_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/size_config.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class SendItemWidget extends GetView<SendBoardController> {
  const SendItemWidget(this.index, {Key? key}) : super(key: key);

  final int? index;

  @override
  Widget build(BuildContext context) {
    String totalPrice() {
      num price = controller.sendItemListdata[index!].price!;
      int totalCount = controller.sendItemListdata[index!].users!.length;
      String value = (totalCount * price.toInt()).toString();
      return value;
    }

    void ontapEvent() async {
      String mode = controller.sendItemListdata[index!].mode!;

      // 모드 확인을 하여 지정된 라우터페이지로 보내준다.
      if (mode == DATA_VS) {
        await Get.toNamed(
            '/SendVSItemDetailPage/${controller.sendItemListdata[index!].detectorKey}?index=$index');
      } else if (mode == DATA_MULTIPLE) {
        await Get.toNamed(
            '/SendMultiItemDetailPage/${controller.sendItemListdata[index!].detectorKey}?index=$index');
      } else if (mode == DATA_PROMOTION) {
        controller.sendInit();
        await Get.toNamed(
            '/SendPromotionItemDetailPage/${controller.sendItemListdata[index!].detectorKey}?index=$index');
      }
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
                          controller.sendItemListdata[index!].reservationId!;
                      String userKey =
                          controller.sendItemListdata[index!].userKey!;
                      String boardId =
                          controller.sendItemListdata[index!].detectorKey!;
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
                            .sendItemListdata[index!]
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

    return InkWell(
      onTap: () async {
        ontapEvent();
      },
      child: FutureBuilder<bool?>(
        future: controller.getSendItemRefundCheck(
            controller.sendItemListdata[index!].detectorKey!),
        builder: (context, snapshot) {
          String refund;
          if (snapshot.data == true) {
            refund = "지급 완료";
          } else {
            refund = "";
          }
          return Container(
            height: Get.size.height / 8,
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(15),
                ),
                if (controller
                    .sendItemListdata[index!].imageDownloadUrls!.isNotEmpty)
                  SizedBox(
                    height: Get.size.height / 3.5,
                    width: Get.size.width / 6.5,
                    child: ExtendedImage.network(
                      controller.sendItemListdata[index!].imageDownloadUrls![0],
                      fit: BoxFit.cover,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                if (controller.sendItemListdata[index!].mode! ==
                        DATA_PROMOTION &&
                    controller
                        .sendItemListdata[index!].imageDownloadUrls!.isEmpty)
                  SizedBox(
                      height: Get.size.height / 3.5,
                      width: Get.size.width / 6.5,
                      child: const Icon(Icons.image,
                          size: 50, color: Colors.grey)),
                if (controller.sendItemListdata[index!].mode! == DATA_MULTIPLE)
                  SizedBox(
                      height: Get.size.height / 3.5,
                      width: Get.size.width / 6.5,
                      child: const Icon(
                        Icons.checklist_rounded,
                        size: 50,
                        color: Colors.deepPurpleAccent,
                      )),

                if (controller.sendItemListdata[index!].mode! == DATA_VS)
                  SizedBox(
                    height: Get.size.height / 3.5,
                    width: Get.size.width / 6.5,
                    child: const Icon(Icons.flaky,
                        size: 50, color: Colors.deepPurpleAccent),
                  ),
                const SizedBox(), // 사진 파일이 없을 시 빈 sizedbox를 보여줌
                SizedBox(
                  width: getProportionateScreenWidth(15),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        controller.sendItemListdata[index!]
                            .title!, // 서버에서 가져온 searchmodel 제목 데이터
                        style: Get.theme.textTheme.subtitle1,
                        overflow: TextOverflow
                            .fade, // 서버에서 가져온 제목 데이터값이 길면 픽셀에러가 발생 해결을 위해 오버플로우시 한줄로 만들어 패이드 시켜 해결
                        maxLines: 1,
                        softWrap: false,
                      ),
                      controller.expiredTimeInfo(index!)
                          ? Text('게시기간 종료 - $refund',
                              style: Get.theme.textTheme.subtitle2)
                          : Text(
                              DateFormat("yyyy-MM-dd HH:mm").format(controller
                                  .sendItemListdata[index!]
                                  .createdDate!), // 서버에서 가져온 searchmodel 시간 데이터
                              style: Get.theme.textTheme.subtitle2,
                            ),
                      Text(
                          '${totalPrice()} YAB'), // 서버에서 가져온 searchmodel 가격 데이터
                      Text(
                        modeMapEngToKor[controller.sendItemListdata[index!]
                            .mode]!, // 서버에서 가져온 searchmodel 모드 데이터
                        style: Get.theme.textTheme.subtitle2,
                      ),
                      if (controller.sendItemListdata[index!].users!.length ==
                          controller.allAnswerCount(index!))
                        const Text('모든 답변이 완료되었습니다.'),
                      if (controller.sendItemListdata[index!].users!.length !=
                          controller.allAnswerCount(index!))
                        Text(
                            '${controller.sendItemListdata[index!].counter!.toString()} 명 중 ${controller.allAnswerCount(index!).toString()}명 답변'),
                    ],
                  ),
                ),
                // 1. reservationDate값이 ""이면 예약을 하지 않았다는 의미
                // 2. 취소하는 함수는 cloud function에 있음
                // 3. detectormodel에 reservationKey값을 생성해야할 듯 - 완료
                // 4. http 통신이므로 인디케이터가 필요할 듯
                // 5. 1. 예약 시간으로 삼항식을 작성해야할 듯 아니면
                //    2. cloud function에서 예약 시간에 보내고 해당 user => sendBoard의 reservationDate를 ""로 변경하여 버튼을 비활성화 시키는 방법
                if (controller.sendItemListdata[index!].reservationId != '')
                  TextButton(
                    onPressed: () async {
                      if (controller.sendItemListdata[index!].reservationId !=
                          '') {
                        cancelReservationDialog();
                        controller.cancelReservationLoading.value = false;
                      } else {
                        Get.snackbar(
                            '예약 전송 완료', '이미 전송이 완료된 게시물입니다.\n새로고침을 해주시기 바랍니다.');
                      }
                    },
                    child: const Text('예약 취소'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// 모드를 변경하는 맵핑 데이터
const Map<String, String> modeMapEngToKor = {
  'vs': '밸런스 게임',
  'multiple': '다중 항목 게시물',
  'promotion': '일반 게시물'
};
