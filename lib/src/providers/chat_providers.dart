import 'package:chatbot/src/application/services/model_provider_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:chatbot/src/data/chat_api.dart';
import 'package:chatbot/src/data/chat_repository.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider((ref) => Dio());

final modelProviderServiceProvider = Provider((ref) => ModelProviderService());

final chatApiProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final modelProviderService = ref.watch(modelProviderServiceProvider);
  return ChatApi(dio, modelProviderService);
});

final chatRepositoryProvider = Provider((ref) {
  final chatApi = ref.watch(chatApiProvider);
  final modelProviderService = ref.watch(modelProviderServiceProvider);
  return ChatRepository(chatApi, modelProviderService);
});
