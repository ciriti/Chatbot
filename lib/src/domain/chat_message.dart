import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String content;
  final bool isBot;

  const ChatMessage({
    required this.content,
    required this.isBot,
  });

  @override
  List<Object> get props => [content, isBot];
}
