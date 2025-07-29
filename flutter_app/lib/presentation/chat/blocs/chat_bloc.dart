import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entity/chat_message_entity.dart';
import 'package:flutter_app/domain/entity/message_entity.dart';
import 'package:flutter_app/domain/entity/messages_entity.dart';
import 'package:flutter_app/domain/usecase/get_messages_usecase.dart';
import 'package:flutter_app/domain/usecase/load_messages_usecase.dart';
import 'package:flutter_app/domain/usecase/params/get_messages_params.dart';
import 'package:flutter_app/domain/usecase/params/load_messages_params.dart';
import 'package:flutter_app/domain/usecase/params/send_message_params.dart';
import 'package:flutter_app/domain/usecase/send_message_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final String userId;
  final LoadMessagesUseCase loadMessagesUseCase;
  final SendMessageUseCase sendMessagesUseCase;
  final GetMessageUseCase getMessagesUseCase;

  ChatBloc({
    required this.userId,
    required this.loadMessagesUseCase,
    required this.sendMessagesUseCase,
    required this.getMessagesUseCase,
  }) : super(InitialState(messages: [])) {
    on<LoadMessagesEvent>(_loadMessages);
    on<SendMessageEvent>(_sendMessage);
    on<GetMessagesEvent>(_getMessages);
  }
  FutureOr<void> _loadMessages(
    LoadMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final messages = await loadMessagesUseCase.call(
        LoadMessagesParams(userId: userId),
      );
      emit(MessagesLoadedState(messages: messages));
    } on Exception {
      emit(ChatErrorState(messages: state.messages));
    }
  }

  FutureOr<void> _sendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(MessageSendingState(messages: state.messages));
      final response = await sendMessagesUseCase.call(
        SendMessageParams(
          message: event.message,
          userId: userId,
          recipientUserId: event.recipientUserId,
        ),
      );
      if (response is SuccessfulMessageEntity) {
        final messages = List.of(state.messages);
        final message = response.message;
        messages.insert(0, message);
        emit(MessageSentState(messages: messages));
      }
      // simulate response
      add(GetMessagesEvent(userId: userId));
    } on Exception {
      emit(ChatErrorState(messages: state.messages));
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
        final newMessages = response.messages;
        final messages = List.of(state.messages);
        messages.insertAll(0, newMessages);
        emit(MessagesReceivedState(messages: messages));
      }
    } on Exception {
      emit(ChatErrorState(messages: state.messages));
    }
  }
}
