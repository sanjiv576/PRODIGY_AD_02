import 'dart:developer';

import 'package:uuid/uuid.dart';

import '../entities/list_entity.dart';
import '../entities/todo_entity.dart';
import '../models/list_hive_model.dart';
import '../models/todo_hive_model.dart';
import '../state/todo_state.dart';
import 'date_time_converter.dart';
import 'hive_services.dart';

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
  Future<ListEntity> _addTodo(
      {required String todo, required ListEntity existList}) async {
    TodoEntity newTodoEnity = TodoEntity(id: const Uuid().v4(), todo: todo);

    // for hive integration
    TodoHiveModel newTodoHiveModel = TodoHiveModel.fromEntity(newTodoEnity);

    // adding data to the state
    for (ListEntity singleListEntity in TodoState.todoListState) {
      if (singleListEntity.id == existList.id) {
        // add todo to the existing list
        singleListEntity.todos.add(newTodoEnity);
        break;
      }
    }

    // save in the db
    await HiveServices.addSingleTodo(newTodoHiveModel, existList.id);

    return existList;
  }

  Future<ListEntity> createTodoList({
    required String title,
    required String todo,
    required String label,
    bool? isPinned,
    required ListEntity? newList,
  }) async {
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

    ListEntity newListTodoList = ListEntity(
      id: const Uuid().v4(),
      title: title,
      label: label,
      isPinned: isPinned,
      date: DateTimeConverter.getCurrentDate(),
      todos: [newTodoEnity], // add todo at index 0
      time: DateTimeConverter.getCurrentTime(),
    );

    TodoState.todoListState.add(newListTodoList);

    // save the new list into the hive
    ListHiveModel newListHiveModel = ListHiveModel.fromEntity(newListTodoList);
    await HiveServices.addListHive(newListHiveModel);

    return newListTodoList;
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

  // complete a single todo

  void completeTodo({
    required String listId,
    required TodoEntity todoEntity,
  }) async {
    List<ListEntity> updatedList = [];
    List<TodoEntity> updatedTodo = [];

    for (ListEntity list in TodoState.todoListState) {
      if (list.id == listId) {
        for (TodoEntity todo in list.todos) {
          // TodoEntity newTodo = TodoEntity(id: todo.id, todo: todo)
          if (todo.id == todoEntity.id) {
            todo.isComplete = todoEntity.isComplete;
          }
          updatedTodo.add(todo);
        }
      }
      updatedList.add(list);
      updatedTodo = [];
    }

    TodoState.todoListState = updatedList;

    // save in the db
    await HiveServices.completeSingleTodo(
      listEntityId: listId,
      todoEntity: todoEntity,
    );
  }

  // Update a single todo
  Future<ListEntity> updateTodo({
    required ListEntity listEntity,
    required TodoEntity todoEntity,
  }) async {
    List<ListEntity> updatedList = [];

    for (ListEntity list in TodoState.todoListState) {
      if (list.id == listEntity.id) {
        List<TodoEntity> updatedTodoList = [];

        for (TodoEntity singleTodo in list.todos) {
          if (singleTodo.id == todoEntity.id) {
            // update the todo with the new values
            singleTodo = todoEntity;
          }
          // add the (possibly updated) todo to the updated todo list
          updatedTodoList.add(singleTodo);
        }

        // add the updated list to the updated list collection
        updatedList.add(ListEntity(
          id: list.id,
          title: list.title,
          label: list.label,
          date: list.date,
          todos: updatedTodoList,
          time: list.time,
          isPinned: list.isPinned,
        ));
      } else {
        // if the list does not match, add it unchanged to the updated list collection
        updatedList.add(list);
      }
    }

    // update the global state with the new list of lists
    TodoState.todoListState = updatedList;

    // save in the db
    await HiveServices.updateSingleTodo(
      listEntityId: listEntity.id,
      todoEntity: todoEntity,
    );

    // return updated list entity
    return ListEntity(
      id: listEntity.id,
      title: listEntity.title,
      label: listEntity.label,
      date: listEntity.date,
      todos: updatedList.firstWhere((list) => list.id == listEntity.id).todos,
      time: listEntity.time,
      isPinned: listEntity.isPinned,
    );
  }

  // delete a todo

  Future<List<ListEntity>> deleteTodo(
      {required TodoEntity todoEntity, required ListEntity listEntity}) async {
    List<ListEntity> updatedList = [];

    for (ListEntity list in TodoState.todoListState) {
      if (list.id == listEntity.id) {
        list.todos = list.todos
            .where((singleTodo) => singleTodo.id != todoEntity.id)
            .toList();
      }

      // add only whose length todos length is not empty
      if (list.todos.isNotEmpty) {
        updatedList.add(list);
      }
    }

    TodoHiveModel todoHiveModel = TodoHiveModel.fromEntity(todoEntity);

    // delete from db
    await HiveServices.deleteSingleTodo(
        listEntityId: listEntity.id, todoHiveModel: todoHiveModel);

    TodoState.todoListState = updatedList;
    return updatedList;
  }
}
