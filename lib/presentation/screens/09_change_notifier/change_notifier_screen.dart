import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';


class ChangeNotifierScreen extends ConsumerWidget {
  const ChangeNotifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(todoFilterProvider);
    final todos = ref.watch(filteredGuessProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Notifier Provider'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          ref.read(todoChangeNotifierProvider.notifier).addTodo();
        },
      ),
      body: Column(
        children: [
          SegmentedButton(
            segments: const [
              ButtonSegment(value: TodoFilers.all, icon: Text('Todos')),
              ButtonSegment(
                  value: TodoFilers.completed, icon: Text('Invitados')),
              ButtonSegment(
                  value: TodoFilers.pending, icon: Text('No invitados')),
            ],
            selected: <TodoFilers>{currentFilter},
            onSelectionChanged: (value) {
              ref
                  .read(todoFilterProvider.notifier)
                  .update((state) => value.first);
            },
          ),
          const SizedBox(height: 5),

          // Listado de personas a invitar
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return SwitchListTile(
                    title: Text(todo.description),
                    value: todo.done,
                    onChanged: (value) {
                      ref
                          .read(todoChangeNotifierProvider.notifier)
                          .toggleTodo(todo.id);
                    });
              },
            ),
          )
        ],
      ),
    );
}}