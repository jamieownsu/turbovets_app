import 'package:flutter_app/data/model/message_model.dart';

class GetMessagesModel {}

class SuccessfulGetMessagesModel implements GetMessagesModel {
  final List<MessageModel> messages;

  SuccessfulGetMessagesModel({required this.messages});
}

class FailedGetMessagesModel implements GetMessagesModel {
  FailedGetMessagesModel();
}
