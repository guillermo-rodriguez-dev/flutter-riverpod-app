import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersInChat = ref.watch(usersInChatProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: Builder(builder: (context) {
        if (!usersInChat.hasValue) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
            itemCount: usersInChat.value!.length ?? 0,
            itemBuilder: (BuildContext build, int i) =>
                Text(usersInChat.value![i]));
      }),
    );
  }
}
