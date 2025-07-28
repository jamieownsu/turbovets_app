import 'dart:math';

import 'package:flutter_app/data/model/get_messages_model.dart';
import 'package:flutter_app/data/model/message_model.dart';
import 'package:flutter_app/data/model/send_message_model.dart';

final List<String> _messages = [
  "Hello!",
  "Hi there!",
  "How are you doing today?",
  "I'm good, thanks! And you?",
  "All good!",
  "This is a long message to test scrolling. It should wrap around and be visible.",
  "Another message.",
  "Yet another message.",
  "One more message for good measure.",
  "And a final one to make sure we have enough content to scroll.",
  "Hello!",
  "Hi there!",
  "How are you doing today?",
  "I'm good, thanks! And you?",
  "All good!",
  "This is a long message to test scrolling. It should wrap around and be visible.",
  "Another message.",
  "Yet another message.",
  "One more message for good measure.",
  "And a final one to make sure we have enough content to scroll.",
];

abstract class ChatDatasource {
  Future<SendMessageModel> sendMessage({
    required String message,
    required String userId,
  });

  Future<GetMessagesModel> getMessages({required String userId});
}

class ChatDatasourceImpl extends ChatDatasource {
  @override
  Future<SendMessageModel> sendMessage({
    required String message,
    required String userId,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return SuccessfulSendMessageModel(
      messageModel: MessageModel(message: message, timestamp: DateTime.now()),
    );
  }

  @override
  Future<GetMessagesModel> getMessages({required String userId}) async {
    await Future.delayed(Duration(seconds: 3));
    final message = MessageModel(
      message: _messages[Random().nextInt(20)],
      timestamp: DateTime.now(),
    );
    return SuccessfulGetMessagesModel(messages: [message]);
  }
}
