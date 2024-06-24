import 'todo_entity.dart';

class ListEntity {
  final String id;
  final String title;
  bool isPinned;
  final String label;
  final String date; // date when todo list is created
  final String time; // time when todo list is created
  List<TodoEntity> todos;

  ListEntity({
    required this.id,
    required this.title,
    bool? isPinned,
    required this.label,
    required this.date,
    required this.todos,
    required this.time,
  }) : isPinned = isPinned ?? false;

  @override
  String toString() {
    return 'id: $id, title: $title, isPinned: $isPinned, label: $label, todo: $todos, date: $date, time: $time';
  }
}
