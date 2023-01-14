import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/controller/receive_board_controller.dart';
import 'package:yab_v2/src/size_config.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class ReceiveItemWidget extends GetView<ReceiveBoardController> {
  const ReceiveItemWidget(this.index, {Key? key}) : super(key: key);

  final int? index;
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");

    Dialog expDialog() {
      return const Dialog(
          child:
              SizedBox(height: 50, child: Center(child: Text('만료된 게시글 입니다.'))));
    }

    // expiredTimeInfo() 함수를 이용하여 만료를 구분할 수 있음
    // 만료가 되면 포인트지급을 하면 안됨.
    // 만료가 되면 색상도 변경해야 함.
    void ontapEvent() async {
      String mode = controller
          .receiveItemListdata[index!].mode!; // 받은 소식 목록에서 클릭했을 시 가져오는 아이템 모드
      bool viewCheck = controller
          .receiveItemListdata[index!].postView!; // 받은 소식 목록에서 클릭했을 시 가져오는 본 여부
      String detectorKey = controller.receiveItemListdata[index!]
          .detectorKey!; // 받은 소식 목록에서 클릭했을 시 가져오는 아이템 키값

      // 모드 확인을 하여 지정된 라우터페이지로 보내준다.
      if (mode == DATA_VS) {
        // VS 모드 일 때
        if (viewCheck == true) {
          // 게시물을 확인 했을 때 (postView가 true 일 때)
          controller.changeMultiBoolValue(
              await controller.getSelectItem(detectorKey));
        } else {
          // 게시물을 확인 했을 때 (postView가 false 일 때)
          controller.sendInit();
        }
        if (controller.expiredTimeInfo(index!) == false) {
          await Get.toNamed(
              '/ReceiveVSItemDetailPage/$detectorKey?index=$index');
        } else {
          Get.dialog(expDialog());
        }
        return;
      } else if (mode == DATA_MULTIPLE) {
        // 다중 선택 모드 일 때
        if (viewCheck == true) {
          // 게시물을 확인 했을 때 (postView가 true 일 때)
          controller.changeMultiBoolValue(
              await controller.getSelectItem(detectorKey));
        } else {
          // 게시물을 확인 했을 때 (postView가 false 일 때)
          controller.sendInit();
        }
        if (controller.expiredTimeInfo(index!) == false) {
          await Get.toNamed(
              '/ReceiveMultiItemDetailPage/$detectorKey?index=$index');
        } else {
          Get.dialog(expDialog());
        }
        return;
      } else if (mode == DATA_PROMOTION) {
        // 일반 게시물 모드 일 때
        controller.sendInit();
        await controller.setPromotionAnswerKey(detectorKey);

        if (viewCheck == false && controller.expiredTimeInfo(index!) == false) {
          // 게시물을 확인 했을 때 (postView가 false 일 때)
          // 게시물을 만료 기간이 지나지 않았을 때
          await controller.addpointAnswer(
            detectorKey,
            controller.receiveItemListdata[index!].secondPrice!,
          );
          controller.receiveItemListdata[index!].postView =
              true; // 컨트롤러의 postview값을 true로 변경하여 색을 변경 가능하게 함

        }
        if (controller.expiredTimeInfo(index!) == false) {
          await Get.toNamed(
              '/ReceivePromotionItemDetailPage/$detectorKey?index=$index');
        } else {
          Get.dialog(expDialog());
        }
        return;
      }
    }

    return Obx(() => InkWell(
          onTap: () async {
            ontapEvent();
          },
          child: Container(
            color: controller.receiveItemListdata[index!].postView! == false &&
                    !controller.expiredTimeInfo(index!)
                ? Colors.amber[100]
                : null,
            height: Get.size.height / 9,
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(15),
                ),
                if (controller
                    .receiveItemListdata[index!].imageDownloadUrls!.isNotEmpty)
                  SizedBox(
                    height: Get.size.height / 3.5,
                    width: Get.size.width / 6.5,
                    child: ExtendedImage.network(
                      controller
                          .receiveItemListdata[index!].imageDownloadUrls![0],
                      fit: BoxFit.cover,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                if (controller.receiveItemListdata[index!].mode! ==
                        DATA_PROMOTION &&
                    controller
                        .receiveItemListdata[index!].imageDownloadUrls!.isEmpty)
                  SizedBox(
                      height: Get.size.height / 3.5,
                      width: Get.size.width / 6.5,
                      child: const Icon(Icons.image,
                          size: 50, color: Colors.grey)),
                if (controller.receiveItemListdata[index!].mode! ==
                    DATA_MULTIPLE)
                  SizedBox(
                    height: Get.size.height / 3.5,
                    width: Get.size.width / 6.5,
                    child: const Icon(
                      Icons.checklist_rounded,
                      size: 50,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),

                if (controller.receiveItemListdata[index!].mode! == DATA_VS)
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
                      Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: AutoSizeText(
                          controller.receiveItemListdata[index!]
                              .title!, // 서버에서 가져온 searchmodel 제목 데이터
                          style: Get.theme.textTheme.subtitle1,
                          overflow: TextOverflow
                              .fade, // 서버에서 가져온 제목 데이터값이 길면 픽셀에러가 발생 해결을 위해 오버플로우시 한줄로 만들어 패이드 시켜 해결
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),

                      controller.expiredTimeInfo(index!)
                          ? Text('만료', style: Get.theme.textTheme.subtitle2)
                          : Text(
                              '${dateFormat.format(controller.receiveItemListdata[index!].expiredDate!)} 만료됨', // 서버에서 가져온 searchmodel 시간 데이터
                              style: Get.theme.textTheme.subtitle2,
                            ),
                      // issues: #47 계산식 코드 버그 수정 - ellee
                      Text(
                          '${controller.receiveItemListdata[index!].secondPrice!} YAB'), // 서버에서 가져온 searchmodel 가격 데이터
                      Text(
                        modeMapEngToKor[controller.receiveItemListdata[index!]
                            .mode]!, // 서버에서 가져온 searchmodel 모드 데이터
                        style: Get.theme.textTheme.subtitle2,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // },
          // ),
        ));
  }
}

// 모드를 변경하는 맵핑 데이터
const Map<String, String> modeMapEngToKor = {
  'vs': '밸런스 게임',
  'multiple': '다중 항목 게시물',
  'promotion': '일반 게시물'
};
