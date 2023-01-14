import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yab_v2/src/model/point_report_model.dart';
import 'package:yab_v2/src/repository/point_report_repository.dart';

class PointReportController extends GetxController {
  static PointReportController get to => Get.find();

  RxBool isLoading = false.obs;
  var hasMore = false.obs;
  var scrollController = ScrollController().obs;
  var pointReportItemListdata = <PointReportModel>[].obs;

  RxList<PointReportModel> potintReportItemList = <PointReportModel>[].obs;

  Future<List<PointReportModel>> getPointReportList() async {
    return await PointReportRepository.getPointReportList();
  }

  @override
  void onInit() async {
    if (!isLoading.value) {
      await onRefres();
      isLoading(true);
      update();
    }
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          hasMore.value) {
        _getData();
      }
    });
    super.onInit();
  }

  _getData() async {
    isLoading.value = true;

    int offset = pointReportItemListdata.length;

    pointReportItemListdata
        .addAll(await PointReportRepository.getPointReportLimitList(offset));
    isLoading.value = false;
    hasMore.value =
        pointReportItemListdata.length < potintReportItemList.length;
  }

  reload() async {
    isLoading.value = true;
    pointReportItemListdata.clear();
    _getData();
  }

  Future<void> onRefres() async {
    potintReportItemList.clear();
    potintReportItemList.addAll(await getPointReportList());
  }
}
