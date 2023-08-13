import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/domain.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';
import 'package:uuid/uuid.dart';

const Uuid _uuid = Uuid();

final todoChangeNotifierProvider =
    ChangeNotifierProvider<TodoChangeNotifier>((ref) {
  return TodoChangeNotifier();
});

final filteredChangeProvider = Provider<List<Todo>>((ref) {
  final selectedFilter = ref.watch(todoFilterProvider);
  final todos = ref.watch(todoChangeNotifierProvider).todos;

  switch (selectedFilter) {
    case TodoFilers.all:
      return todos;
    case TodoFilers.completed:
      return todos.where((element) => element.done == true).toList();
    case TodoFilers.pending:
      return todos.where((element) => element.done == false).toList();
  }
});

class TodoChangeNotifier extends ChangeNotifier {
  List<Todo> todos = [
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
  ];

  void addTodo() {
    todos = [
      ...todos,
      Todo(
          id: _uuid.v4(),
          description: RandomGenerator.getRandomName(),
          completedAt: null)
    ];
    notifyListeners();
  }

  void toggleTodo(String id) {
    todos = todos.map((todo) {
      if (todo.id != id) return todo;
      if (todo.done) {
        return todo.copyWith(completedAt: null);
      } else
        return todo.copyWith(completedAt: DateTime.now());
    }).toList();
  }

  notifyListeners();
}
