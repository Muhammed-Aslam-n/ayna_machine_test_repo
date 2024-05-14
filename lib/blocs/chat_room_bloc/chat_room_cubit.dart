import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../screens/home/model/chat_room.dart';

part 'chat_room_state.dart';

class ChatRoomsCubit extends Cubit<ChatRoom?> {
  ChatRoomsCubit() : super(null);

  void selectRoom(ChatRoom room) {
    emit(room);
  }

  void unSelectRoom() {
    emit(null);
  }
}