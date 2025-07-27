import 'package:flutter_app/domain/entity/messages_entity.dart';
import 'package:flutter_app/domain/repository/chat_repository.dart';
import 'package:flutter_app/domain/usecase/params/get_messages_params.dart';
import 'package:flutter_app/domain/usecase/usecase.dart';

class GetMessageUseCase implements UseCase<MessagesEntity, GetMessagesParams> {
  final ChatRepository chatRepository;

  GetMessageUseCase({required this.chatRepository});

  @override
  Future<MessagesEntity> call(GetMessagesParams params) async {
    return await chatRepository.getMessages(params: params);
  }
}
