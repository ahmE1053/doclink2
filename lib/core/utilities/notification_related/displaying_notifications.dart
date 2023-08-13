import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../data/data source/chats_remote_data_source.dart';
import '../get_base64_image_from_network.dart';

@pragma('vm:entry-point')
Future<void> showMessageNotification(RemoteMessage message) async {
  if (message.data['channel'] != null) {
    showCallNotification(message);
    return;
  }
  final allChatMessages =
      await ChatsRemoteDataSource.fromNotification(message.data)
          .chatRef
          .orderBy('createdAt')
          .get();

  final unreadMessages = allChatMessages.docs
      .map((e) => e.data())
      .where((element) =>
          !(element.messageRead) &&
          element.fromDoctor &&
          element.chatMessage.metadata!['progress'] == 1.0)
      .toList();

  if (unreadMessages.isEmpty) return;

  List<String> messagesTexts = unreadMessages.map(
    (e) {
      if (e.chatMessage is TextMessage) {
        return (e.chatMessage as TextMessage).text;
      }
      if (e.chatMessage is ImageMessage) {
        return 'Image';
      }
      if (e.chatMessage is VideoMessage) {
        return 'Video';
      }
      return 'Voice Message';
    },
  ).toList();

  var androidBitmap =
      await getBase64NetworkImage(unreadMessages.last.senderImageUrl);

  final styleInfo = InboxStyleInformation(messagesTexts);

  final androidNotificationDetails = AndroidNotificationDetails(
    'message',
    'Message',
    channelDescription: 'for receiving messages',
    styleInformation: styleInfo,
    largeIcon: androidBitmap,
    when: int.parse(message.data['createdAt']),
    category: AndroidNotificationCategory.message,
    visibility: NotificationVisibility.private,
    actions: <AndroidNotificationAction>[
      const AndroidNotificationAction(
        'reply',
        'Reply',
        inputs: [
          AndroidNotificationActionInput(
            label: 'Send a message',
          ),
        ],
      ),
      const AndroidNotificationAction(
        'mark',
        'Mark as Read',
        cancelNotification: true,
        titleColor: Colors.red,
      ),
    ],
  );

  final notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await FlutterLocalNotificationsPlugin().show(
    (message.data['doctorId'] as String).hashCode,
    'Dr. ${message.data['senderName']}',
    messagesTexts.last,
    notificationDetails,
    payload: jsonEncode(
      message.data,
    ),
  );
}

@pragma('vm:entry-point')
Future<void> showCallNotification(RemoteMessage message) async {
  // var androidBitmap =
  //     await getBase64NetworkImage(unreadMessages.last.senderImageUrl);

  final androidNotificationDetails = AndroidNotificationDetails(
    'call',
    'Call',
    channelDescription: 'for receiving Calls',
    styleInformation: const DefaultStyleInformation(true, false),
    // largeIcon: androidBitmap,
    importance: Importance.max,
    colorized: true,
    priority: Priority.max,
    ongoing: true,
    category: AndroidNotificationCategory.call,
    visibility: NotificationVisibility.public,
    actions: <AndroidNotificationAction>[
      const AndroidNotificationAction(
        'answer',
        'Answer',
        titleColor: Colors.green,
        icon: DrawableResourceAndroidBitmap(
          '@drawable/ic_accept_call',
        ),
        showsUserInterface: true,
      ),
      const AndroidNotificationAction(
        'reject',
        'Reject',
        titleColor: Colors.red,
        icon: DrawableResourceAndroidBitmap(
          '@drawable/ic_decline_call',
        ),
        showsUserInterface: false,
      ),
    ],
  );

  final notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  await FlutterLocalNotificationsPlugin().show(
    (message.data['doctorId'] as String).hashCode,
    'Call From ${message.data['doctorName']}',
    null,
    notificationDetails,
    payload: jsonEncode(
      message.data,
    ),
  );
}
