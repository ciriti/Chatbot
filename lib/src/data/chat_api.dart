// lib/src/data/chat_api.dart
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv

class ChatApi {
  final Dio _dio;

  ChatApi(this._dio);

  Future<String> sendMessage(String message) async {
    try {
      // Access the API key from .env
      final apiKey = dotenv.env['OPENAI_API_KEY'];

      // Make the API call
      final response = await _dio.post(
        'https://api.openai.com/v1/chat/completions',
        data: {
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': message}
          ]
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );

      final chatResponse = response.data['choices'][0]['message']['content'];
      return chatResponse;
    } on DioException catch (e) {
      throw Exception('Failed to fetch chat response: ${e.message}');
    }
  }
}
