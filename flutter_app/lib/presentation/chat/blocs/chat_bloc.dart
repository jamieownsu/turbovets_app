import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entity/message_entity.dart';
import 'package:flutter_app/domain/entity/messages_entity.dart';
import 'package:flutter_app/domain/model/chat_message.dart';
import 'package:flutter_app/domain/usecase/get_messages_usecase.dart';
import 'package:flutter_app/domain/usecase/params/get_messages_params.dart';
import 'package:flutter_app/domain/usecase/params/send_message_params.dart';
import 'package:flutter_app/domain/usecase/send_message_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final String userId;
  final SendMessageUseCase sendMessagesUseCase;
  final GetMessageUseCase getMessagesUseCase;

  ChatBloc({
    required this.userId,
    required this.sendMessagesUseCase,
    required this.getMessagesUseCase,
  }) : super(InitialState(messages: [])) {
    on<SendMessageEvent>(_sendMessage);
    on<GetMessagesEvent>(_getMessages);
  }

  FutureOr<void> _sendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final messages = List.of(state.messages);
      final message = OutgoingChatMessage(
        message: event.message,
        timestamp: DateTime.now(),
      );
      messages.insert(0, message);
      emit(MessageSendingState(messages: messages));
      final response = await sendMessagesUseCase.call(
        SendMessageParams(
          message: event.message,
          userId: userId,
          recipientUserId: event.recipientUserId,
        ),
      );
      if (response is SuccessfulMessageEntity) {
        emit(MessagesUpdatedState(messages: messages));
      }
      // simulate response
      add(GetMessagesEvent(userId: userId));
    } on Exception catch (e) {
      emit(ChatErrorState(messages: state.messages));
      print(e);
      // _loggingService.logError(e);
    }
  }

  FutureOr<void> _getMessages(
    GetMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final response = await getMessagesUseCase.call(
        GetMessagesParams(userId: userId),
      );
      if (response is SuccessfulMessagesEntity) {
        final messages = List.of(state.messages);
        messages.insertAll(0, response.messages);
        emit(MessagesReceivedState(messages: messages));
      }
    } on Exception catch (e) {
      emit(ChatErrorState(messages: state.messages));
      print(e);
      // _loggingService.logError(e);
    }
  }
}
