import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:yab_v2/src/app.dart';
import 'package:yab_v2/src/controller/qr_code_controller.dart';

class QRCodePage extends GetView<QRCodeController> {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###'); // 숫자 자르기
    return WillPopScope(
      onWillPop: () {
        Get.back();
        controller.cleanController();
        return Future(() => false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('YAB 받기'),
          leading: IconButton(
              onPressed: () async {
                await Get.offAll(const App());
                controller.cleanController();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "받으실 YAB을 입력해주세요."),
                    keyboardType: TextInputType.number,
                    controller: controller.qrContentEditingController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[0-9]'),
                      ) // 무조건 숫자만 들어오게 하기
                    ],
                    onChanged: (val) {
                      try {
                        if (val.isEmpty) {
                          controller.cleanController();
                        }
                        controller.receivePeePoint.value =
                            (int.parse(val) + (int.parse(val) * 0.10).floor())
                                .toString();
                        controller.receivePoint.value = val;
                      } catch (e) {}

                      controller.userQrCodeData =
                          '${controller.userKey.value},${controller.receivePoint.value},${controller.receivePeePoint.value}';
                    },
                  ),
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.isGapless = !controller.isGapless;
                      FocusScope.of(context).unfocus();
                    },
                    child: SizedBox(
                      height: Get.width * 0.8,
                      width: Get.width * 0.8,
                      child: QrImage(
                        data: controller.userQrCodeData,
                        version: QrVersions.auto,
                        size: Get.width * 0.7,
                        gapless: controller.isGapless,
                        // QR 코드안에 아이콘 집어넣기
                        // embeddedImage:
                        //     const AssetImage('assets/images/logo/app-icon.png'),
                        // embeddedImageStyle:
                        //     QrEmbeddedImageStyle(size: const Size(60, 60)),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => controller.receivePoint.value == '0'
                      ? Container()
                      : Container(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                              "전송 될 포인트는 ${f.format(int.parse(controller.receivePeePoint.value))} YAB 입니다."),
                        ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                      "입력하시는 포인트의 10%가 자동으로 추가됩니다.\n포인트의 10%는 수수료로 지급 됩니다."),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
