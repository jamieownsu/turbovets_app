import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/chat_message.dart';
import 'package:flutter_app/presentation/chat/mixin/timestamp_mixin.dart';

class ChatMessageWidget extends StatelessWidget with TimestampMixin {
  final ChatMessage message;

  const ChatMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Align(
      alignment: message is IncomingChatMessage
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width * .75),
        child: Card(
          color: message is IncomingChatMessage
              ? Colors.lightBlueAccent
              : Colors.greenAccent,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.message,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  formatSentTimestamp(message.timestamp),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
