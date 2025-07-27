import 'package:flutter_app/domain/entity/message_entity.dart';
import 'package:flutter_app/domain/repository/chat_repository.dart';
import 'package:flutter_app/domain/usecase/params/send_message_params.dart';
import 'package:flutter_app/domain/usecase/usecase.dart';

class SendMessageUseCase implements UseCase<MessageEntity, SendMessageParams> {
  final ChatRepository chatRepository;

  SendMessageUseCase({required this.chatRepository});

  @override
  Future<MessageEntity> call(SendMessageParams params) async {
    return await chatRepository.sendMessage(params: params);
  }
}
