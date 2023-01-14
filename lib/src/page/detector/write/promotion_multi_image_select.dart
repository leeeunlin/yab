import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';
import 'package:yab_v2/src/size_config.dart';

class PromotionMultiImageSelect extends GetView<UserInfoDetectorController> {
  const PromotionMultiImageSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isPickingImages = false;
    return LayoutBuilder(
      builder: (context, constraints) {
        Size _size = Get.size;
        var imageSize = (_size.width / 3) - getProportionateScreenWidth(20) * 2;
        var imageCorner = 16.0;
        return SizedBox(
          height: _size.width / 3,
          width: _size.width,
          child: Obx(
            () => ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  child: InkWell(
                    onTap: () async {
                      // 사진 넣기 부분
                      _isPickingImages = true;
                      final ImagePicker _picker = ImagePicker();
                      final List<XFile>? images = await _picker.pickMultiImage(
                          imageQuality:
                              10); // 파이어베이스에 업로드할때 이미지 퀄리티를 낮춰 패킷을 줄인다 추후에 변경가능
                      if (images != null && images.isNotEmpty) {
                        controller.setNewImages(images);
                      }
                      _isPickingImages = false;
                    },
                    child: Container(
                      child: _isPickingImages
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.grey,
                                ),
                                Obx(
                                  () => Text(
                                    "${controller.imagesController.length}/5",
                                    style: Get.theme.textTheme.subtitle2,
                                  ),
                                ),
                              ],
                            ),
                      width: imageSize,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(imageCorner),
                          border: Border.all(color: Colors.grey, width: 1)),
                    ),
                  ),
                ),
                ...List.generate(
                  controller.imagesController.length,
                  (index) => Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20, top: 20, bottom: 20),
                        child: ExtendedImage.memory(
                          controller.imagesController[index],
                          width: imageSize,
                          height: imageSize,
                          fit: BoxFit.cover,
                          loadStateChanged: (state) {
                            switch (state.extendedImageLoadState) {
                              case LoadState.loading:
                                return Container(
                                  child: const CircularProgressIndicator(),
                                  width: imageSize,
                                  height: imageSize,
                                  padding: EdgeInsets.all(imageSize / 3),
                                );
                              case LoadState.completed:
                                return null;
                              case LoadState.failed:
                                return const Icon(Icons.cancel);
                            }
                          },
                          borderRadius: BorderRadius.circular(imageCorner),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        height: 40,
                        width: 40,
                        child: IconButton(
                          padding: const EdgeInsets.all(8),
                          onPressed: () {
                            controller.removeImage(index);
                            // selectImageNotifier.removeImage(index);
                          },
                          icon: const Icon(Icons.remove_circle),
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
