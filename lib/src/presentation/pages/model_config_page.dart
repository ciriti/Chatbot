// lib/src/presentation/pages/model_config_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final modelProviderStateProvider = StateProvider<String?>((ref) => null);
final modelStateProvider = StateProvider<String?>((ref) => null);

class ModelConfigPage extends ConsumerWidget {
  const ModelConfigPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Available model providers and models (can be expanded later)
    final modelProviders = ['OpenAI API'];
    final openAIModels = ['gpt-3.5-turbo', 'gpt-4', 'davinci'];

    // Watch the selected provider and model from Riverpod state
    final selectedModelProvider = ref.watch(modelProviderStateProvider);
    final selectedModel = ref.watch(modelStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configure Model Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Model Provider Dropdown
            const Text('Model Provider:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedModelProvider,
              items: modelProviders.map((String provider) {
                return DropdownMenuItem<String>(
                  value: provider,
                  child: Text(provider),
                );
              }).toList(),
              onChanged: (value) {
                // Update the selected model provider
                ref.read(modelProviderStateProvider.notifier).state = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Model Selection Dropdown (based on selected provider)
            const Text('Model:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedModel,
              items: openAIModels.map((String model) {
                return DropdownMenuItem<String>(
                  value: model,
                  child: Text(model),
                );
              }).toList(),
              onChanged: (value) {
                // Update the selected model
                ref.read(modelStateProvider.notifier).state = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Display the selected configuration
            const Text('Selected Configuration:'),
            Text('Provider: ${selectedModelProvider ?? 'None'}'),
            Text('Model: ${selectedModel ?? 'None'}'),

            const Spacer(),

            // Button to Confirm and Save Configuration
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle saving of the configuration or starting the chat
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Configuration saved!\nProvider: $selectedModelProvider\nModel: $selectedModel',
                      ),
                    ),
                  );
                },
                child: const Text('Save Configuration'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
