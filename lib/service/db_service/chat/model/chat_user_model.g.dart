// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatUserProfileDBAdapter extends TypeAdapter<ChatUserProfileDB> {
  @override
  final int typeId = 1;

  @override
  ChatUserProfileDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatUserProfileDB(
      id: fields[0] as String,
      name: fields[1] as String,
      username: fields[2] as String,
      picture: fields[3] as String,
      isOnline: fields[4] as bool,
      hasUnreadMessage: fields[5] as bool,
      lastMessage: fields[6] as String,
      lastMessageTimestamp: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ChatUserProfileDB obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.picture)
      ..writeByte(4)
      ..write(obj.isOnline)
      ..writeByte(5)
      ..write(obj.hasUnreadMessage)
      ..writeByte(6)
      ..write(obj.lastMessage)
      ..writeByte(7)
      ..write(obj.lastMessageTimestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatUserProfileDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
