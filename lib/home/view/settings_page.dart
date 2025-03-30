import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikigen/home/domain/app_domain.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(preferencesProvider);
    
    return Container(
      child: switch (preferences) {
        AsyncData(:final value) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                
                  title: const Text("Gemini API key"),
                  trailing: FutureBuilder<String?>(
                    builder: (context, snapshot) {
                      final controller = TextEditingController(text: snapshot.data ?? "");

                      return SizedBox(
                        width: 100,
                        child: TextField(
                          controller: controller,
                          
                          onChanged: (text) async {
                            await value.setString("api_key", text);
                          },
                        ),
                      );
                    }, future: value.getString("api_key"),
                  ),
              )
            ],
          ),
        AsyncError() => const Text('Oops, something unexpected happened'),
        _ => const CircularProgressIndicator(),
      },
    );
  }
}
