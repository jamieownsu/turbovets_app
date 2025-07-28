import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/chat_message.dart';
import 'package:flutter_app/presentation/chat/mixins/timestamp_mixin.dart';

class MessageBubbleWidget extends StatelessWidget with TimestampMixin {
  final ChatMessage chatMessage;

  const MessageBubbleWidget({super.key, required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final orignType = chatMessage.originType;
    final message = chatMessage.message;
    final timestamp = chatMessage.timestamp;
    return Align(
      alignment: switch (orignType) {
        MessageOriginType.incoming => Alignment.centerLeft,
        MessageOriginType.outgoing => Alignment.centerRight,
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width * .75),
        child: Card(
          color: switch (orignType) {
            MessageOriginType.incoming => Colors.lightBlueAccent,
            MessageOriginType.outgoing => Colors.greenAccent,
          },
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message, style: Theme.of(context).textTheme.titleLarge),
                Text(
                  formatSentTimestamp(timestamp),
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
