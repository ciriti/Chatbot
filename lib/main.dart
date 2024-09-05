// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv

import 'src/presentation/pages/chat_page.dart';

Future<void> main() async {
  // Load the .env file before running the app
  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot',
      theme: ThemeData(
        brightness: Brightness.dark, // Set the theme to dark
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor:
            Colors.black87, // Background color for the entire app
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black26, // AppBar background in dark theme
          titleTextStyle: TextStyle(
            color: Colors.white, // White text for the title
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Icons in the AppBar should be white
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge:
              TextStyle(color: Colors.white), // Main text color in dark mode
          bodyMedium: TextStyle(color: Colors.white70), // Secondary text color
        ),
      ),
      home: const ChatPage(),
    );
  }
}
