import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:yab_v2/src/controller/receive_board_controller.dart';
import 'package:yab_v2/src/page/board/receive/receive_image_list_page.dart';

class ReceivePromotionItemDetailPage extends GetView<ReceiveBoardController> {
  ReceivePromotionItemDetailPage({Key? key}) : super(key: key);
  final int index = int.parse(Get.parameters['index']!); // 파라미터 index값을 가져온다.

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Get.offAllNamed('/ReceiveItemListPage');
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                await Get.offAllNamed('/ReceiveItemListPage');
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text('일반 게시물'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (controller
                  .receiveItemListdata[index].imageDownloadUrls!.isNotEmpty)
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    InkWell(
                      onTap: () async {
                        // 하단 숫자 표시를 선택 시 전체화면 페이지와 동기화
                        controller.imageFullListNum.value =
                            controller.imageListNum.value;
                        await Get.to(() => ReceiveImageListPage());
                      },
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: Get.size.height / 2,
                        child: Obx(
                          () => PhotoViewGallery.builder(
                            scrollPhysics: const BouncingScrollPhysics(),
                            builder: (BuildContext context, int imageIndex) {
                              return PhotoViewGalleryPageOptions(
                                imageProvider: NetworkImage(
                                  controller.receiveItemListdata[index]
                                      .imageDownloadUrls![imageIndex],
                                ),
                                minScale:
                                    PhotoViewComputedScale.contained * 0.8,
                                maxScale: PhotoViewComputedScale.covered * 2,
                              );
                            },
                            pageController: controller.pageController.value,
                            itemCount: controller.receiveItemListdata[index]
                                .imageDownloadUrls!.length,
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
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(20)),
                      child: Obx(
                        () => Text(
                          '${controller.imageListNum.value} / ${controller.receiveItemListdata[index].imageDownloadUrls!.length}',
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
                  controller.receiveItemListdata[index].title!,
                  style: Get.theme.textTheme.titleLarge,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Text(
                  controller.receiveItemListdata[index].detail![0],
                  style: Get.theme.textTheme.bodyText1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
