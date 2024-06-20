import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/list_entity.dart';

class TodoListNotifier extends StateNotifier<List<ListEntity>> {
  TodoListNotifier() : super([]);

  void setTodoList(List<ListEntity> todoList) {
    state = todoList;
  }

  void addTodoList(ListEntity newList) {
    state = [...state, newList];
  }

  void updateTodoList(ListEntity updatedList) {
    state = [
      for (final list in state)
        if (list.id == updatedList.id) updatedList else list
    ];
  }

  void removeTodoList(String id) {
    state = state.where((list) => list.id != id).toList();
  }
}

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<ListEntity>>((ref) {
  return TodoListNotifier();
});
