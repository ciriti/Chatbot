import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatbot/src/utils/app_sizes.dart';

class AppDrawer extends StatefulWidget {
  final VoidCallback onApiKeyUpdated;
  final VoidCallback onNewChat;
  final VoidCallback onModelProviderUpdated;
  final bool isLargeScreen;

  const AppDrawer({
    super.key,
    required this.onApiKeyUpdated,
    required this.onNewChat,
    required this.onModelProviderUpdated,
    required this.isLargeScreen,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Future<void> _onOpenSettings(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Fetch saved API key, provider, and model from SharedPreferences
    String apiKey = prefs.getString('apiKey') ?? '';
    String newApiKey = apiKey;
    String selectedProvider = prefs.getString('modelProvider') ?? 'OpenAI';
    String selectedModel = prefs.getString('model') ?? 'gpt-3.5-turbo';

    // Available providers and models
    final List<String> availableProviders = ['OpenAI'];
    final List<String> openAIModels = ['gpt-3.5-turbo', 'gpt-4o'];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Settings'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TextField for API key input
                TextFormField(
                  initialValue: newApiKey,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Enter your API key',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    newApiKey = value;
                  },
                ),
                const SizedBox(height: 16),

                // Dropdown for Model Provider
                DropdownButtonFormField<String>(
                  value: selectedProvider,
                  items: availableProviders.map((String provider) {
                    return DropdownMenuItem<String>(
                      value: provider,
                      child: Text(provider),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedProvider = newValue!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Model Provider',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Dropdown for Model
                DropdownButtonFormField<String>(
                  value: selectedModel,
                  items: openAIModels.map((String model) {
                    return DropdownMenuItem<String>(
                      value: model,
                      child: Text(model),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedModel = newValue!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Model',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                // Save API key, model provider, and model in SharedPreferences
                await prefs.setString('apiKey', newApiKey);
                await prefs.setString('modelProvider', selectedProvider);
                await prefs.setString('model', selectedModel);

                widget.onApiKeyUpdated(); // Callback to notify API key update
                widget
                    .onModelProviderUpdated(); // Callback to notify model update

                if (mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black87,
        child: Column(
          children: <Widget>[
            gapH16,
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
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.white),
              title: const Text(
                'New Chat',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                widget.onNewChat();
                if (!widget.isLargeScreen) {
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => _onOpenSettings(context), // Unified settings dialog
            ),
            const Divider(color: Colors.white12),
            const Spacer(),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: const Text(
                'User\'s name',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
