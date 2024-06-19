import 'dart:developer';

import 'package:todolist/models/list_entity.dart';
import 'package:todolist/models/todo_entity.dart';
import 'package:todolist/services/date_time_converter.dart';

import '../data/data.dart';

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
    TodoEntity newTodoEnity =
        TodoEntity(id: existList.todos.length, todo: todo);

    // now add to the actual data

    for (ListEntity singleListEntity in Data.allList) {
      if (singleListEntity.id == existList.id) {
        // add todo to the existing list
        singleListEntity.todos.add(newTodoEnity);

        
        break;
      }
    }

    // overriding to the existing list
    existList.todos.add(newTodoEnity);

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
      id: 1,
      todo: todo,
    );

    int newId = Data.allList.length;

    ListEntity newTodoList = ListEntity(
      id: newId,
      title: title,
      label: label,
      date: DateTimeConverter.getCurrentDate(),
      todos: [newTodoEnity], // add todo at index 0
      time: DateTimeConverter.getCurrentTime(),
    );

    // add to data

    Data.allList.add(newTodoList);

    return newTodoList;
  }
}
