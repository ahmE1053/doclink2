import 'dart:convert';

import 'package:doclink3/core/utilities/duration_extensions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

import '../../../data/data source/chats_remote_data_source.dart';
import '../../../firebase_options.dart';
import '../../router/app_router.dart';
import '../messages_read_handler.dart';

class NotificationController {
  @pragma('vm:entry-point')
  static Future<void> onDidReceiveLocalNotification(
      NotificationResponse notificationResponse) async {
    final appRouter = GetIt.I.get<AppRouter>();
    appRouter.navigate(
      ChatRoute(
        chatId: jsonDecode(notificationResponse.payload!)['chatId'],
      ),
    );
  }

  @pragma('vm:entry-point')
  static Future<void> onDidReceiveLocalBackgroundNotification(
      NotificationResponse notificationResponse) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final payload = Map<String, Object>.from(
      jsonDecode(
        notificationResponse.payload!,
      ),
    );

    final chatRemoteDataSource =
        ChatsRemoteDataSource.fromNotification(payload);
    await markMessagesAsRead(chatRemoteDataSource);
    if (notificationResponse.actionId == 'reply' &&
        notificationResponse.input != null) {
      await chatRemoteDataSource.addText(
        notificationResponse.input!,
      );
    }
  }
}
