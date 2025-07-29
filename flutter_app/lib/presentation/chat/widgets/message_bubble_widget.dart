import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entity/chat_message_entity.dart';
import 'package:flutter_app/presentation/chat/mixins/timestamp_mixin.dart';

class MessageBubbleWidget extends StatelessWidget with TimestampMixin {
  final ChatMessageEntity chatMessage;

  const MessageBubbleWidget({super.key, required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                Text(
                  message,
                  style: textTheme.titleLarge!.copyWith(color: Colors.black),
                ),
                Text(
                  formatSentTimestamp(timestamp),
                  style: textTheme.labelSmall!.copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
