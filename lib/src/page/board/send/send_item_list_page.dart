import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/send_board_controller.dart';
import 'package:yab_v2/src/page/board/send/send_item_widget.dart';

class SendItemListPage extends GetView<SendBoardController> {
  const SendItemListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.repeatWrite.value = false;
        Get.back();
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text('작성한 글'),
            centerTitle:
                false, // android : default값은 왼쪽 정렬 / IOS : default값은 가운데 정렬
            leading: IconButton(
                onPressed: () {
                  controller.repeatWrite.value = false;

                  Get.back();
                },
                icon: const Icon(Icons.arrow_back))),
        body: Obx(
          () => SizedBox(
            child: ListView.separated(
              controller: controller.scrollController.value,
              itemBuilder: (_, index) {
                if (index < controller.sendItemListdata.length) {
                  return SendItemWidget(index);
                }
                if (controller.hasMore.value || controller.isLoading.value) {
                  return const Center(child: RefreshProgressIndicator());
                }

                return Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Column(
                      children: [
                        const Text('더 이상 작성한 글이 없어요'),
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
              itemCount: controller.sendItemListdata.length + 1,
            ),
          ),
        ),
      ),
    );
  }
}
