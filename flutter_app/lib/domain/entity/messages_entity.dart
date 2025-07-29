import 'package:flutter_app/domain/entity/chat_message_entity.dart';

abstract class MessagesEntity {}

class SuccessfulMessagesEntity extends MessagesEntity {
  final List<ChatMessageEntity> messages;

  SuccessfulMessagesEntity({required this.messages});
}

class FailedMessagesEntity extends MessagesEntity {
  FailedMessagesEntity();
}
