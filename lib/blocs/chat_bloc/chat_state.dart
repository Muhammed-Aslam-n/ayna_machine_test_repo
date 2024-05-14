part of 'chat_bloc.dart';

/*
ChatInitialState (initial state)
ChatLoadingState (indicates message sending in progress)
ChatSuccessState (message sent successfully)
ChatErrorState (error occurred while sending message)
MessagesReceivedState (contains a list of received messages)
* */
sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitialState extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoadingState extends ChatState {
  @override
  List<Object> get props => [];
}
class ChatSuccessState extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatSyncingState extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatSyncedState extends ChatState {
  @override
  List<Object> get props => [];
}
class ChatSyncFailedState extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatErrorState extends ChatState {
  final String error;

  const ChatErrorState(this.error);
  @override
  List<Object> get props => [error];
}
class ChatExceptionState extends ChatState {
  final String message;

  const ChatExceptionState(this.message);
  @override
  List<Object> get props => [message];
}
class MessagesReceivedState extends ChatState {
  final List<String> messages;

  const MessagesReceivedState(this.messages);
  @override
  List<Object> get props => [messages];
}