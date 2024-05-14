import 'dart:async';

import 'package:ayna_machine_test/service/connectivity/connectivity_service.dart';
import 'package:ayna_machine_test/service/db_service/chat/chat_config.dart';
import 'package:ayna_machine_test/service/db_service/chat/model/chat_data_model.dart';
import 'package:ayna_machine_test/service/db_service/offline_chat_db/offline_chat_config.dart';
import 'package:ayna_machine_test/service/db_service/offline_chat_db/offline_chat_db_schema.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final WebSocketChannel channel;

  ChatBloc(this.channel) : super(ChatInitialState()) {
    int recentSenderId = 0;
    String recentSenderName = '';
    DateTime recentMessageTimeStamp = DateTime.now();
    on<SyncOfflineMessagesEvent>((event, emit) async {
      emit(ChatSyncingState());
      await Future.delayed(const Duration(seconds: 1));
      try {
        for (var element
            in OfflineChatDBServiceImpl().messagesStream.value.values) {
          final syncMessage = await sendMessage(element.message);
          if (syncMessage != null) {
            final storeChatRes = await storeMessage(
              ChatDataModel(
                senderId: element.senderId,
                senderName: element.senderName,
                message: element.message,
                messageTimestamp: element.messageTimestamp,
                sentByUser: element.sentByUser

              ),
            );
          } else {
            emit(ChatSyncFailedState());
            emit(ChatInitialState());
            return;
          }
        }
      } catch (exc, stack) {
        emit(ChatSyncFailedState());
        emit(ChatInitialState());
        return;
      }
      await OfflineChatDBServiceImpl().clearOfflineDB();
      emit(ChatSyncedState());
      emit(ChatInitialState());
    });

    on<SendMessageEvent>((event, emit) async {
      try {
        if (await ConnectivityService.isAvailable()) {
          final sendMessageRes = await sendMessage(event.chatData.message);
          recentSenderId = event.chatData.senderId;
          recentMessageTimeStamp = event.chatData.messageTimestamp;
          recentSenderName = event.chatData.senderName;
          if (sendMessageRes) {
            final storeChatRes = await storeMessage(event.chatData);
            if (storeChatRes != null) {
              emit(ChatSuccessState());
            } else {
              emit(const ChatErrorState('Some error occurred'));
            }
          } else {
            emit(const ChatErrorState('Some error occurred'));
          }
        } else {
          final storeOfflineRes = await storeOfflineMessages(
            OfflineChatDBSchema(
              senderId: event.chatData.senderId,
              senderName: event.chatData.senderName,
              message: event.chatData.message,
              messageTimestamp: event.chatData.messageTimestamp,
              sentByUser: true,
            ),
          );
          if (storeOfflineRes != null) {
            debugPrint('storedInOfflineDB');
            emit(ChatSuccessState());
          } else {
            emit(const ChatErrorState('Some error occurred'));
          }
        }
      } catch (exc, stack) {
        debugPrint('ExceptionWhileSendingMessage $exc \n $stack');
        emit(const ChatErrorState('Some error occurred'));
      }
    });
    on<MessageReceivedEvent>((event, emit) async {
      final String message = event.message;
      final storeChatRes = await storeMessage(
        ChatDataModel(
          senderId: recentSenderId,
          senderName: recentSenderName,
          message: message,
          messageTimestamp: recentMessageTimeStamp,
          sentByUser: false,
        ),
      );
      if (storeChatRes != null) {
        emit(MessagesReceivedState([message]));
      } else {
        emit(const ChatErrorState('Some error occurred'));
      }
    });

    channel.stream.listen((message) {
      debugPrint('**** MessageReceivedOnListener $message');
      if (!message
          .toString()
          .toLowerCase()
          .trim()
          .contains('Request served by'.toLowerCase())) {
        add(MessageReceivedEvent(message)); // Emit MessageReceivedEvent
      }
    });
  }

  sendMessage(String message) async {
    try {
      await channel.ready;
      channel.sink.add(message);
      return true;
    } catch (exc, stack) {
      debugPrint('ExceptionCaughtWhileSendingMessage $exc \n $stack');
      return false;
    }
  }

  storeMessage(ChatDataModel chatData) async {
    try {
      await ChatDBServiceImpl().storeMessage(chatData);
      return true;
    } catch (exc, stack) {
      debugPrint('ExceptionCaughtWhileSavingRecentMessage $exc \n $stack');
      return false;
    }
  }

  storeOfflineMessages(OfflineChatDBSchema offlineChatData) async {
    try {
      await OfflineChatDBServiceImpl().storeMessage(
        offlineChatData,
      );
      return true;
    } catch (exc, stack) {
      debugPrint('ExceptionCaughtWhileSavingRecentMessage $exc \n $stack');
      return false;
    }
  }
}
