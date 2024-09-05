// lib/src/data/chat_repository.dart
import 'package:ztc/src/data/chat_api.dart';

class ChatRepository {
  final ChatApi _api;

  ChatRepository(this._api);

  Future<String> getChatResponse(String message) async {
    return await _api.sendMessage(message);
  }
}
