import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final modelProviderStateProvider = StateProvider<String?>((ref) => null);
final modelStateProvider = StateProvider<String?>((ref) => null);

class ModelConfigPage extends ConsumerWidget {
  const ModelConfigPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelProviders = ['OpenAI'];
    final openAIModels = ['gpt-3.5-turbo', 'gpt-4o', 'davinci'];

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
                ref.read(modelProviderStateProvider.notifier).state = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
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
                ref.read(modelStateProvider.notifier).state = value;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Selected Configuration:'),
            Text('Provider: ${selectedModelProvider ?? 'None'}'),
            Text('Model: ${selectedModel ?? 'None'}'),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
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
