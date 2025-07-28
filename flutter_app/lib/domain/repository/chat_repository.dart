import 'package:flutter_app/domain/entity/message_entity.dart';
import 'package:flutter_app/domain/entity/messages_entity.dart';
import 'package:flutter_app/domain/model/chat_message.dart';
import 'package:flutter_app/domain/usecase/params/get_messages_params.dart';
import 'package:flutter_app/domain/usecase/params/load_messages_params.dart';
import 'package:flutter_app/domain/usecase/params/send_message_params.dart';

abstract class ChatRepository {
  Future<List<ChatMessage>> loadMessages({required LoadMessagesParams params});

  Future<MessageEntity> sendMessage({required SendMessageParams params});

  Future<MessagesEntity> getMessages({required GetMessagesParams params});
}
