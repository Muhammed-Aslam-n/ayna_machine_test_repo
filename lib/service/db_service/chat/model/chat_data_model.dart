import 'package:hive_flutter/hive_flutter.dart';

part 'chat_data_model.g.dart';

@HiveType(typeId: 4)
class ChatDataModel {
  @HiveField(0)
  final int senderId;
  @HiveField(1)
  final String senderName;
  @HiveField(2)
  final String message;
  @HiveField(3)
  final DateTime messageTimestamp;

  @HiveField(4)
  final bool sentByUser;

  ChatDataModel({
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.messageTimestamp,
    required this.sentByUser,
  });
}
