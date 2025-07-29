import 'dart:async';

import 'package:flutter_app/data/datasource/chat_datasource.dart';
import 'package:flutter_app/data/model/get_messages_model.dart';
import 'package:flutter_app/data/model/send_message_model.dart';
import 'package:flutter_app/domain/entity/chat_message_entity.dart';
import 'package:flutter_app/domain/entity/message_entity.dart';
import 'package:flutter_app/domain/entity/messages_entity.dart';
import 'package:flutter_app/domain/repository/chat_repository.dart';
import 'package:flutter_app/domain/usecase/params/get_messages_params.dart';
import 'package:flutter_app/domain/usecase/params/load_messages_params.dart';
import 'package:flutter_app/domain/usecase/params/send_message_params.dart';
import 'package:hive/hive.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatDatasource datasource;
  final Box<ChatMessageEntity> chatBox;

  ChatRepositoryImpl({required this.datasource, required this.chatBox});

  @override
  Future<List<ChatMessageEntity>> loadMessages({
    required LoadMessagesParams params,
  }) async {
    final messages = chatBox.values.toList();
    messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return messages.reversed.toList();
  }

  @override
  Future<MessageEntity> sendMessage({required SendMessageParams params}) async {
    final response = await datasource.sendMessage(
      message: params.message,
      userId: params.userId,
    );
    if (response is SuccessfulSendMessageModel) {
      final messageModel = response.messageModel;
      final message = messageModel.message;
      final timestamp = messageModel.timestamp;
      final chatMessage = ChatMessageEntity(
        message: message,
        timestamp: timestamp,
        originType: MessageOriginType.outgoing,
      );
      chatBox.add(chatMessage);
      return SuccessfulMessageEntity(message: chatMessage);
    } else {
      return FailedMessageEntity();
    }
  }

  @override
  Future<MessagesEntity> getMessages({
    required GetMessagesParams params,
  }) async {
    final response = await datasource.getMessages(userId: params.userId);
    if (response is SuccessfulGetMessagesModel) {
      return SuccessfulMessagesEntity(
        messages: response.messages.map((e) {
          final chatMessage = ChatMessageEntity(
            message: e.message,
            timestamp: e.timestamp,
            originType: MessageOriginType.incoming,
          );
          chatBox.add(chatMessage);
          return chatMessage;
        }).toList(),
      );
    } else {
      return FailedMessagesEntity();
    }
  }
}
