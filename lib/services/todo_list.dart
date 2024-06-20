import 'dart:developer';

import 'package:uuid/uuid.dart';

import '../entities/list_entity.dart';
import '../entities/todo_entity.dart';
import '../state/todo_state.dart';
import 'date_time_converter.dart';

// import '../data/data.dart';

enum LabelEnum {
  perosnal('Personal'),
  work('Work'),
  fitness('Fitness'),
  finance('Finance'),
  others('Others');

  final String text;

  const LabelEnum(this.text);
}

class TodoList {
  ListEntity _addTodo({required String todo, required ListEntity existList}) {
    TodoEntity newTodoEnity = TodoEntity(id: const Uuid().v4(), todo: todo);

    for (ListEntity singleListEntity in TodoState.todoListState) {
      if (singleListEntity.id == existList.id) {
        // add todo to the existing list
        singleListEntity.todos.add(newTodoEnity);
        break;
      }
    }

    return existList;
  }

  ListEntity createTodoList({
    required String title,
    required String todo,
    required String label,
    bool? isPinned,
    required ListEntity? newList,
  }) {
    log('title: $title, todo: $todo, label: $label, isPinned: $isPinned');

    // ----------- creating only new todos from existed the list------------------------------

    if (newList != null) {
      return _addTodo(todo: todo, existList: newList);
    }

    // ----------- for creating only new list of todos ------------------------------

    TodoEntity newTodoEnity = TodoEntity(
      id: const Uuid().v4(),
      todo: todo,
    );

    ListEntity newTodoList = ListEntity(
      id: const Uuid().v4(),
      title: title,
      label: label,
      isPinned: isPinned,
      date: DateTimeConverter.getCurrentDate(),
      todos: [newTodoEnity], // add todo at index 0
      time: DateTimeConverter.getCurrentTime(),
    );

    TodoState.todoListState.add(newTodoList);

    return newTodoList;
  }

  List<ListEntity> getPinnedList() {
    if (TodoState.todoListState.isEmpty) {
      return [];
    }

    // add each pinned list here
    List<ListEntity> pinnedList = TodoState.todoListState
        .where((singleListEntity) => singleListEntity.isPinned == true)
        .toList();

    return pinnedList;
  }
}
