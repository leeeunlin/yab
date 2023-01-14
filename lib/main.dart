import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yab_v2/firebase_options.dart';
import 'package:yab_v2/src/app.dart';
import 'package:yab_v2/src/binding/init_bindings.dart';
import 'package:yab_v2/src/page/board/receive/receive_multi_item_detail_page.dart';
import 'package:yab_v2/src/page/board/receive/receive_promotion_item_detail_page.dart';
import 'package:yab_v2/src/page/board/receive/receive_vs_item_detail_page.dart';
import 'package:yab_v2/src/page/board/receive/receive_item_list_page.dart';
import 'package:yab_v2/src/page/board/send/send_item_list_page.dart';
import 'package:yab_v2/src/page/board/send/send_multi_item_detail_page.dart';
import 'package:yab_v2/src/page/board/send/send_promotion_item_detail_page.dart';
import 'package:yab_v2/src/page/board/send/send_vs_item_detail_page.dart';
import 'package:yab_v2/src/page/detector/detector_main_page.dart';
import 'package:yab_v2/src/page/detector/detector_payment_page.dart';
import 'package:yab_v2/src/page/detector/detector_result_page.dart';
import 'package:yab_v2/src/page/detector/select_write_mode_page.dart';
import 'package:yab_v2/src/page/detector/write/multiple_write_page.dart';
import 'package:yab_v2/src/page/detector/write/promotion_write_page.dart';
import 'package:yab_v2/src/page/detector/write/vs_write_page.dart';
import 'package:yab_v2/src/page/my/address_info/address_search_page.dart';
import 'package:yab_v2/src/page/my/privacy_policy.dart';
import 'package:yab_v2/src/page/my/terms_of_service.dart';
import 'package:yab_v2/src/page/my/userbasicinfo/user_basicinfo_page.dart';
import 'package:yab_v2/src/page/my/userinfo/user_info_page.dart';
import 'package:yab_v2/src/page/shop/shop_page.dart';
import 'package:yab_v2/src/page/splash/splash_page.dart';
import 'package:yab_v2/src/page/intro/intro_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yab_v2/src/page/qr_code_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yab_v2/src/page/qr_code_scan_page.dart';
import 'package:yab_v2/src/page/test.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Firebase 설정
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  MobileAds.instance.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 배포 시 무조건 주석
  // await _connectToFirebaseEmulator(); // firebase emulator

  runApp(const MyApp());
}

// 에뮬레이터를 사용하기 위함.
Future _connectToFirebaseEmulator() async {
  final localHostString = GetPlatform.isAndroid ? '10.0.2.2' : 'localhost';

  FirebaseFirestore.instance.settings = Settings(
    host: '$localHostString:8080',
    sslEnabled: false,
    persistenceEnabled: false,
  );

  await FirebaseAuth.instance.useAuthEmulator(localHostString, 9099);
  FirebaseFunctions.instance.useFunctionsEmulator(
      localHostString, 5001); // emulated에서 cloudFunction을 사용하기 위함
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
      ],
      theme: ThemeData(
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        // 전체 테마를 설정하는 부분 글자 크기 / 굵게 / 색상 등등
        primarySwatch: Colors.deepPurple, // 기본 컬러
        fontFamily: GoogleFonts.gothicA1().fontFamily, // 기본 글꼴
        hintColor: Colors.grey[350], // 기본 힌트 글자
        textTheme: const TextTheme(
          button: TextStyle(color: Colors.black),
          subtitle1: TextStyle(
              color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold),
          subtitle2: TextStyle(color: Colors.grey, fontSize: 10),
          bodyText1: TextStyle(
              color: Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.normal),
          bodyText2: TextStyle(
              color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w100),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 50),
        )),
        appBarTheme: const AppBarTheme(
          elevation: 2,
          backgroundColor: Colors.white, // 앱바 백그라운드
          foregroundColor: Colors.black87,
          titleTextStyle: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          actionsIconTheme: IconThemeData(color: Colors.black87),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.black54),
      ),
      initialBinding: InitBinding(),
      home: AnimatedSplashScreen(
        splash: const SplashPage(),
        nextScreen: const IntroPage(),
        duration: 0,
        splashIconSize: Get.height,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/Home',
            page: () => const App(),
            transition: Transition.rightToLeft),
        GetPage(
          name: '/UserBasicInfoPage',
          page: () => const UserBasicInfoPage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/UserInfoPage',
          page: () => const UserInfoPage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/DetectorMainPage',
          page: () => const DetectorMainPage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/SelectWriteModePage',
          page: () => const SelectWriteModePage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/VSWritePage',
          page: () => const VSWritePage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/MultipleWritePage',
          page: () => const MultipleWritePage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/PromotionWritePage',
          page: () => const PromotionWritePage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/DetectorPaymentPage',
          page: () => const DetectorPaymentPage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/DetectorResultPage',
          page: () => const DetectorResultPage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/ReceiveItemListPage',
          page: () => const ReceiveItemListPage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
            name: '/ShopPage',
            page: () => const ShopPage(),
            transition: Transition.rightToLeft),
        GetPage(
          name: '/ReceiveVSItemDetailPage/:detectorKey',
          page: () => const ReceiveVSItemDetailPage(),
          transition: Transition.rightToLeft,
        ), // 동적URL적용
        GetPage(
          name: '/ReceiveMultiItemDetailPage/:detectorKey',
          page: () => const ReceiveMultiItemDetailPage(),
          transition: Transition.rightToLeft,
        ), // 동적URL적용
        GetPage(
          name: '/ReceivePromotionItemDetailPage/:detectorKey',
          page: () => ReceivePromotionItemDetailPage(),
          transition: Transition.rightToLeft,
        ), // 동적URL적용
        GetPage(
          name: '/SendItemListPage',
          page: () => const SendItemListPage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/SendVSItemDetailPage/:detectorKey',
          page: () => const SendVSItemDetailPage(),
          transition: Transition.rightToLeft,
        ), // 동적URL적용
        GetPage(
          name: '/SendMultiItemDetailPage/:detectorKey',
          page: () => const SendMultiItemDetailPage(),
          transition: Transition.rightToLeft,
        ), // 동적URL적용
        GetPage(
          name: '/SendPromotionItemDetailPage/:detectorKey',
          page: () => const SendPromotionItemDetailPage(),
          transition: Transition.rightToLeft,
        ), // 동적URL적용
        GetPage(
          name: '/PrivacyPolicy',
          page: () => const PrivacyPolicy(),
          transition: Transition.rightToLeft,
        ), // 개인정보처리방침
        GetPage(
          name: '/TermsOfService',
          page: () => const TermsOfService(),
          transition: Transition.rightToLeft,
        ), // 서비스이용약관
        GetPage(
          name: '/AddressSearchPage',
          page: () => const AddressSearchPage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/QRCodePage',
          page: () => const QRCodePage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
            name: '/QRCodeScanPage',
            page: () => QRCodeScanPage(),
            transition: Transition.rightToLeft),
        GetPage(name: '/test', page: () => const test()),
      ],
    );
  }
}
