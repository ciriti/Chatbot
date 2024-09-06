import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ztc/src/application/services/chat_service.dart';
import 'package:ztc/src/presentation/widgets/app_drawer.dart';
import 'package:ztc/src/utils/app_sizes.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  bool hasApiKey = false;
  String apiKey = '';

  @override
  void initState() {
    super.initState();
    _loadApiKey();
  }

  Future<void> _loadApiKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    apiKey = prefs.getString('apiKey') ?? '';
    setState(() {
      hasApiKey = apiKey.isNotEmpty;
    });
  }

  void _handleSubmitted(String message) {
    if (message.isNotEmpty && hasApiKey) {
      ref.read(chatServiceProvider.notifier).sendMessage(message);
      _textController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please set an API key in the settings.')),
      );
    }
  }

  void _reloadPage() {
    _loadApiKey();
  }

  void _clearChat() {
    ref.read(chatServiceProvider.notifier).clearMessages();
  }

  @override
  Widget build(BuildContext context) {
    final chatMessages = ref.watch(chatServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      drawer: AppDrawer(
        onApiKeyUpdated: _reloadPage,
        onNewChat: _clearChat,
      ),
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
                    controller: _textController,
                    onSubmitted: (value) => _handleSubmitted(value),
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: hasApiKey
                            ? () => _handleSubmitted(_textController.text)
                            : null,
                      ),
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
