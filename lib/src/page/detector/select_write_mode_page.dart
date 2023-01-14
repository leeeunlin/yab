import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';
import 'package:yab_v2/src/page/detector/write/multiple_write_page.dart';
import 'package:yab_v2/src/page/detector/write/promotion_write_page.dart';
import 'package:yab_v2/src/page/detector/write/vs_write_page.dart';
import 'package:yab_v2/src/utils/data_keys.dart';

class SelectWriteModePage extends GetView<UserInfoDetectorController> {
  const SelectWriteModePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text('글쓰기'),
          flexibleSpace: const SingleChildScrollView()),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .requestFocus(FocusNode()); // TextFormField에서 포커스 사라질 시 키보드 숨김
        },
        child: Obx(
          () => Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.amber,
                child: SingleChildScrollView(
                  // 차후 상단 탭 스크롤 필요할 경우를 대비 주석
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            backgroundColor:
                                controller.detectorUserModel.value.mode ==
                                        DATA_PROMOTION
                                    ? Colors.white
                                    : Colors.amber,
                            shadowColor: Colors.black.withOpacity(0)),
                        onPressed: () {
                          if (controller.detectorUserModel.value.mode !=
                              DATA_PROMOTION) {
                            controller.modeChangePaymentInit();
                          }
                          controller.setModeSelected(DATA_PROMOTION);
                        },
                        child: Text('일반 글 작성',
                            style: TextStyle(
                                color:
                                    controller.detectorUserModel.value.mode ==
                                            DATA_PROMOTION
                                        ? Colors.black
                                        : Colors.white)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            backgroundColor:
                                controller.detectorUserModel.value.mode ==
                                        DATA_VS
                                    ? Colors.white
                                    : Colors.amber,
                            shadowColor: Colors.black.withOpacity(0)),
                        onPressed: () {
                          if (controller.detectorUserModel.value.mode !=
                              DATA_VS) {
                            controller.modeChangePaymentInit();
                          }
                          controller.setModeSelected(DATA_VS);
                        },
                        child: Text('밸런스 게임',
                            style: TextStyle(
                                color:
                                    controller.detectorUserModel.value.mode ==
                                            DATA_VS
                                        ? Colors.black
                                        : Colors.white)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            backgroundColor:
                                controller.detectorUserModel.value.mode ==
                                        DATA_MULTIPLE
                                    ? Colors.white
                                    : Colors.amber,
                            shadowColor: Colors.black.withOpacity(0)),
                        onPressed: () {
                          if (controller.detectorUserModel.value.mode !=
                              DATA_MULTIPLE) {
                            controller.modeChangePaymentInit();
                          }
                          controller.setModeSelected(DATA_MULTIPLE);
                        },
                        child: Text('다중 항목',
                            style: TextStyle(
                                color:
                                    controller.detectorUserModel.value.mode ==
                                            DATA_MULTIPLE
                                        ? Colors.black
                                        : Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    if (controller.detectorUserModel.value.mode ==
                        DATA_PROMOTION)
                      const PromotionWritePage(),
                    if (controller.detectorUserModel.value.mode == DATA_VS)
                      const VSWritePage(),
                    if (controller.detectorUserModel.value.mode ==
                        DATA_MULTIPLE)
                      const MultipleWritePage()
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    nextPage();
                  },
                  child: const Text('다음'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void nextPage() async {
    if (controller.detectorUserModel.value.mode == DATA_PROMOTION) {
      // 일반게시물
      String _title = controller.promotionTitle.value.text;
      String _detail = controller.promotionDetail.value.text;

      if (_title.isEmpty) {
        Get.snackbar('내용을 입력해주세요.', '제목을 입력해 주세요.');
      } else if (_detail.isEmpty) {
        Get.snackbar('내용을 입력해주세요.', '게시글 내용을 입력해 주세요.');
      } else {
        List<String> detailTmp = [];
        detailTmp.add(_detail);
        controller.setTitleValued(_title);
        controller.setDetailValued(detailTmp);
        await Get.toNamed('/DetectorPaymentPage');
      }
    } else if (controller.detectorUserModel.value.mode == DATA_VS) {
      //vs 게시물
      String _title = controller.vsTitle.value.text;
      String _aDetail = controller.vsADetail.value.text;
      String _bDetail = controller.vsBDetail.value.text;

      if (_title.isEmpty) {
        Get.snackbar('내용을 입력해주세요.', '제목을 입력해 주세요.');
      } else if (_aDetail.isEmpty) {
        Get.snackbar('내용을 입력해주세요.', '첫번째 내용을 입력해 주세요.');
      } else if (_bDetail.isEmpty) {
        Get.snackbar('내용을 입력해주세요.', '두번째 내용을 입력해 주세요.');
      } else {
        List<String> detailTmp = [];
        detailTmp.add(_aDetail);
        detailTmp.add(_bDetail);
        controller.setTitleValued(_title);
        controller.setDetailValued(detailTmp);
        await Get.toNamed('/DetectorPaymentPage');
      }
    } else if (controller.detectorUserModel.value.mode == DATA_MULTIPLE) {
      // 다중 게시물
      String _title = controller.multiTitle.value.text;
      String _aDetail = controller.multiADetail.value.text;
      String _bDetail = controller.multiBDetail.value.text;
      String _cDetail = controller.multiCDetail.value.text;
      String _dDetail = controller.multiDDetail.value.text;

      if (_title.isEmpty) {
        Get.snackbar('내용을 입력해주세요.', '제목을 입력해 주세요.');
      } else if (_aDetail.isEmpty) {
        Get.snackbar('내용을 입력해주세요.', '첫번째 내용을 입력해 주세요.');
      } else if (_bDetail.isEmpty) {
        Get.snackbar('내용을 입력해주세요.', '두번째 내용을 입력해 주세요.');
      } else if (_cDetail.isEmpty) {
        Get.snackbar('내용을 입력해주세요.', '세번째 내용을 입력해 주세요.');
      } else if (_dDetail.isEmpty) {
        Get.snackbar('내용을 입력해주세요.', '네번째 내용을 입력해 주세요.');
      } else {
        List<String> detailTmp = [];
        detailTmp.add(_aDetail);
        detailTmp.add(_bDetail);
        detailTmp.add(_cDetail);
        detailTmp.add(_dDetail);
        controller.setTitleValued(_title);
        controller.setDetailValued(detailTmp);
        await Get.toNamed('/DetectorPaymentPage');
      }
    }
  }
}
