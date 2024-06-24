import 'package:hive/hive.dart';

import '../constants/hive_table_constants.dart';
import '../entities/todo_entity.dart';

part 'todo_hive_model.g.dart';

@HiveType(typeId: HiveTableConstants.todoTableId)
class TodoHiveModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String todo;
  @HiveField(2)
  bool isComplete;

  TodoHiveModel({
    required this.id,
    required this.todo,
    bool? isComplete,
  }) : isComplete = isComplete ?? false;

  // empty values
  TodoHiveModel.empty()
      : this(
          id: '',
          todo: '',
          isComplete: false,
        );

  // convert hive model into entity
  TodoEntity toEntity() {
    return TodoEntity(id: id, todo: todo, isComplete: isComplete);
  }

  // convert entity into hive model
  static TodoHiveModel fromEntity(TodoEntity entity) {
    return TodoHiveModel(
        id: entity.id, todo: entity.todo, isComplete: entity.isComplete);
  }

  // convert entity list into list of hive model
  static List<TodoHiveModel> fromEntityList(List<TodoEntity> entities) =>
      entities.map((entity) => fromEntity(entity)).toList();

  @override
  String toString() {
    return 'Hiiiveee.. TODO data: id=$id, todo=$todo, isComplete: $isComplete';
  }
}
