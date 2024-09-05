import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ztc/src/data/chat_api.dart';
import 'package:ztc/src/data/chat_repository.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider((ref) => Dio());

final chatApiProvider = Provider((ref) => ChatApi(ref.watch(dioProvider)));

final chatRepositoryProvider =
    Provider((ref) => ChatRepository(ref.watch(chatApiProvider)));
