import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../state/todo_list_notifier.dart';
import '../state/todo_state.dart';
import '../constants/color_constant.dart';
import '../entities/todo_entity.dart';
import '../services/todo_list.dart';
import 'home_view.dart';
import 'widgets/show_snackbar.dart';

import '../entities/list_entity.dart';

class CreateNewListView extends ConsumerStatefulWidget {
  const CreateNewListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewListViewState();
}

class _CreateNewListViewState extends ConsumerState<CreateNewListView> {
  bool isPinned = false;

  final _formKey = GlobalKey<FormState>();
  TodoList todoList = TodoList();

  ListEntity? newListEntity;

  final verticalGap = const SizedBox(height: 16);

  List<bool> isLabelChosen = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _todoController = TextEditingController();
  int? previousLabelIndex;

  String? chosenLabel;

  @override
  void initState() {
    super.initState();

    isLabelChosen = List.filled(LabelEnum.values.length, false);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _todoController.dispose();

    super.dispose();
  }

  void _clearAllState() {
    _titleController.clear();
    _todoController.clear();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      if (chosenLabel == null) {
        showSnackbarMsg(
          context: context,
          targetTitle: 'Missing',
          targetMessage: 'Choose a label',
          type: ContentType.failure,
        );
        return;
      }

      String title = _titleController.text.trim();
      String todo = _todoController.text.trim();

      newListEntity = await todoList.createTodoList(
        title: title,
        todo: todo,
        label: chosenLabel!,
        isPinned: isPinned,
        newList: newListEntity, // is passed to track this list is old or new
      );
      setState(() {}); // update state

      ref.watch(todoListProvider.notifier).setTodoList(TodoState.todoListState);

      showSnackbarMsg(
        context: context,
        targetTitle: 'Success',
        targetMessage: 'Todo added successfully.',
        type: ContentType.success,
      );

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (newListEntity != null) ...{
                  Text(
                    newListEntity!.title,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap:
                        true, // Make the ListView take only the necessary height
                    itemCount: newListEntity!.todos.length,
                    itemBuilder: (context, todoIndex) {
                      TodoEntity singleTodo = newListEntity!.todos[todoIndex];

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
                          if (newListEntity != null) {
                            setState(() {
                              newListEntity!.todos.removeAt(todoIndex);
                            });
                          }
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
                      );
                    },
                  ),
                },
                verticalGap,
                if (newListEntity == null) ...{
                  TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please, add title here.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                },
                verticalGap,
                TextFormField(
                  controller: _todoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please, add to-do.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {
                          _submit();
                        },
                        icon: const Icon(FontAwesomeIcons.squarePlus)),
                    labelText: 'Write to-do here...',
                    labelStyle: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
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
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
