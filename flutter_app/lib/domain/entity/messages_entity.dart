import 'package:flutter_app/domain/model/chat_message.dart';

abstract class MessagesEntity {}

class SuccessfulMessagesEntity extends MessagesEntity {
  final List<ChatMessage> messages;

  SuccessfulMessagesEntity({required this.messages});
}

class FailedMessagesEntity extends MessagesEntity {
  FailedMessagesEntity();
}
