import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatbot/src/utils/app_sizes.dart';

class AppDrawer extends StatefulWidget {
  final VoidCallback onApiKeyUpdated;
  final VoidCallback onNewChat;
  final VoidCallback onModelProviderUpdated;

  const AppDrawer({
    super.key,
    required this.onApiKeyUpdated,
    required this.onNewChat,
    required this.onModelProviderUpdated,
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Future<void> _onOpenSettings(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiKey = prefs.getString('apiKey') ?? '';
    String newApiKey = apiKey;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Set API Key'),
          content: TextFormField(
            initialValue: newApiKey,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Enter your API key'),
            onChanged: (value) => newApiKey = value,
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
                await prefs.setString('apiKey', newApiKey);
                widget.onApiKeyUpdated();
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

  Future<void> _onOpenModelProviderSettings(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Fetch saved provider and model from SharedPreferences
    String selectedProvider = prefs.getString('modelProvider') ?? 'OpenAI';
    String selectedModel = prefs.getString('model') ?? 'gpt-3.5-turbo';

    // Available providers and models
    final List<String> availableProviders = ['OpenAI'];
    final List<String> openAIModels = ['gpt-3.5-turbo', 'gpt-4'];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Set Model Provider'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                // Save the selected provider and model in SharedPreferences
                await prefs.setString('modelProvider', selectedProvider);
                await prefs.setString('model', selectedModel);

                widget.onModelProviderUpdated(); // Callback to notify changes
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.key, color: Colors.white),
              title: const Text(
                'Set Apikey',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => _onOpenSettings(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text(
                'Set Model Provider',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => _onOpenModelProviderSettings(context),
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
