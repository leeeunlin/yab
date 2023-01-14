import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';

class QRCodeScanController extends GetxController {
  static QRCodeScanController get to => Get.find();

  final _scanResult = Barcode("", BarcodeFormat.code93, null).obs;
  set scanResult(value) => _scanResult.value = value;
  get scanResult => _scanResult.value;
  RxInt sendPoint = 0.obs;
  RxInt sendPeePoint = 0.obs;
  RxString sendUser = ''.obs;

  QRViewController? qrViewController;

  void onQRViewCreated(QRViewController qrViewController) async {
    await qrViewController.resumeCamera();
    this.qrViewController = qrViewController;
    qrViewController.scannedDataStream.listen((scanData) {
      scanResult = scanData;
      String userKeyTmp = (scanData.code)!.split(',')[0];
      String pointTmp = (scanData.code)!.split(',')[1];
      String peePointTmp = (scanData.code)!.split(',')[2];

      sendPoint(int.parse(pointTmp));
      sendPeePoint(int.parse(peePointTmp));
      sendUser.value = userKeyTmp;
    });
  }

  // QR을 스캔하여 나온 아이디 정보를 이용하여 해당 유저에게 포인트를 보냄
  void sendQRPoint(int sendPoint) async {
    String userKey = AuthController.to.userModel.value.userKey!;
    await UserController.to
        .subPoint(userKey, sendPeePoint.value, "send_qr_yab");
    await UserController.to
        .addOtherUserPoint(sendUser.value, sendPoint, "Receive_qr_yab");
  }

  // 유저 포인트와 보내려는 포인트를 비교하여 확인 하는 함수
  bool checkLackofPoint() {
    num _userCoin = UserController.to.userModel.value.coin!;
    num sendCoin = sendPeePoint.value;

    if (_userCoin >= sendCoin) {
      return true;
    } else {
      return false;
    }
  }

  // QR 코드 변조 여부 검사
  bool checkQR() {
    int tmpSendPoint = sendPoint.value;
    int tmpSendPeePoint = tmpSendPoint + (tmpSendPoint * 0.10).floor();

    if (tmpSendPeePoint == sendPeePoint.value) {
      return true;
    } else {
      return false;
    }
  }

  cleanScanResult() {
    scanResult = Barcode("", BarcodeFormat.code93, null);
  }
}
