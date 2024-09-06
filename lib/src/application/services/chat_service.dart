import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ztc/src/domain/chat_message.dart';
import 'package:ztc/src/providers/chat_providers.dart';

part 'chat_service.g.dart';

@riverpod
class ChatService extends _$ChatService {
  @override
  List<ChatMessage> build() => [];

  Future<void> sendMessage(String userMessage) async {
    state = [...state, ChatMessage(content: userMessage, isBot: false)];

    final repository = ref.read(chatRepositoryProvider);
    final botResponse = await repository.getChatResponse(userMessage);

    state = [...state, ChatMessage(content: botResponse, isBot: true)];
  }
}
