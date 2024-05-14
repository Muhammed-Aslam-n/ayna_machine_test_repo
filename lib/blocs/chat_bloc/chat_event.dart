part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SyncOfflineMessagesEvent extends ChatEvent {

  const SyncOfflineMessagesEvent();

  @override
  List<Object> get props => [];
}
class SendMessageEvent extends ChatEvent {
  final ChatDataModel chatData;

  const SendMessageEvent(this.chatData);

  @override
  List<Object> get props => [chatData];
}

class MessageReceivedEvent extends ChatEvent {

  final String message;

  const MessageReceivedEvent(this.message);

  @override
  List<Object> get props => [message];
}
