import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../services/hive_services.dart';
import '../../state/todo_list_notifier.dart';
import '../home_view.dart';
import 'show_snackbar.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({
    super.key,
    required this.ref,
    required this.isDarkValue,
  });

  final WidgetRef ref;
  final bool isDarkValue;

  void _deleteFromDb() async {
    await HiveServices.clearAllBox(); // from db
    ref.watch(todoListProvider.notifier).setTodoList([]); // clear state
  }

  void _handleDelete(BuildContext context) {
    Alert(
      style: AlertStyle(
        titleStyle: TextStyle(color: isDarkValue ? Colors.white : Colors.black),
        descStyle: TextStyle(color: isDarkValue ? Colors.white : Colors.black),
      ),
      context: context,
      type: AlertType.warning,
      title: "Delete",
      desc: "Are you sure want to delete all todos?",
      buttons: [
        DialogButton(
          onPressed: () {
            _deleteFromDb();
            Navigator.pop(context);

            showSnackbarMsg(
              context: context,
              targetTitle: 'Delete',
              targetMessage: 'All todos have been deleted successfully.',
              type: ContentType.success,
            );
          },
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
          child: const Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

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
          onPressed: () {
            ref
                .watch(todoListProvider.notifier)
                .setTodoList(HiveServices.getAllListsHive());
            showSnackbarMsg(
              context: context,
              targetTitle: 'Refresh',
              targetMessage: 'Refreshing...',
              type: ContentType.help,
            );
          },
          icon: const Icon(
            Icons.refresh,
          ),
        ),
        IconButton(
          onPressed: () {
            _handleDelete(context);
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
