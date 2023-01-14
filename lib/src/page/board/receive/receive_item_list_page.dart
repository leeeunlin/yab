import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/app.dart';
import 'package:yab_v2/src/controller/receive_board_controller.dart';
import 'package:yab_v2/src/page/board/receive/receive_item_widget.dart';
import 'package:yab_v2/src/page/my/userinfo/user_info_page.dart';

class ReceiveItemListPage extends GetView<ReceiveBoardController> {
  const ReceiveItemListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(const App());
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('받은 소식'),
          leading: IconButton(
              onPressed: () {
                Get.offAll(const App());
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Obx(
          () => RefreshIndicator(
            // issues: #49 Pull Down RefreshIndicator 적용 - ellee
            onRefresh: () async {
              await controller.reload();
            },
            child: SizedBox(
              child: ListView.separated(
                controller: controller.scrollController.value,
                itemBuilder: (_, index) {
                  if (index < controller.receiveItemListdata.length) {
                    return ReceiveItemWidget(index);
                  }
                  if (controller.hasMore.value || controller.isLoading.value) {
                    return const Center(child: RefreshProgressIndicator());
                  }

                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        children: [
                          const Text(
                            '정보를 입력하시고 기다려주세요.\n입력하신 정보가 많을 수록\n더 많은 보상과 좋은 정보가 찾아갑니다. \u{1F618}',
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                              onPressed: () async {
                                await Get.to(() => const UserInfoPage());
                              },
                              child: const Text('내 정보 입력하러 가기')),
                          TextButton.icon(
                              onPressed: () {
                                controller.reload();
                              },
                              icon: const Icon(
                                Icons.refresh_outlined,
                                color: Colors.black,
                              ),
                              label: const Text(
                                '소식 새로고침',
                                style: TextStyle(color: Colors.black),
                              )),
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
                itemCount: controller.receiveItemListdata.length + 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
