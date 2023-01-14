import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:yab_v2/src/app.dart';
import 'package:yab_v2/src/controller/qr_code_scan_controller.dart';

class QRCodeScanPage extends GetView<QRCodeScanController> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back();
        controller.cleanScanResult();
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('YAB 보내기'),
          leading: IconButton(
              onPressed: () {
                Get.back();
                controller.cleanScanResult();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Obx(() => controller.scanResult.code == ""
            ? _buildQrView(context)
            : _buildScanResultView(context)),
      ),
    );
  }

  Widget _buildScanResultView(BuildContext context) {
    var f = NumberFormat('###,###,###,###'); // 숫자 자르기
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: AutoSizeText(
            '결제할 금액이 맞으시면 아래 버튼을 눌러',
            style: Get.theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () async {
              if (!controller.checkQR()) {
                Get.snackbar('QR코드 문제', 'YAB에서 발행된 QR코드만 사용해주세요.');
                return;
              }
              if (controller.sendPoint.value == 0) {
                // YAB 포인트가 0일 때
                Get.snackbar('YAB 보내기 오류', '0 YAB은 보낼 수 없습니다.');
                return;
              }
              if (!controller.checkLackofPoint()) {
                // 유저 포인트가 보내려는 포인트보다 적을 때
                Get.snackbar('YAB 부족', 'YAB이 부족합니다.');
                return;
              }

              // 유저 포인트가 보내려는 포인트보다 많을 때
              controller.sendQRPoint(controller.sendPoint.value);
              controller.cleanScanResult();
              await Get.offAll(const App());
            },
            child: AutoSizeText(
              '${f.format(controller.sendPeePoint.value)} YAB 을 보냅니다.',
              maxLines: 1,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: AutoSizeText(
            '해당 금액은 10%의 수수료가 포함된 금액 입니다.',
            maxLines: 1,
            style: Get.theme.textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = Get.width;
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: controller.onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea),
        ),
        Positioned.fill(
          child: Container(
            padding: const EdgeInsets.only(top: 30),
            child: const Text(
              'QR코드를 아래 네모상자에 맞춰 주세요',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
              child: ElevatedButton(
                child: const Text('보내기 취소'),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
