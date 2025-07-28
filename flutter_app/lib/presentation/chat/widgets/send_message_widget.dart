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
    return Container(
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
                  SendMessageEvent(message: message, recipientUserId: "654321"),
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
                : Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
