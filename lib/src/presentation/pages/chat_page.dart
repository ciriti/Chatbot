import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatbot/src/application/services/chat_service.dart';
import 'package:chatbot/src/presentation/widgets/app_drawer.dart';
import 'package:chatbot/src/utils/app_sizes.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  bool hasApiKey = false;
  String apiKey = '';
  String selectedProvider = 'OpenAI'; // Default provider
  String selectedModel = 'gpt-3.5-turbo'; // Default model

  @override
  void initState() {
    super.initState();
    _loadApiKeyAndModel();
  }

  Future<void> _loadApiKeyAndModel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    apiKey = prefs.getString('apiKey') ?? '';
    // Load selected provider and model from SharedPreferences
    selectedProvider = prefs.getString('modelProvider') ?? 'OpenAI';
    selectedModel = prefs.getString('model') ?? 'gpt-3.5-turbo';
    setState(() {
      hasApiKey = apiKey.isNotEmpty;
    });
  }

  void _handleSubmitted(String message) {
    if (message.isNotEmpty && hasApiKey) {
      ref
          .read(chatServiceProvider.notifier)
          .sendMessage(message, selectedProvider, selectedModel);
      _textController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please set an API key in the settings.')),
      );
    }
  }

  void _reloadPage() {
    _loadApiKeyAndModel();
  }

  void _clearChat() {
    ref.read(chatServiceProvider.notifier).clearMessages();
  }

  @override
  Widget build(BuildContext context) {
    final chatMessages = ref.watch(chatServiceProvider);

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        bool isLargeScreen =
            sizingInformation.deviceScreenType == DeviceScreenType.tablet ||
                sizingInformation.deviceScreenType == DeviceScreenType.desktop;

        return Scaffold(
          appBar: isLargeScreen
              ? null // No AppBar on large screens with fixed drawer
              : AppBar(
                  title: const Text('Chatbot'),
                  backgroundColor: Colors.black,
                  leading: Builder(
                    // Ensure the menu button is visible on small screens
                    builder: (context) {
                      return IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context)
                            .openDrawer(), // Open drawer on small screens
                      );
                    },
                  ),
                ),
          // Drawer for small screens
          drawer: isLargeScreen
              ? null
              : AppDrawer(
                  onApiKeyUpdated: _reloadPage,
                  onNewChat: _clearChat,
                  onModelProviderUpdated: _reloadPage,
                ),
          body: Row(
            children: [
              if (isLargeScreen)
                SizedBox(
                  width:
                      250, // Fixed width for the side drawer on large screens
                  child: AppDrawer(
                    onApiKeyUpdated: _reloadPage,
                    onNewChat: _clearChat,
                    onModelProviderUpdated: _reloadPage,
                  ),
                ),
              Expanded(
                child: Column(
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
                                  color: message.isBot
                                      ? Colors.grey[800]
                                      : Colors.blue[800],
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
                                      ? () =>
                                          _handleSubmitted(_textController.text)
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
              ),
            ],
          ),
        );
      },
    );
  }
}
