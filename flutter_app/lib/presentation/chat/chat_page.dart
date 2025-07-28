import 'package:flutter/material.dart';
import 'package:flutter_app/domain/usecase/get_messages_usecase.dart';
import 'package:flutter_app/domain/usecase/load_messages_usecase.dart';
import 'package:flutter_app/domain/usecase/send_message_usecase.dart';
import 'package:flutter_app/presentation/chat/blocs/chat_bloc.dart';
import 'package:flutter_app/presentation/chat/widgets/chat_message.dart';
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
  final formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void dispose() {
    textController.dispose();
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
                      return ChatMessageWidget(chatMessage: message);
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(50),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a message';
                          }
                          return null;
                        },
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        onFieldSubmitted: (value) {
                          if (formKey.currentState?.validate() == true) {
                            context.read<ChatBloc>().add(
                              SendMessageEvent(
                                message: value,
                                recipientUserId: "654321",
                              ),
                            );
                            textController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        final message = textController.text;
                        context.read<ChatBloc>().add(
                          SendMessageEvent(
                            message: message,
                            recipientUserId: "654321",
                          ),
                        );
                        textController.clear();
                      }
                    },
                    icon: state is MessageSendingState
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )
                        : Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
