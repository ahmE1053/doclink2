import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../firebase_options.dart';
import 'notification_controller.dart';
import 'displaying_notifications.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await notificationServiceInitialization();
  await showMessageNotification(message);
}

@pragma('vm:entry-point')
Future<void> notificationServiceInitialization() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/ic_accept_call');
  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        NotificationController.onDidReceiveLocalNotification,
    onDidReceiveBackgroundNotificationResponse:
        NotificationController.onDidReceiveLocalBackgroundNotification,
  );
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingInitialization() async {
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await notificationServiceInitialization();
  FirebaseMessaging.onMessage.listen(showMessageNotification);
}

@pragma('vm:entry-point')
Future<String?> launchDetailsGetter() async {
  final launchDetails =
      await FlutterLocalNotificationsPlugin().getNotificationAppLaunchDetails();
  if (launchDetails == null || !launchDetails.didNotificationLaunchApp) {
    return null;
  }
  return jsonDecode(launchDetails.notificationResponse!.payload!)['chatId'];
}
