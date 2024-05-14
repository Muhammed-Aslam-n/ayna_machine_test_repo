// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatDataModelAdapter extends TypeAdapter<ChatDataModel> {
  @override
  final int typeId = 4;

  @override
  ChatDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatDataModel(
      senderId: fields[0] as int,
      senderName: fields[1] as String,
      message: fields[2] as String,
      messageTimestamp: fields[3] as DateTime,
      sentByUser: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ChatDataModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.senderId)
      ..writeByte(1)
      ..write(obj.senderName)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.messageTimestamp)
      ..writeByte(4)
      ..write(obj.sentByUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
