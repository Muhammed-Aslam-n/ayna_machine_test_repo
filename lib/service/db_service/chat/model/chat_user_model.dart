
import 'package:hive_flutter/hive_flutter.dart';

part 'chat_user_model.g.dart';

@HiveType(typeId: 1)
class ChatUserProfileDB {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String picture;
  @HiveField(4)
  final bool isOnline;
  @HiveField(5)
  final bool hasUnreadMessage;
  @HiveField(6)
  final String lastMessage;
  @HiveField(7)
  final DateTime lastMessageTimestamp;

  ChatUserProfileDB({
    required this.id,
    required this.name,
    required this.username,
    required this.picture,
    required this.isOnline,
    required this.hasUnreadMessage,
    required this.lastMessage,
    required this.lastMessageTimestamp,
  });
}
