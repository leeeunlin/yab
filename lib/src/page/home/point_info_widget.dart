import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/controller/point_report_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/page/my/userinfo/user_point_report.dart';

class PointInfoWidget extends GetView<UserController> {
  const PointInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###');
    return InkWell(
        onTap: () async {
          // 결제페이지 이동부분 차후 수정
          PointReportController.to.reload();
          await Get.to(() => const UserPointReport());
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 150,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple,
                  Colors.blueAccent,
                ]),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                spreadRadius: 1.0,
                offset: Offset(
                  2,
                  2,
                ),
              ),
            ],
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 20, left: 30),
                      child: const Text(
                        '보유 YAB 포인트',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      )),
                ),
                Obx(
                  () => Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 20, left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: Get.size.width / 2,
                            ),
                            child: AutoSizeText(
                              (controller.userModel.value.coin == null
                                  ? ''
                                  : '${f.format(controller.userModel.value.coin!.floor())} YAB'),
                              maxLines: 1,
                              minFontSize: 1,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              controller.getUser(
                                  AuthController.to.userModel.value.userKey!);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 5),
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: Get.size.width / 1.2 / 2.5,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () async {
                              PointReportController.to.reload();
                              await Get.to(() => const UserPointReport());
                            },
                            child: const Text('적립금 내역',
                                style: TextStyle(color: Colors.white))),
                      ),
                      SizedBox(
                        width: Get.size.width / 1.2 / 2.5,
                        child: TextButton(
                          onPressed: () async {
                            await Get.toNamed('QRCodeScanPage');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.qr_code_scanner,
                                color: Colors.white,
                              ),
                              Text(' 보내기',
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ]),
        ));
  }
}
