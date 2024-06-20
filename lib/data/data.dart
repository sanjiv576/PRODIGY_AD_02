import '../entities/list_entity.dart';
import '../entities/todo_entity.dart';

class Data {
  static List<ListEntity> allList = [
    ListEntity(
      id: '1',
      title: 'Self-care List',
      label: 'Personal',
      date: 'Jun 19, 2024',
      isPinned: false,
      todos: [
        TodoEntity(id: '1', todo: 'Stay hydrated'),
        TodoEntity(id: '2', todo: 'Learn something new and useful'),
        TodoEntity(id: '3', todo: 'Laugh more', isComplete: true),
        TodoEntity(id: '4', todo: 'Make a meal at home', isComplete: true),
      ],
      time: '5:23 AM',
    ),
    ListEntity(
      id: '2',
      isPinned: true,
      title: 'Workout List',
      label: 'Fitness',
      date: 'Jun 19, 2024',
      todos: [
        TodoEntity(id: '1', todo: 'Morning Yoga'),
        TodoEntity(id: '2', todo: 'Run 5 km', isComplete: true),
        TodoEntity(id: '3', todo: 'Strength Training'),
        TodoEntity(id: '4', todo: 'Stretching Exercises'),
      ],
      time: '6:00 AM',
    ),
    ListEntity(
      id: '3',
      title: 'Expenditure List',
      isPinned: true,
      label: 'Finance',
      date: 'Jun 19, 2024',
      todos: [
        TodoEntity(id: '1', todo: 'Pay Electricity Bill', isComplete: true),
        TodoEntity(id: '2', todo: 'Grocery Shopping', isComplete: true),
        TodoEntity(id: '3', todo: 'Renew Gym Membership'),
        TodoEntity(id: '4', todo: 'Monthly Savings Transfer'),
      ],
      time: '8:00 AM',
    ),
  ];
}
