// lib/src/presentation/pages/chat_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ztc/src/application/services/chat_service.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatMessages = ref.watch(chatServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      // Add the drawer to the Scaffold
      drawer: _buildDrawer(context),
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
                      padding: const EdgeInsets.all(10),
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
            padding: const EdgeInsets.all(8.0),
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

  // Drawer Widget Implementation
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black, // Dark background like in the screenshot
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Search Bar at the top
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white60),
                  prefixIcon: Icon(Icons.search, color: Colors.white60),
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Menu items
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.white),
              title: const Text(
                'ChatGPT',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to ChatGPT page (or handle it as needed)
              },
            ),
            ListTile(
              leading: const Icon(Icons.apps, color: Colors.white),
              title: const Text(
                'Explore GPTs',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to Explore GPTs page (or handle it as needed)
              },
            ),

            const Divider(color: Colors.white12),

            // Empty space to push profile to the bottom
            const Spacer(),

            // Profile Section
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: const Text(
                'Carmelo Iriti',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Handle navigation to profile page
              },
            ),
          ],
        ),
      ),
    );
  }
}
