import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doclink3/core/router/app_router.dart';
import 'package:doclink3/domain/entities/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/providers/shared_preferences_provider.dart';
import '../../../core/providers/language_provider.dart';
import '../../../core/utilities/chat_screen_messages_handler.dart';
import '../../../core/utilities/messages_read_handler.dart';
import '../../../data/data source/chats_remote_data_source.dart';
import '../../../data/data source/doctor_remote_data_source.dart';
import '../../../data/data source/patient_remote_date_source.dart';
import '../../widgets/messages_screen_related/audio_playing/my_audio_player_widget.dart';
import '../../widgets/messages_screen_related/bottom_bar_related/main_bottom_widget.dart';
import '../../widgets/messages_screen_related/image_viewing/main_image_viewer.dart';
import '../../widgets/messages_screen_related/text_message_related/text_bubble.dart';
import '../../widgets/messages_screen_related/text_message_related/text_message.dart';
import '../../widgets/messages_screen_related/video_playing/main_player.dart';
import '../../../core/utilities/widget_helper.dart';

@RoutePage()
class ChatScreen extends HookConsumerWidget {
  const ChatScreen({
    @PathParam('chat_id') this.chatId,
    Key? key,
  }) : super(key: key);
  final String? chatId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(languageProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final mq = MediaQuery.of(context).size;
    return ref.watch(patientRemoteDataSourceProvider).when(
          data: (data) {
            final chatInfo = ref.watch(chatInfoProvider);
            final chatRemoteDatasource = ref.watch(
              chatNotifierProvider(chatId),
            );
            if (chatId != null) {
              useEffect(
                () {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      ref.invalidate(chatInfoProvider);
                      ref.read(chatInfoProvider.notifier).update(
                            (state) => data!.chatList
                                .where((element) => element.chatId == chatId!)
                                .first,
                          );
                    },
                  );
                  return null;
                },
                [chatId],
              );
            }
            final messagesStream = useStream(
              useMemoized(
                () => chatRemoteDatasource.chatRef
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
              ),
            );
            return Builder(builder: (context) {
              if (chatInfo == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return WillPopScope(
                onWillPop: () async {
                  if (context.router.canPop()) {
                    return true;
                  }
                  context.router.replace(const NestedMessagesRoute());
                  return false;
                },
                child: Scaffold(
                  appBar: AppBar(
                    titleSpacing: 0,
                    leading: IconButton(
                      onPressed: () async {
                        if (context.router.canPop()) {
                          context.popRoute();
                          return;
                        }
                        context.router.replace(const NestedMessagesRoute());
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            chatInfo.receiverImageUrl,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('Dr. ${chatInfo.receiverName}'),
                      ],
                    ),
                    actions: [
                      IconButton(
                        onPressed: () async {
                          await ref
                              .read(doctorsNotifierProvider.notifier)
                              .startCall(
                                chatInfo.patientId,
                                chatInfo.patientId,
                                chatInfo.doctorId,
                                data!.name,
                              );
                          await ref
                              .read(patientRemoteDataSourceProvider.notifier)
                              .startCall(
                                chatInfo.patientId,
                                chatInfo.patientId,
                                chatInfo.doctorId,
                              );
                        },
                        icon: const Icon(Icons.call),
                      ),
                    ],
                  ),
                  body: Builder(
                    builder: (context) {
                      if (!(messagesStream.hasData)) {
                        return Center(
                          child: SpinKitChasingDots(
                            color: colorScheme.primary,
                          ),
                        );
                      }
                      handleOutsideUnreadMessagesFromChatScreen(chatInfo);
                      markMessagesAsRead(chatRemoteDatasource);
                      //remove any notification related to this doctor
                      print(GetIt.I.get<AppRouter>().currentSegments.last.name);
                      if (GetIt.I.get<AppRouter>().currentSegments.last.name ==
                          ChatRoute.name) {
                        FlutterLocalNotificationsPlugin()
                            .cancel(chatInfo.doctorId.hashCode);
                      }
                      // My defined messages
                      final filteredMessages =
                          filterChatMessages(messagesStream);
                      // Chat package messages
                      final chatFilteredMessages =
                          getMessageFromChatMessage(filteredMessages);
                      final brightness = ref.watch(themeProvider);
                      return Chat(
                        theme: brightness == Brightness.light
                            ? const DefaultChatTheme()
                            : const DarkChatTheme(),
                        messages: chatFilteredMessages,
                        bubbleBuilder: (child,
                                {required message,
                                required nextMessageInGroup}) =>
                            MyTextBubbleBuilder(
                          nextMessageInGroup: nextMessageInGroup,
                          isSender: message.author.id == chatInfo.patientId,
                          child: child,
                        ),
                        onSendPressed: (_) {},
                        customBottomWidget:
                            MainBottomWidget(chatInfo: chatInfo),
                        disableImageGallery: true,
                        imageMessageBuilder: (imageMessage,
                            {required messageWidth}) {
                          return MyImageMessage(
                            mq: mq,
                            imageMessage: imageMessage,
                          );
                        },
                        textMessageBuilder: (
                          textMessage, {
                          required messageWidth,
                          required showName,
                        }) {
                          final chatMessage = filteredMessages
                              .where((element) =>
                                  element.chatMessage == textMessage)
                              .first;
                          return MyTextMessage(
                            chatMessage: chatMessage,
                            textMessage: textMessage,
                            chatInfo: chatInfo,
                          );
                        },
                        audioMessageBuilder: (audioMessage,
                            {required messageWidth}) {
                          return MyAudioPlayer(audioMessage: audioMessage);
                        },
                        videoMessageBuilder: (videoMessage,
                            {required messageWidth}) {
                          return MyVideoMessage(
                            videoMessage: videoMessage,
                            mq: mq,
                          );
                        },
                        user: types.User(
                          id: chatInfo.patientId,
                          firstName: chatInfo.senderName,
                        ),
                      );
                    },
                  ),
                ).wrapWithKeyboardRemover.getDoctorAndPatientInfo(
                      ref,
                    ),
              );
            });
          },
          error: (error, stackTrace) => const Center(
            child: Text('Error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
