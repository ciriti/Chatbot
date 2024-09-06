import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatApi {
  final Dio _dio;

  ChatApi(this._dio);

  Future<String> sendMessage(String message) async {
    try {
      final apiKey = dotenv.env['OPENAI_API_KEY'];

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
