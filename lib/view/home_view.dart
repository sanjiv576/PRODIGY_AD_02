import 'package:flutter/material.dart';

import 'widgets/empty_list_widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final verticalGap = const SizedBox(height: 16);

  late TabController _tabController;

  final List<String> list = [];

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/small_logo.png',
                    width: 26,
                    height: 26,
                  ),
                  Text(
                    'TODO LIST',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                      ))
                ],
              ),
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
                child: Builder(builder: (context) {
                  if (list.isEmpty) {
                    return const EmptyListWidgets();
                  }
                  return TabBarView(
                    controller: _tabController,
                    children: const <Widget>[
                      Center(
                        child: Text('all'),
                      ),
                      Center(
                        child: Text('pinned'),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
