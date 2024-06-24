import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/color_constant.dart';
import '../entities/todo_entity.dart';
import '../services/todo_list.dart';
import '../state/todo_list_notifier.dart';
import '../state/todo_state.dart';
import 'home_view.dart';

import '../entities/list_entity.dart';

class UpdateListView extends ConsumerStatefulWidget {
  const UpdateListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateListViewState();
}

class _UpdateListViewState extends ConsumerState<UpdateListView> {
  late bool isPinned;
  late ListEntity listEntity;
  late String chosenLabel;

  final _formKey = GlobalKey<FormState>();
  TodoList todoList = TodoList();

  final verticalGap = const SizedBox(height: 16);

  List<bool> isLabelChosen = List.filled(LabelEnum.values.length, false);

  TextEditingController _todoController = TextEditingController();
  int? previousLabelIndex;

  TodoEntity? selectTodo;
  late TodoEntity singleTodo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    listEntity = ModalRoute.of(context)!.settings.arguments as ListEntity;
    isPinned = listEntity.isPinned;
    chosenLabel = listEntity.label;
    isLabelChosen[getChosenIndex(chosenLabel)] = true;
  }

  int getChosenIndex(String chosenLabel) {
    for (LabelEnum label in LabelEnum.values) {
      if (label.text == chosenLabel) {
        return label.index;
      }
    }
    return 0;
  }

  @override
  void dispose() {
    _todoController.dispose();

    super.dispose();
  }

  void _clearAllState() {
    _todoController.clear();
  }

  void _submit({required TodoEntity oldTodo, required ListEntity list}) async {
    if (_formKey.currentState!.validate()) {
      String todo = _todoController.text.trim();

      TodoEntity updatedTodo = TodoEntity(
          id: oldTodo.id, todo: todo, isComplete: oldTodo.isComplete);

      TodoList todoList = TodoList();

      var data =
          await todoList.updateTodo(listEntity: list, todoEntity: updatedTodo);

      setState(() {
        listEntity = data;
      });

      ref
          .watch(todoListProvider.notifier)
          .setTodoList([...TodoState.todoListState]);

      log('Update todo: $updatedTodo');

      // clear all widget when list is created
      _clearAllState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: isPinned
                    ? Colors.green
                    : ref.watch(isDarkThemeProvider)
                        ? KColors.darkButtonColor
                        : KColors.lightButtonColor,
              ),
              onPressed: () {
                setState(() {
                  isPinned = !isPinned;
                });
              },
              icon: const Icon(
                FontAwesomeIcons.mapPin,
                color: Colors.white,
                size: 18,
              ),
              label: Text(
                isPinned ? 'Pinned' : 'Pin',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: ConstrainedBox(
        constraints:
            const BoxConstraints(minHeight: 100, maxWidth: double.infinity),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  listEntity.title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap:
                      true, // Make the ListView take only the necessary height
                  itemCount: listEntity.todos.length,
                  itemBuilder: (context, todoIndex) {
                    singleTodo = listEntity.todos[todoIndex];

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
                          listEntity.todos.removeAt(todoIndex);
                        });
                      },
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectTodo = singleTodo;
                            _todoController =
                                TextEditingController(text: singleTodo.todo);
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
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      decoration: singleTodo.isComplete
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                verticalGap,
                if (selectTodo != null) ...{
                  TextFormField(
                    controller: _todoController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please, add to-do.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Update Todo',
                      labelStyle: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  verticalGap,
                  ElevatedButton(
                    onPressed: () {
                      _submit(oldTodo: singleTodo, list: listEntity);
                    },
                    child: Text(
                      'Update',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                },
                const Spacer(),
                const Divider(
                  color: Color(0xFFDADADA),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose a label',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    verticalGap,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (LabelEnum label in LabelEnum.values) ...{
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isLabelChosen[label.index]
                                    ? Colors.green
                                    : ref.watch(isDarkThemeProvider)
                                        ? KColors.darkButtonColor
                                        : KColors.lightButtonColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  // clear previous index color
                                  if (previousLabelIndex != null) {
                                    isLabelChosen[previousLabelIndex!] = false;
                                  }
                                  // update background color state
                                  isLabelChosen[label.index] =
                                      !isLabelChosen[label.index];

                                  // track previous colored index
                                  previousLabelIndex = label.index;

                                  // update label name
                                  chosenLabel = label.text;
                                });
                              },
                              child: Text(
                                label.text,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 16),
                          }
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
