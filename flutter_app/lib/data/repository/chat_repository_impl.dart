import 'dart:async';

import 'package:flutter_app/data/datasource/chat_datasource.dart';
import 'package:flutter_app/data/model/get_messages_model.dart';
import 'package:flutter_app/data/model/send_message_model.dart';
import 'package:flutter_app/domain/entity/message_entity.dart';
import 'package:flutter_app/domain/entity/messages_entity.dart';
import 'package:flutter_app/domain/model/chat_message.dart';
import 'package:flutter_app/domain/repository/chat_repository.dart';
import 'package:flutter_app/domain/usecase/params/get_messages_params.dart';
import 'package:flutter_app/domain/usecase/params/send_message_params.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatDatasource datasource;

  ChatRepositoryImpl({required this.datasource});

  @override
  Future<MessageEntity> sendMessage({required SendMessageParams params}) async {
    final response = await datasource.sendMessage(
      message: params.message,
      userId: params.userId,
    );
    if (response is SuccessfulSendMessageModel) {
      return SuccessfulMessageEntity();
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
        messages: response.messages
            .map(
              (e) => IncomingChatMessage(
                message: e.message,
                timestamp: e.timestamp,
              ),
            )
            .toList(),
      );
    } else {
      return FailedMessagesEntity();
    }
  }
}
