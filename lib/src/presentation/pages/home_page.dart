// lib/src/presentation/pages/home_page.dart
import 'package:flutter/material.dart';

class HomePageWithDrawer extends StatelessWidget {
  const HomePageWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
        backgroundColor: Colors.black, // Dark AppBar background
      ),
      drawer: _buildDrawer(context),
      body: const Center(
        child: Text(
          'Home Screen',
          style: TextStyle(
              color: Colors.white), // Ensure text is white in dark mode
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black, // Dark background for the drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Search Bar at the top
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: TextField(
                style: const TextStyle(
                    color: Colors.white), // White text for input
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.white60),
                  prefixIcon: const Icon(Icons.search, color: Colors.white60),
                  filled: true,
                  fillColor: Colors
                      .grey[800], // Darker grey background for the search bar
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Menu items with white text and icons
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

            const Divider(color: Colors.white12), // Light divider

            // Empty space to push profile to the bottom
            const Spacer(),

            // Profile Section
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors
                    .white24, // Slight transparency for the avatar background
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
