// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_chat_db_schema.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineChatDBSchemaAdapter extends TypeAdapter<OfflineChatDBSchema> {
  @override
  final int typeId = 2;

  @override
  OfflineChatDBSchema read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineChatDBSchema(
      senderId: fields[0] as int,
      senderName: fields[1] as String,
      message: fields[2] as String,
      messageTimestamp: fields[3] as DateTime,
      sentByUser: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, OfflineChatDBSchema obj) {
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
      other is OfflineChatDBSchemaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
