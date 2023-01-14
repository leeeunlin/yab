import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/receive_board_controller.dart';
import 'package:yab_v2/src/utils/data_keys.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ReceiveMultiItemDetailPage extends GetView<ReceiveBoardController> {
  const ReceiveMultiItemDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = int.parse(Get.parameters['index']!); // 파라미터 index값을 가져온다.

    void nextPage() async {
      if (!controller.vsAFlag.value &&
          !controller.vsBFlag.value &&
          !controller.vsCFlag.value &&
          !controller.vsDFlag.value) {
        Get.snackbar('선택해주세요.', '값이 선택되지 않았습니다.');
        return;
      } else {
        bool viewCheck = controller.receiveItemListdata[index].postView!;

        await controller.setAnswerKey(controller.receiveItemListdata[index]
            .detectorKey!); // 답변 결과를 해당 답변지에 키값을 입력하는 함수

        if (viewCheck == false && controller.expiredTimeInfo(index) == false) {
          await controller.addpointAnswer(
            controller.receiveItemListdata[index].detectorKey!,
            // issues: #47 계산식 DB불러오는 부분 수정 - ellee
            controller.receiveItemListdata[index].secondPrice!,
          );
        }
        controller.receiveItemListdata[index].postView =
            true; // 컨트롤러의 postview값을 true로 변경하여 색을 변경 가능하게 함
        await Get.offAllNamed('/ReceiveItemListPage');
        return;
      }
    }

    int allAnswerCount() {
      return (controller.receiveItemListdata[index].selectUserModel!
                  .toJson()[FIELD_A])
              .length +
          (controller.receiveItemListdata[index].selectUserModel!
                  .toJson()[FIELD_B])
              .length +
          (controller.receiveItemListdata[index].selectUserModel!
                  .toJson()[FIELD_C])
              .length +
          (controller.receiveItemListdata[index].selectUserModel!
                  .toJson()[FIELD_D])
              .length +
          (controller.receiveItemListdata[index].selectUserModel!
                  .toJson()[FIELD_E])
              .length +
          (controller.receiveItemListdata[index].selectUserModel!
                  .toJson()[FIELD_F])
              .length +
          (controller.receiveItemListdata[index].selectUserModel!
                  .toJson()[FIELD_G])
              .length +
          (controller.receiveItemListdata[index].selectUserModel!
                  .toJson()[FIELD_H])
              .length;
    }

    Container receiveItemA() {
      return Container(
        padding: const EdgeInsets.only(top: 20),
        height: Get.size.height / 10,
        width: double.infinity,
        child: Row(
          children: [
            Text('A : ', style: Get.theme.textTheme.titleLarge),
            Expanded(
              child: ElevatedButton(
                child: AutoSizeText(
                    (controller.receiveItemListdata.isNotEmpty
                        ? controller.receiveItemListdata[index].detail![0]
                        : ''),
                    style: TextStyle(
                        fontSize: 16,
                        color: controller.vsAFlag.value
                            ? Colors.white
                            : Colors.grey)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: controller.vsAFlag.value
                        ? Colors.deepPurpleAccent
                        : Colors.white,
                    padding: const EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                onPressed: () {
                  if (controller.vsAFlag.value == false) {
                    controller.vsAFlag.value = true;
                    controller.vsBFlag.value = false;
                    controller.vsCFlag.value = false;
                    controller.vsDFlag.value = false;
                  }
                },
              ),
            ),
          ],
        ),
      );
    }

    Container receiveItemB() {
      return Container(
        padding: const EdgeInsets.only(top: 20),
        height: Get.size.height / 10,
        width: double.infinity,
        child: Row(
          children: [
            Text('B : ', style: Get.theme.textTheme.titleLarge),
            Expanded(
              child: ElevatedButton(
                child: AutoSizeText(
                    (controller.receiveItemListdata.isNotEmpty
                        ? controller.receiveItemListdata[index].detail![1]
                        : ''),
                    style: TextStyle(
                        fontSize: 16,
                        color: controller.vsBFlag.value
                            ? Colors.white
                            : Colors.grey)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: controller.vsBFlag.value
                        ? Colors.deepPurpleAccent
                        : Colors.white,
                    padding: const EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                onPressed: () {
                  if (controller.vsBFlag.value == false) {
                    controller.vsAFlag.value = false;
                    controller.vsBFlag.value = true;
                    controller.vsCFlag.value = false;
                    controller.vsDFlag.value = false;
                  }
                },
              ),
            ),
          ],
        ),
      );
    }

    Container receiveItemC() {
      return Container(
        padding: const EdgeInsets.only(top: 20),
        height: Get.size.height / 10,
        width: double.infinity,
        child: Row(
          children: [
            Text('C : ', style: Get.theme.textTheme.titleLarge),
            Expanded(
              child: ElevatedButton(
                child: AutoSizeText(
                    (controller.receiveItemListdata.isNotEmpty
                        ? controller.receiveItemListdata[index].detail![2]
                        : ''),
                    style: TextStyle(
                        fontSize: 16,
                        color: controller.vsCFlag.value
                            ? Colors.white
                            : Colors.grey)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: controller.vsCFlag.value
                        ? Colors.deepPurpleAccent
                        : Colors.white,
                    padding: const EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                onPressed: () {
                  if (controller.vsCFlag.value == false) {
                    controller.vsAFlag.value = false;
                    controller.vsBFlag.value = false;
                    controller.vsCFlag.value = true;
                    controller.vsDFlag.value = false;
                  }
                },
              ),
            ),
          ],
        ),
      );
    }

    Container receiveItemD() {
      return Container(
        padding: const EdgeInsets.only(top: 20),
        height: Get.size.height / 10,
        width: double.infinity,
        child: Row(
          children: [
            Text('D : ', style: Get.theme.textTheme.titleLarge),
            Expanded(
              child: ElevatedButton(
                child: AutoSizeText(
                    (controller.receiveItemListdata.isNotEmpty
                        ? controller.receiveItemListdata[index].detail![3]
                        : ''),
                    style: TextStyle(
                        fontSize: 16,
                        color: controller.vsDFlag.value
                            ? Colors.white
                            : Colors.grey)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: controller.vsDFlag.value
                        ? Colors.deepPurpleAccent
                        : Colors.white,
                    padding: const EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                onPressed: () {
                  if (controller.vsDFlag.value == false) {
                    controller.vsAFlag.value = false;
                    controller.vsBFlag.value = false;
                    controller.vsCFlag.value = false;
                    controller.vsDFlag.value = true;
                  }
                },
              ),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('다중 항목 게시물'),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back)),
          ), // 게시글 제목
          body: Obx(
            () => Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                      width: double.infinity,
                      child: Text(
                        controller.receiveItemListdata[index].title!,
                        style: Get.theme.textTheme.titleLarge,
                        textAlign: TextAlign.start,
                      )),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, top: 10, bottom: 10, right: 10),
                    child: Column(
                      children: <Widget>[
                        receiveItemA(),
                        receiveItemB(),
                        receiveItemC(),
                        receiveItemD(),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      (controller.receiveItemListdata.isNotEmpty
                          ? '${controller.receiveItemListdata[index].counter.toString()} 명 중 ${allAnswerCount().toString()}명 답변'
                          : ''),
                      style: Get.theme.textTheme.subtitle2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.expiredTimeInfo(index)) {
                          Get.snackbar(
                              '게시 종료 안내', '게시물이 게시종료되어 답변을 보낼 수 없습니다.');
                          return;
                        }
                        nextPage();
                      },
                      child: const Text('답변 보내기'),
                    ),
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