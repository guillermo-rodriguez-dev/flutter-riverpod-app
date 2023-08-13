import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/domain/domain.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';
import 'package:riverpod_app/presentation/providers/todo_providers.dart';
import 'package:uuid/uuid.dart';

import '../../config/helpers/random_generator.dart';

final todoStateNotifierProvider =
    StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});

const Uuid _uuid = Uuid();

final filteredGuessProvider = Provider<List<Todo>>((ref) {
  
  
  final selectedFilter = ref.watch(todoFilterProvider);
  final todos = ref.watch(filteredChangeProvider);

  switch (selectedFilter) {
   
    case TodoFilers.all:
      return todos;
    case TodoFilers.completed:
      return todos.where((element) => element.done ==true).toList();
    case TodoFilers.pending:
      return todos.where((element) => element.done ==false).toList();
  }
});
class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier()
      : super([
          Todo(
              id: _uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: null),
          Todo(
              id: _uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: null),
          Todo(
              id: _uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: DateTime.now()),
          Todo(
              id: _uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: null),
          Todo(
              id: _uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: null),
          Todo(
              id: _uuid.v4(),
              description: RandomGenerator.getRandomName(),
              completedAt: DateTime.now()),
        ]);

  void addTodo() {
    state = [
      ...state,
      Todo(
          id: _uuid.v4(),
          description: RandomGenerator.getRandomName(),
          completedAt: null)
    ];
  }

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id != id) return todo;
      if (todo.done) {
        return todo.copyWith(completedAt: null);
      } else
        return todo.copyWith(completedAt: DateTime.now());
    }).toList();
  }
}
