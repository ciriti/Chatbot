import 'package:chatbot/src/data/chat_api.dart';

import 'package:chatbot/src/application/services/model_provider_service.dart';

class ChatRepository {
  final ChatApi _api;
  final ModelProviderService _modelProviderService;

  ChatRepository(this._api, this._modelProviderService);

  Future<String> getChatResponse(
      String message, String providerName, String modelName) async {
    // Pass the providerName and message to ChatApi to handle the API call
    return await _api.sendMessage(message, providerName, modelName);
  }
}
