import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/controller/point_report_controller.dart';
import 'package:yab_v2/src/model/point_report_model.dart';

class UserPointReportWidget extends GetView<PointReportController> {
  const UserPointReportWidget(this.index, {Key? key}) : super(key: key);

  final int? index;

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###'); // 숫자 자르기
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    return FutureBuilder(
      future: controller.getPointReportList(),
      builder: (context, snapshot) {
        return Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          height: Get.size.height / 10,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          left: 10, top: 10, bottom: 3, right: 3),
                      child: Text(dateFormat.format(controller
                          .pointReportItemListdata[index!].createdDate!)),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              pointReportMapEngToKor[controller
                                      .pointReportItemListdata[index!].mode]
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black)),
                          Text(
                            controller.pointReportItemListdata[index!].price! <
                                    0
                                ? '-${f.format((controller.pointReportItemListdata[index!].price!).floor()).toString().replaceFirst('-', ' ')}'
                                : '+ ${f.format((controller.pointReportItemListdata[index!].price!).floor()).toString()}',
                            style: TextStyle(
                              fontSize: 15,
                              color: controller.pointReportItemListdata[index!]
                                          .price! <
                                      0
                                  ? Colors.red
                                  : Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
