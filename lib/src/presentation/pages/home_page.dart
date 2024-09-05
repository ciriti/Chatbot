// lib/src/presentation/pages/home_page.dart
import 'package:flutter/material.dart';

class HomePageWithDrawer extends StatelessWidget {
  const HomePageWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      drawer: _buildDrawer(context),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }

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
                // Navigate to ChatGPT page
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
                // Navigate to Explore GPTs page
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
                // Navigate to Profile page
              },
            ),
          ],
        ),
      ),
    );
  }
}
