import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:yab_v2/src/controller/send_board_controller.dart';

class SendImageListPage extends GetView<SendBoardController> {
  SendImageListPage({Key? key}) : super(key: key);
  final int index = int.parse(Get.parameters['index']!); // 파라미터 index값을 가져온다.

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              SizedBox(
                child: Obx(
                  () => PhotoViewGallery.builder(
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
                      controller.imageFullListNum.value = index + 1;
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
                      '${controller.imageFullListNum.value} / ${controller.sendItemListdata[index].imageDownloadUrls!.length}',
                      style: Get.textTheme.bodyLarge),
                ),
              )
            ],
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Icon(
              Icons.close,
              size: 50,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
