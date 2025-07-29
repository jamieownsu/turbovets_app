import 'package:flutter_app/domain/entity/chat_message_entity.dart';

abstract class MessageEntity {}

class SuccessfulMessageEntity extends MessageEntity {
  final ChatMessageEntity message;

  SuccessfulMessageEntity({required this.message});
}

class FailedMessageEntity extends MessageEntity {
  FailedMessageEntity();
}
