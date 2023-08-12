import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/domain.dart';
import 'package:uuid/uuid.dart';

enum TodoFilers {
  all, completed, pending
}


final Uuid uuid= Uuid();

final todoFilterProvider = StateProvider<TodoFilers>((ref) {
  return TodoFilers.all;
});



final todoProvider = StateProvider<List<Todo>>((ref) {
  return [
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
        Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),

    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: null),
    Todo(id: uuid.v4(), description: RandomGenerator.getRandomName(), completedAt: DateTime.now()),

  ];
});


final filteredProvider = Provider<List<Todo>>((ref) {
  
  
  final selectedFilter = ref.watch(todoFilterProvider);
  final todos = ref.watch(todoProvider);

  switch (selectedFilter) {
   
    case TodoFilers.all:
      return todos;
    case TodoFilers.completed:
      return todos.where((element) => element.done ==true).toList();
    case TodoFilers.pending:
      return todos.where((element) => element.done ==false).toList();
  }
});