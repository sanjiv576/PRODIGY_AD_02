class TodoEntity {
  final String id;
  final String todo;

  final bool isComplete;

  TodoEntity({
    required this.id,
    required this.todo,
    bool? isComplete,
  }) : isComplete = isComplete ?? false;

  @override
  String toString() {
    return 'todo id: $id, todo: $todo, isComplete: $isComplete';
  }
}
