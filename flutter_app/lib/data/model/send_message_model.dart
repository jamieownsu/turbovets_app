import 'package:flutter_app/data/model/message_model.dart';

abstract class SendMessageModel {}

class SuccessfulSendMessageModel implements SendMessageModel {
  final MessageModel messageModel;

  SuccessfulSendMessageModel({required this.messageModel});
}

class FailedSendMessageModel implements SendMessageModel {
  FailedSendMessageModel();
}
