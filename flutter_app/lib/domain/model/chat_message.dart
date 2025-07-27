sealed class ChatMessage {
  final String message;
  final DateTime timestamp;

  ChatMessage({required this.message, required this.timestamp});
}

class IncomingChatMessage extends ChatMessage {
  IncomingChatMessage({required super.message, required super.timestamp});
}

class OutgoingChatMessage extends ChatMessage {
  OutgoingChatMessage({required super.message, required super.timestamp});
}
