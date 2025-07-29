import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entity/chat_message_entity.dart';
import 'package:flutter_app/presentation/chat/blocs/chat_bloc.dart';
import 'package:flutter_app/presentation/chat/widgets/message_bubble_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListSliver extends StatefulWidget {
  final List<ChatMessageEntity> messages;

  const ChatListSliver({super.key, required this.messages});

  @override
  State<ChatListSliver> createState() => _ChatListSliverState();
}

class _ChatListSliverState extends State<ChatListSliver> {
  final GlobalKey<SliverAnimatedListState> listKey =
      GlobalKey<SliverAnimatedListState>();
  final List<ChatMessageEntity> chatlist = [];

  @override
  void initState() {
    super.initState();
    chatlist.addAll(widget.messages);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is MessagesReceivedState || state is MessageSentState) {
          chatlist.insert(0, state.messages.first);
          listKey.currentState?.insertItem(0, duration: Durations.short4);
        }
      },
      child: SliverAnimatedList(
        key: listKey,
        initialItemCount: chatlist.length,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
            key: ValueKey(chatlist[index]),
            sizeFactor: animation,
            axisAlignment: 0.0,
            child: MessageBubbleWidget(chatMessage: chatlist[index]),
          );
        },
      ),
    );
  }
}
