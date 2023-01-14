import 'package:get/get.dart';
import 'package:yab_v2/src/controller/address_search_controller.dart';
import 'package:yab_v2/src/controller/admob_controller.dart';
import 'package:yab_v2/src/controller/anonymous_login_controller.dart';
import 'package:yab_v2/src/controller/app_info_controller.dart';
import 'package:yab_v2/src/controller/auth_controller.dart';
import 'package:yab_v2/src/controller/bottom_navigation_controller.dart';
import 'package:yab_v2/src/controller/calendar_check_controller.dart';
import 'package:yab_v2/src/controller/event_controller.dart';
import 'package:yab_v2/src/controller/notification_controller.dart';
import 'package:yab_v2/src/controller/point_report_controller.dart';
import 'package:yab_v2/src/controller/qr_code_controller.dart';
import 'package:yab_v2/src/controller/qr_code_scan_controller.dart';
import 'package:yab_v2/src/controller/receive_board_controller.dart';
import 'package:yab_v2/src/controller/send_board_controller.dart';
import 'package:yab_v2/src/controller/user_controller.dart';
import 'package:yab_v2/src/controller/user_info_detector_controller.dart';
import 'package:yab_v2/src/controller/preferences_controller.dart';
import 'package:yab_v2/src/page/shop/shop_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavigationController(),
        permanent: true); // BottomNavigationBar 상시 유지
    Get.put(AuthController(), permanent: true); // AuthController 상시 유지
    Get.put(
        PreferencesController()); // PreferencesController 앱 실행 시 최초 1회 체크 후 사용하지 않음 차후 필요할 경우 수정
    Get.put(NotificationController(),
        permanent: true); // 알림 푸시 기능 / NotificationController 상시 유지
    Get.put(AdmobController(), permanent: true); // 광고 기능 상시유지
    Get.put(AppInfoController(), permanent: true); // 앱정보를 가져오는 컨트롤러 상시 유지
    Get.put(AnonymousLoginController(), permanent: true);
    // Get.lazyPut(() => AnonymousLoginController());
  }

  // 로그인이 완료하고 난후 컨트롤러 메모리에 올리기
  static additionalBinding() {
    Get.put(UserController(), permanent: true); // UserController 상시 유지
    Get.put(UserInfoDetectorController(),
        permanent: true); // 찾기 / UserInfoDetectorController 상시 유지
    Get.put(ReceiveBoardController(),
        permanent: true); // 내게 온 게시물 / ReceiveBoardController 상시 유지
    Get.put(SendBoardController(),
        permanent: true); // 내게 온 게시물 / SendBoardController 상시 유지
    Get.put(EventCalendarController(),
        permanent: true); // 출석체크 / EventCalendarController 상시 유지
    Get.put(EventController(), permanent: true); // 이벤트 페이지 컨트롤러
    Get.put(AddressSearchController(), permanent: true);
    Get.put(PointReportController(),
        permanent: true); // 포인트 사용내역 PointReportController 상시 유지
    Get.put(QRCodeController()); // Qr 코드 생성
    Get.put(QRCodeScanController()); // Qr 코드 스캔
    Get.put(ShopController(), permanent: true); // 상점 API실행
  }
}
