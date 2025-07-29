import 'package:flutter_app/domain/entity/chat_message_entity.dart';
import 'package:flutter_app/domain/repository/chat_repository.dart';
import 'package:flutter_app/domain/usecase/params/load_messages_params.dart';
import 'package:flutter_app/domain/usecase/usecase.dart';

class LoadMessagesUseCase
    implements UseCase<List<ChatMessageEntity>, LoadMessagesParams> {
  final ChatRepository chatRepository;

  LoadMessagesUseCase({required this.chatRepository});

  @override
  Future<List<ChatMessageEntity>> call(LoadMessagesParams params) async {
    return await chatRepository.loadMessages(params: params);
  }
}
