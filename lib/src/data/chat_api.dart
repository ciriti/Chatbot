import 'package:chatbot/src/application/services/model_provider_service.dart';
import 'package:dio/dio.dart';

class ChatApi {
  final Dio _dio;
  final ModelProviderService _modelProviderService;

  ChatApi(this._dio, this._modelProviderService);

  Future<String> sendMessage(
      String message, String providerName, String modelName) async {
    try {
      // Get the provider config with the modelName
      final config =
          _modelProviderService.getProviderConfig(providerName, modelName);
      final apiKey = _modelProviderService.getApiKey(providerName);

      if (apiKey == null) {
        throw Exception('API key for $providerName is not available.');
      }

      // Build the request data and headers
      final requestData = config.buildRequestData(message);
      final requestHeaders = config.buildHeaders(apiKey);

      // Make the API request
      final response = await _dio.post(
        config.apiUrl,
        data: requestData,
        options: Options(headers: requestHeaders),
      );

      // Process the response
      final chatResponse = response.data['choices'][0]['message']['content'];
      return chatResponse;
    } on DioException catch (e) {
      throw Exception('Failed to fetch chat response: ${e.message}');
    }
  }
}
