import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  static NotificationController get to => Get.find();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // 토큰을 가져오는 함수
  Future<String?> getToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  @override
  void onInit() async {
    await messaging.requestPermission(
      alert: true, // 권한 요청 알림 화면을 표시 (default true)
      announcement: false, // 시리를 통해 알림의 내용을 자동으로 읽을 수 잇는 권한 요청 (default false)
      badge: true, // 뱃지 업데이트 권한 요청 (default true)
      carPlay: false, // carPlay 환경에서 알림 표시 권한 요청 (default false)
      criticalAlert:
          false, // 중요 알림에 대한 권한 요청, 해당 알림 권한을 요청하는 이유를 app store 등록시 명시해야함 (default true)
      provisional: false, // 무중단 알림 권한 요청 (default false)
      sound: true, // 알림 소리 권한 요청 (default)
    );

    _onMessage();
    super.onInit();
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void _onMessage() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('yab'),
      importance: Importance.max,
    );

    const IOSNotificationDetails iosPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'yab.wav');

    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('fcmicon'),
          iOS: IOSInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
          ),
        ),
        onSelectNotification: (String? payload) async {});

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        // android 일 때만 flutterLocalNotification 을 대신 보여주는 거임. 그래서 아래와 같은 조건문 설정.
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(notification.hashCode,
              notification.title, notification.body, notificationDetails);
        }
      },
    );
  }
}
