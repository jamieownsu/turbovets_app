import 'package:hive/hive.dart';

part 'chat_message.g.dart';

@HiveType(typeId: 1)
enum MessageOriginType {
  @HiveField(0)
  incoming,
  @HiveField(1)
  outgoing,
}

@HiveType(typeId: 0)
class ChatMessage extends HiveObject {
  @HiveField(0)
  final String message;
  @HiveField(1)
  final DateTime timestamp;
  @HiveField(2)
  final MessageOriginType originType;

  ChatMessage({
    required this.message,
    required this.timestamp,
    required this.originType,
  });
}
