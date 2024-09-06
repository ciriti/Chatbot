import 'package:chatbot/src/application/services/model_provider_service.dart';
import 'package:dio/dio.dart';

class ChatApi {
  final Dio _dio;
  final ModelProviderService _modelProviderService;

  ChatApi(this._dio, this._modelProviderService);

  Future<String> sendMessage(
      String message, String providerName, String modelName) async {
    try {
      final config =
          _modelProviderService.getProviderConfig(providerName, modelName);
      final apiKey = await _modelProviderService.getApiKey(providerName);

      if (apiKey == null) {
        throw Exception('API key for $providerName is not available.');
      }

      final requestData = config.buildRequestData(message);
      final requestHeaders = config.buildHeaders(apiKey);

      final response = await _dio.post(
        config.apiUrl,
        data: requestData,
        options: Options(headers: requestHeaders),
      );

      final chatResponse = response.data['choices'][0]['message']['content'];
      return chatResponse;
    } on DioException catch (e) {
      throw Exception('Failed to fetch chat response: ${e.message}');
    }
  }
}
