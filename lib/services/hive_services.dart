import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolist/constants/hive_table_constants.dart';
import 'package:todolist/models/list_hive_model.dart';
import 'package:todolist/models/todo_hive_model.dart';

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

  // remove database
  static Future<void> clearAllBox() async {
    final listBox = Hive.box<ListHiveModel>(listBoxName);
    final todoBox = Hive.box<TodoHiveModel>(todoBoxName);
    await listBox.clear();
    await todoBox.clear();
  }
}
