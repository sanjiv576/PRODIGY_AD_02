import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/services/hive_services.dart';

import '../entities/list_entity.dart';

class TodoListNotifier extends StateNotifier<List<ListEntity>> {
  TodoListNotifier() : super(HiveServices.getAllListsHive());  // fetch data from db

  void setTodoList(List<ListEntity> todoList) {
    state = todoList;
  }

  void addList(ListEntity newList) {
    state = [...state, newList];
  }

  void updateList(ListEntity updatedList) {
    state = [
      for (final list in state)
        if (list.id == updatedList.id) updatedList else list
    ];
  }

  void removeTodoList(String id) {
    state = state.where((list) => list.id != id).toList();
  }
}

final todoListProvider =
    StateNotifierProvider<TodoListNotifier, List<ListEntity>>((ref) {
  return TodoListNotifier();
});
