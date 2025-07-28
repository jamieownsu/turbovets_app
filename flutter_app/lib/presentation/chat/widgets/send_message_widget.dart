import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/chat/blocs/chat_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMessageWidget extends StatefulWidget {
  final bool isSending;

  const SendMessageWidget({super.key, required this.isSending});

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
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
                  hintStyle: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onSecondaryContainer,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorScheme.tertiary,
                      width: 2,
                    ),
                  ),
                  filled: true,
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
          Container(
            margin: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.secondary, width: 2),
              color: colorScheme.secondaryContainer,
            ),
            child: IconButton(
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
              icon: widget.isSending
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    )
                  : Icon(Icons.send, color: colorScheme.onSecondaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
