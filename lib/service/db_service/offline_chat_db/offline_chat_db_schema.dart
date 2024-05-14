import 'package:hive/hive.dart';

part 'offline_chat_db_schema.g.dart';

@HiveType(typeId: 2)
class OfflineChatDBSchema {
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

  OfflineChatDBSchema({
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.messageTimestamp,
    required this.sentByUser,
  });
}
