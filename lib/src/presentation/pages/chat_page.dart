import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ztc/src/application/services/chat_service.dart';
import 'package:ztc/src/presentation/widgets/app_drawer.dart';
import 'package:ztc/src/utils/app_sizes.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatMessages = ref.watch(chatServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                return ListTile(
                  title: Align(
                    alignment: message.isBot
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      padding: insets12,
                      decoration: BoxDecoration(
                        color:
                            message.isBot ? Colors.grey[800] : Colors.blue[800],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(message.content),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: insets8,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(),
                    onSubmitted: (value) {
                      ref.read(chatServiceProvider.notifier).sendMessage(value);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
