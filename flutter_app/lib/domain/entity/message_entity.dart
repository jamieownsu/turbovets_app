import 'package:flutter_app/domain/model/chat_message.dart';

abstract class MessageEntity {}

class SuccessfulMessageEntity extends MessageEntity {
  final ChatMessage message;

  SuccessfulMessageEntity({required this.message});
}

class FailedMessageEntity extends MessageEntity {
  FailedMessageEntity();
}
