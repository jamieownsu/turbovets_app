import 'package:flutter_app/domain/model/chat_message.dart';
import 'package:flutter_app/domain/repository/chat_repository.dart';
import 'package:flutter_app/domain/usecase/params/load_messages_params.dart';
import 'package:flutter_app/domain/usecase/usecase.dart';

class LoadMessagesUseCase
    implements UseCase<List<ChatMessage>, LoadMessagesParams> {
  final ChatRepository chatRepository;

  LoadMessagesUseCase({required this.chatRepository});

  @override
  Future<List<ChatMessage>> call(LoadMessagesParams params) async {
    return await chatRepository.loadMessages(params: params);
  }
}
