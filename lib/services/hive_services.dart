import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolist/models/list_hive_model.dart';
import 'package:todolist/models/todo_hive_model.dart';

class HiveServices {
  static Future<void> onInit() async {
    final directory = await getApplicationDocumentsDirectory();

    Hive.init(directory.path);

    Hive.registerAdapter(TodoHiveModelAdapter());
    Hive.registerAdapter(ListHiveModelAdapter());
  }
}
