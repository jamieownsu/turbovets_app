part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  final List<ChatMessageEntity> messages;

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

class MessagesLoadedState extends ChatState {
  const MessagesLoadedState({required super.messages});

  @override
  List<Object?> get props => [messages];
}

class MessageSentState extends ChatState {
  const MessageSentState({required super.messages});

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
