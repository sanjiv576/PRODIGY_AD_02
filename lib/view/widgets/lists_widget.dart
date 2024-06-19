import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/color_constant.dart';
import '../../models/list_entity.dart';
import '../../models/todo_entity.dart';
import '../home_view.dart';
import 'horizontal_row_label_widgets.dart';

class ListsWidget extends ConsumerStatefulWidget {
  final List<ListEntity> filteredTodoList;

  const ListsWidget({
    super.key,
    required this.filteredTodoList,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllListsWidgetState();
}

class _AllListsWidgetState extends ConsumerState<ListsWidget> {
  List<ListEntity> allTodoList = [];

  List<bool> isExpandedList = [];
  @override
  void initState() {
    super.initState();

    allTodoList = widget.filteredTodoList;

    isExpandedList = List.filled(widget.filteredTodoList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ref.watch(isDarkThemeProvider);
    return ListView.separated(
      itemCount: allTodoList.length,
      itemBuilder: (context, index) {
        ListEntity singleList = allTodoList[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              isExpandedList[index] = !isExpandedList[index];
            });
            log('isExpanded: ${isExpandedList[index]}');
          },
          child: Card(
            color: isDark
                ? const Color.fromARGB(255, 71, 60, 64)
                : KColors.lightGreyColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    singleList.title,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  if (isExpandedList[index])
                    // all todos list
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap:
                          true, // Make the ListView take only the necessary height
                      itemCount: singleList.todos.length,
                      itemBuilder: (context, todoIndex) {
                        TodoEntity singleTodo = singleList.todos[todoIndex];

                        // show todo individually
                        return Dismissible(
                          key: ValueKey(singleTodo.id),
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            color: Colors.green,
                            child: const Center(child: Text('Deleting...')),
                          ),
                          secondaryBackground: Container(
                            color: Colors.red,
                            child: const Icon(Icons.cancel),
                          ),
                          onDismissed: (direction) {
                            setState(() {
                              singleList.todos.removeAt(todoIndex);
                            });
                          },
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                singleTodo.isComplete
                                    ? Icons.check_box_outlined
                                    : Icons.check_box_outline_blank,
                                size: 24,
                              ),
                            ),
                            title: Text(
                              singleTodo.todo,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    decoration: singleTodo.isComplete
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  const SizedBox(height: 8),
                  HorizontalRowLabelWidgets(singleList: singleList),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 16);
      },
    );
  }
}
