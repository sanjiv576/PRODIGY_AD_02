import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../constants/hive_table_constants.dart';
import '../entities/todo_entity.dart';
import '../models/list_hive_model.dart';
import '../models/todo_hive_model.dart';

import '../entities/list_entity.dart';

class HiveServices {
  static const String listBoxName = HiveTableConstants.listBox;
  static const String todoBoxName = HiveTableConstants.todoBox;

  static Future<void> onInit() async {
    final directory = await getApplicationDocumentsDirectory();

    Hive.init(directory.path);

    Hive.registerAdapter(TodoHiveModelAdapter());
    Hive.registerAdapter(ListHiveModelAdapter());

    await Hive.openBox<ListHiveModel>(listBoxName);
    await Hive.openBox<TodoHiveModel>(todoBoxName);
  }

  // close all boxes
  static Future<void> closeHive() async {
    await Hive.close();
  }

  // add new list
  static Future<void> addListHive(ListHiveModel list) async {
    final box = Hive.box<ListHiveModel>(listBoxName);
    await box.add(list);
  }

  // updated a list
  static Future<void> updateListHive(ListHiveModel updatedList) async {
    final box = Hive.box<ListHiveModel>(listBoxName);
    await box.put(updatedList.id, updatedList);
  }

  // read all lists
  static List<ListEntity> getAllListsHive() {
    final box = Hive.box<ListHiveModel>(listBoxName);
    var data = box.values.toList();
    return ListHiveModel.toEntityList(data);
    // return box.values.toList();
  }

  // add a single todo in list
  static Future<void> addSingleTodo(
      TodoHiveModel todoModel, String listEntityId) async {
    final box = Hive.box<ListHiveModel>(listBoxName);
    List<ListHiveModel> data = box.values.toList();
    for (ListHiveModel listHiveModel in data) {
      if (listHiveModel.id == listEntityId) {
        listHiveModel.todos.add(todoModel);

        // save the modified list to persist the changes
        await listHiveModel.save();
        break;
      }
    }
  }

  // complete todo
  static Future<void> completeSingleTodo(
      {required String listEntityId, required TodoEntity todoEntity}) async {
    TodoHiveModel todoHiveModel = TodoHiveModel.fromEntity(todoEntity);
    // get box
    final box = Hive.box<ListHiveModel>(listBoxName);

    List<ListHiveModel> data = box.values.toList();

    for (ListHiveModel listHiveModel in data) {
      if (listHiveModel.id == listEntityId) {
        for (TodoHiveModel singleTodoHiveModel in listHiveModel.todos) {
          if (singleTodoHiveModel.id == todoEntity.id) {
            singleTodoHiveModel.isComplete = todoHiveModel.isComplete;

            // save the modified list to persist the changes
            await listHiveModel.save();
            return;
          }
        }
      }
    }
  }

  // complete todo
  static Future<void> updateSingleTodo(
      {required String listEntityId, required TodoEntity todoEntity}) async {
    TodoHiveModel todoHiveModel = TodoHiveModel.fromEntity(todoEntity);
    // get box
    final box = Hive.box<ListHiveModel>(listBoxName);

    List<ListHiveModel> data = box.values.toList();

    for (ListHiveModel listHiveModel in data) {
      if (listHiveModel.id == listEntityId) {
        for (TodoHiveModel singleTodoHiveModel in listHiveModel.todos) {
          if (singleTodoHiveModel.id == todoEntity.id) {
            singleTodoHiveModel.todo = todoHiveModel.todo;

            // save the modified list to persist the changes
            await listHiveModel.save();
            return;
          }
        }
      }
    }
  }

  // delete a todo
  static Future<void> deleteSingleTodo(
      {required String listEntityId,
      required TodoHiveModel todoHiveModel}) async {
    // get box
    final box = Hive.box<ListHiveModel>(listBoxName);

    List<ListHiveModel> data = box.values.toList();

    for (ListHiveModel listHiveModel in data) {
      if (listHiveModel.id == listEntityId) {
        listHiveModel.todos = listHiveModel.todos
            .where((singleTodo) => singleTodo.id != todoHiveModel.id)
            .toList();
        // delete the list if the todos list is empty
        if (listHiveModel.todos.isEmpty) {
          deleteList(listHiveModel: listHiveModel);
        }

        await listHiveModel.save();
        return;
      }
    }
  }

  // delete list
  static Future<void> deleteList({required ListHiveModel listHiveModel}) async {
    final box = Hive.box<ListHiveModel>(listBoxName);

    await box.delete(listHiveModel.key);
  }

  // remove database
  static Future<void> clearAllBox() async {
    final listBox = Hive.box<ListHiveModel>(listBoxName);
    final todoBox = Hive.box<TodoHiveModel>(todoBoxName);
    await listBox.clear();
    await todoBox.clear();
  }
}
