part of 'chat_room_cubit.dart';

abstract class ChatRoomState extends Equatable {
  const ChatRoomState();
}

class ChatRoomInitial extends ChatRoomState {
  @override
  List<Object> get props => [];
}
