import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: ${message.notification?.title}");
      if (message.notification != null) {
        const AndroidNotificationDetails androidDetails =
            AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'channel_description',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        );

        const NotificationDetails platformDetails =
            NotificationDetails(android: androidDetails);

        await flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          platformDetails,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("User tapped the notification!");
    });
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id',
      'channel_name',
      description: 'channel_description',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
Future<void> requestNotificationPermission() async {
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('✅ تم السماح من قبل المستخدم');
  } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
    print('❌ تم الرفض من قبل المستخدم');
  } else {
    print('⚠️ الإذن غير محدد');
  }
}

}
