import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ztc/src/utils/app_sizes.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback onApiKeyUpdated;

  const AppDrawer({super.key, required this.onApiKeyUpdated});

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
                onApiKeyUpdated();
                Navigator.pop(context);
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
                'ChatGPT',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Settings item
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => _onOpenSettings(context), // Open settings dialog
            ),
            const Divider(color: Colors.white12),
            const Spacer(),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: const Text(
                'Carmelo Iriti',
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
