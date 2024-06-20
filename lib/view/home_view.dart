
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/color_constant.dart';
import '../models/list_entity.dart';
import '../router/app_routes.dart';
import '../state/todo_list_notifier.dart';
import 'widgets/empty_list_widgets.dart';
import 'widgets/lists_widget.dart';
import 'widgets/top_bar_widget.dart';

final isDarkThemeProvider = StateProvider<bool>((ref) => false);

final pinnedListProvider = Provider<List<ListEntity>>((ref) {
  final todoList = ref.watch(todoListProvider);
  return todoList.where((list) => list.isPinned).toList();
});


class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with SingleTickerProviderStateMixin {
  final verticalGap = const SizedBox(height: 16);

  late TabController _tabController;

  late bool isDarkValue;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isDarkValue = ref.watch(isDarkThemeProvider);
    final allTodosList = ref.watch(todoListProvider);
    final pinnedList = ref.watch(pinnedListProvider);

    return Scaffold(
      floatingActionButton: allTodosList.isEmpty
          ? null
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
               
                IconButton.filled(
                  color: Colors.white,
                  highlightColor: Colors.green,
                  style: ButtonStyle(
                    backgroundColor: isDarkValue
                        ? const WidgetStatePropertyAll(KColors.darkButtonColor)
                        : const WidgetStatePropertyAll(
                            KColors.lightButtonColor),
                  ),
                  onPressed: () => Navigator.pushNamed(
                      context, AppRoutes.createNewListRoute),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // top bar widget contains button icons, text, image
              TopBarWidget(ref: ref, isDarkValue: isDarkValue),
              verticalGap,
              TabBar(
                indicatorWeight: 0.01,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.all(12),
                labelStyle: Theme.of(context).textTheme.labelMedium,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[600],
                controller: _tabController,
                tabs: const [
                  SizedBox(
                    width: double.infinity,
                    child: Tab(
                      text: 'All Lists',
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Tab(
                      text: 'Pinned',
                    ),
                  ),
                ],
              ),
              verticalGap,
              Expanded(
                  child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  allTodosList.isEmpty
                      ? const EmptyListWidgets(
                          imageName: 'write_todo.png',
                          message: 'Create your first to-do-list...',
                        )
                      : ListsWidget(
                          filteredTodoList: allTodosList,
                        ),
                  pinnedList.isEmpty
                      ? const EmptyListWidgets(
                          imageName: 'search.png',
                          message: 'Ooops! No pinned list yet...',
                        )
                      : ListsWidget(
                          filteredTodoList: pinnedList,
                        ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
