import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../router/app_routes.dart';
import '../state/todo_state.dart';
import 'widgets/show_snackbar.dart';
import '../models/list_entity.dart';
import '../data/data.dart';
import 'widgets/lists_widget.dart';
import '../constants/color_constant.dart';
import 'widgets/top_bar_widget.dart';

import 'widgets/empty_list_widgets.dart';

final isDarkThemeProvider = StateProvider<bool>((ref) => false);

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with SingleTickerProviderStateMixin {
  final verticalGap = const SizedBox(height: 16);

  late TabController _tabController;

  List<ListEntity> allTodosList = [];
  List<ListEntity> pinnedList = [];

  void _getUpdateData() {
    log('Refeshing....');
    showSnackbarMsg(
      context: context,
      targetTitle: 'Refresh',
      targetMessage: 'Refreshing..',
      type: ContentType.success,
    );
    setState(() {
      // allTodosList = Data.allList;
      allTodosList = TodoState.todoListState;

      pinnedList = getPinnedList();
    });
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    // allTodosList = Data.allList;
    allTodosList = TodoState.todoListState;

    pinnedList = getPinnedList();
    // _getUpdateData();
  }

  List<ListEntity> getPinnedList() {
    List<ListEntity> filteredPinnedLists = [];
    for (ListEntity singleEntity in allTodosList) {
      if (singleEntity.isPinned == true) {
        filteredPinnedLists.add(singleEntity);
      }
    }
    return filteredPinnedLists;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late bool isDarkValue;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    isDarkValue = ref.watch(isDarkThemeProvider);

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
                  onPressed: () => _getUpdateData,
                  icon: const Icon(Icons.refresh),
                ),
                const SizedBox(width: 19),
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
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            _getUpdateData();
          },
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
      ),
    );
  }
}
