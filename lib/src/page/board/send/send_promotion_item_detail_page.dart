import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:yab_v2/src/app.dart';
import 'package:yab_v2/src/controller/send_board_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';
import 'package:yab_v2/src/page/board/send/send_image_list_page.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class SendPromotionItemDetailPage extends GetView<SendBoardController> {
  const SendPromotionItemDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int index = int.parse(Get.parameters['index']!); // 파라미터 index값을 가져온다.
    num selectTimeComparison = num.parse(DateFormat('yyyyMMddkkmm').format(
        DateTime.parse(
            controller.sendItemListdata[index].reservationDate.toString())));
    num todayTimeComparison =
        num.parse(DateFormat('yyyyMMddkkmm').format(DateTime.now()));

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('일반 게시물'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (controller
                .sendItemListdata[index].imageDownloadUrls!.isNotEmpty)
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  InkWell(
                    onTap: () async {
                      // 하단 숫자 표시를 선택 시 전체화면 페이지와 동기화
                      controller.imageFullListNum.value =
                          controller.imageListNum.value;
                      await Get.to(() => SendImageListPage());
                    },
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: Get.size.height / 2,
                      child: PhotoViewGallery.builder(
                        scrollPhysics: const BouncingScrollPhysics(),
                        builder: (BuildContext context, int imageIndex) {
                          return PhotoViewGalleryPageOptions(
                            imageProvider: NetworkImage(
                              controller.sendItemListdata[index]
                                  .imageDownloadUrls![imageIndex],
                            ),
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: PhotoViewComputedScale.covered * 2,
                          );
                        },
                        pageController: controller.pageController.value,
                        itemCount: controller
                            .sendItemListdata[index].imageDownloadUrls!.length,
                        onPageChanged: (int index) {
                          // index 는 0 부터 시작이므로 유저에게 표시하는 index 는 +1 한다
                          controller.imageListNum.value = index + 1;
                          // 페이지를 넘길때 첫 사진을 보고 있던 사진부터 확대하여 시작한다.
                          controller.pageController.value =
                              PageController(initialPage: index);
                        },
                        loadingBuilder: ((context, event) => Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  value: event == null
                                      ? 0
                                      : event.cumulativeBytesLoaded /
                                          event.expectedTotalBytes!.toInt(),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(20)),
                    child: Obx(
                      () => Text(
                        '${controller.imageListNum.value} / ${controller.sendItemListdata[index].imageDownloadUrls!.length}',
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                controller.sendItemListdata[index].title!,
                style: Get.theme.textTheme.titleLarge,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Text(
                controller.sendItemListdata[index].detail![0],
                style: Get.theme.textTheme.bodyText1,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Text(
                  selectTimeComparison < todayTimeComparison
                      ? ''
                      : '예약 게시글 입니다.',
                  textAlign: TextAlign.center),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                  selectTimeComparison < todayTimeComparison
                      ? ''
                      : '${DateFormat('yyyy-MM-dd kk:mm').format(DateTime.parse(controller.sendItemListdata[index].reservationDate.toString()))} 에 게시가 시작됩니다.',
                  textAlign: TextAlign.center),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: selectTimeComparison < todayTimeComparison
                  ? ElevatedButton(
                      onPressed: () async {
                        controller.repeatWrite.value = true;
                        UserInfoDetectorController.to.modeChangePaymentInit();
                        UserInfoDetectorController.to.setModeSelected(
                            controller.sendItemListdata[index].mode!);
                        //issues: #43 다시보내기 버튼을 클릭 할 경우 네트워크에서 바이트값을 가져올 수 있는 코드 - ellee
                        if (controller.sendItemListdata[index]
                            .imageDownloadUrls!.isNotEmpty) {
                          for (int i = 0;
                              i <
                                  controller.sendItemListdata[index]
                                      .imageDownloadUrls!.length;
                              i++) {
                            controller.readNetworkImage(controller
                                .sendItemListdata[index].imageDownloadUrls![i]);
                          }
                        }
                        UserInfoDetectorController.to.promotionTitle.text =
                            controller.sendItemListdata[index].title.toString();
                        UserInfoDetectorController.to.promotionDetail.text =
                            controller.sendItemListdata[index].detail!
                                .elementAt(0);
                        await Get.toNamed('/DetectorMainPage');
                      },
                      child: const Text('게시글 다시 보내기'))
                  : ElevatedButton(
                      onPressed: () async {
                        if (controller.sendItemListdata[index].reservationId !=
                            '') {
                          cancelReservationDialog();
                          controller.cancelReservationLoading.value = false;
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
    );
  }
}
