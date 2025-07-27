part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  final List<ChatMessage> messages;

  const ChatState({required this.messages});
}

class InitialState extends ChatState {
  const InitialState({required super.messages});

  @override
  List<Object?> get props => [messages];
}

class MessageSendingState extends ChatState {
  const MessageSendingState({required super.messages});

  @override
  List<Object?> get props => [messages];
}

class MessagesUpdatedState extends ChatState {
  const MessagesUpdatedState({required super.messages});

  @override
  List<Object?> get props => [messages];
}

class MessagesReceivedState extends ChatState {
  const MessagesReceivedState({required super.messages});

  @override
  List<Object?> get props => [messages];
}

class ChatErrorState extends ChatState {
  const ChatErrorState({required super.messages});

  @override
  List<Object?> get props => [messages];
}
