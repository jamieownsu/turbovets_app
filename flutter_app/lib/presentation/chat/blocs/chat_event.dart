part of 'chat_bloc.dart';

abstract class ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String message;
  final String recipientUserId;

  SendMessageEvent({required this.message, required this.recipientUserId});
}

class GetMessagesEvent extends ChatEvent {
  final String userId;

  GetMessagesEvent({required this.userId});
}
