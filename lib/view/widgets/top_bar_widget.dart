import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todolist/services/hive_services.dart';
import 'package:todolist/state/todo_list_notifier.dart';

import '../home_view.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({
    super.key,
    required this.ref,
    required this.isDarkValue,
  });

  final WidgetRef ref;
  final bool isDarkValue;

  @override
  Widget build(BuildContext context) {
    return Row(
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
          ),
        ),
        IconButton(
          onPressed: () async {
            await HiveServices.clearAllBox();
            ref.watch(todoListProvider.notifier).setTodoList([]);
          },
          icon: const Icon(
            Icons.delete,
          ),
        ),
        IconButton(
          onPressed: () {
            ref.watch(isDarkThemeProvider.notifier).state =
                !ref.watch(isDarkThemeProvider);
          },
          icon: Icon(
            isDarkValue ? FontAwesomeIcons.moon : Icons.sunny,
          ),
        ),
      ],
    );
  }
}
