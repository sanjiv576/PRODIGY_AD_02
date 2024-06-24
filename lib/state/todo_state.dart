import '../services/hive_services.dart';

import '../entities/list_entity.dart';

class TodoState {
  TodoState._();

  static List<ListEntity> todoListState = HiveServices.getAllListsHive();
}
