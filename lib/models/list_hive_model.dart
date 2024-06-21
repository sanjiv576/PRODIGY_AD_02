import 'package:hive/hive.dart';
import 'package:todolist/constants/hive_table_constants.dart';
import 'package:todolist/entities/list_entity.dart';
import 'package:todolist/models/todo_hive_model.dart';

part 'list_hive_model.g.dart';

@HiveType(typeId: HiveTableConstants.listTableId)
class ListHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool isPinned;

  @HiveField(3)
  String label;

  @HiveField(4)
  final String date;

  @HiveField(5)
  final String time;

  @HiveField(6)
  List<TodoHiveModel> todos; // hive model of todo

  ListHiveModel({
    required this.id,
    required this.title,
    required this.isPinned,
    required this.label,
    required this.date,
    required this.time,
    required this.todos,
  });

  // empty initial values
  ListHiveModel.empty()
      : this(
          id: '',
          title: '',
          isPinned: false,
          label: '',
          date: '',
          time: '',
          todos: [],
        );

  // convert hive model into entity
  ListEntity toEntity() {
    return ListEntity(
      id: id,
      title: title,
      label: label,
      date: date,
      todos: todos
          .map((todoHiveModel) => todoHiveModel.toEntity())
          .toList(), // convert each todo hive model into todo entity
      time: time,
      isPinned: isPinned,
    );
  }

  // convert entity into hive model
  static ListHiveModel fromEntity(ListEntity entity) {
    return ListHiveModel(
      id: entity.id,
      title: entity.title,
      isPinned: entity.isPinned,
      label: entity.label,
      date: entity.date,
      time: entity.time,
      todos: TodoHiveModel.fromEntityList(
          entity.todos), // converted each todo entity into todoHiveModel
    );
  }

  // convert entity list into list of hive model
  static List<ListHiveModel> fromEntityList(List<ListEntity> entities) {
    return entities.map((entity) => ListHiveModel.fromEntity(entity)).toList();
  }

  // convert hive model list into list of entities
  static List<ListEntity> toEntityList(List<ListHiveModel> hiveModels) {
    return hiveModels.map((hiveModel) => hiveModel.toEntity()).toList();
  }

  @override
  String toString() {
    return 'Hive LIST data: id=$id, title=$title, isPinned=$isPinned, label=$label, date=$date, time=$time, todos=$todos';
  }
}
