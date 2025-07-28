import 'package:flutter/material.dart';
import 'package:flutter_app/domain/usecase/get_messages_usecase.dart';
import 'package:flutter_app/domain/usecase/load_messages_usecase.dart';
import 'package:flutter_app/domain/usecase/send_message_usecase.dart';
import 'package:flutter_app/presentation/chat/blocs/chat_bloc.dart';
import 'package:flutter_app/presentation/chat/widgets/message_bubble_widget.dart';
import 'package:flutter_app/presentation/chat/widgets/send_message_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
      create: (context) => ChatBloc(
        userId: "123456",
        loadMessagesUseCase: context.read<LoadMessagesUseCase>(),
        sendMessagesUseCase: context.read<SendMessageUseCase>(),
        getMessagesUseCase: context.read<GetMessageUseCase>(),
      )..add(LoadMessagesEvent()),
      child: ChatPageView(),
    );
  }
}

class ChatPageView extends StatefulWidget {
  const ChatPageView({super.key});

  @override
  State<ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  final GlobalKey<SliverAnimatedListState> listKey =
      GlobalKey<SliverAnimatedListState>();

  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is MessagesReceivedState) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
            );
          }
        } else if (state is ChatErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Something went wrong!",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
            ),
          );
        }
      },
      builder: (context, state) {
        final messages = state.messages;
        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                controller: scrollController,
                reverse: true,
                slivers: [
                  SliverList.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return MessageBubbleWidget(chatMessage: message);
                    },
                  ),
                ],
              ),
            ),
            SendMessageWidget(isSending: state is MessageSendingState),
          ],
        );
      },
    );
  }
}
