import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:chatbot/src/application/services/model_provider_config.dart';

class ModelProviderService {
  final Map<String, ModelProviderConfig Function(String modelName)> _providers;

  ModelProviderService()
      : _providers = {
          'OpenAI': (String modelName) => ModelProviderConfig(
                apiUrl: 'https://api.openai.com/v1/chat/completions',
                model: modelName,
                buildRequestData: (String message) => {
                  'model': modelName,
                  'messages': [
                    {'role': 'user', 'content': message}
                  ]
                },
                buildHeaders: (String apiKey) => {
                  'Authorization': 'Bearer $apiKey',
                },
              ),
        };

  ModelProviderConfig getProviderConfig(String providerName, String modelName) {
    final providerConfigBuilder = _providers[providerName];
    if (providerConfigBuilder != null) {
      return providerConfigBuilder(modelName);
    }
    throw Exception('Provider not found for $providerName');
  }

  String? getApiKey(String providerName) {
    switch (providerName) {
      case 'OpenAI':
        return dotenv.env['OPENAI_API_KEY'];
      // Handle other providers here
      default:
        return null;
    }
  }
}
