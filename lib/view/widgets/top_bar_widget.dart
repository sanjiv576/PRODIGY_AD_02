import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../services/hive_services.dart';
import '../../services/tutorial.dart';
import '../../state/app_theme_state.dart';
import '../../state/todo_list_notifier.dart';
import 'show_snackbar.dart';

class TopBarWidget extends StatefulWidget {
  const TopBarWidget({
    super.key,
    required this.ref,
    required this.isDarkValue,
  });

  final WidgetRef ref;
  final bool isDarkValue;

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  final GlobalKey _refreshButtonKey = GlobalKey();
  final GlobalKey _deleteButtonKey = GlobalKey();

  final GlobalKey _changeThemeButtonKey = GlobalKey();

  late bool? _isShownTutorial;

  @override
  void initState() {
    super.initState();

    _getTutorial();
  }

  void _deleteFromDb() async {
    await HiveServices.clearAllBox(); // from db
    widget.ref.watch(todoListProvider.notifier).setTodoList([]); // clear state
  }

  void _handleDelete(BuildContext context) {
    Alert(
      style: AlertStyle(
        titleStyle:
            TextStyle(color: widget.isDarkValue ? Colors.white : Colors.black),
        descStyle:
            TextStyle(color: widget.isDarkValue ? Colors.white : Colors.black),
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

  void _getTutorial() async {
    _isShownTutorial = await Tutorial.isTutorialAlreadyShown();
    if (_isShownTutorial == null || _isShownTutorial == false) {
      showTutorials();
      // await Tutorial.setTutorialValue(true);
    }
  }

  void showTutorials() {
    final targets = [
      TargetFocus(
        color: Colors.pink,
        identify: 'refreshButton',
        alignSkip: AlignmentDirectional.bottomCenter,
        keyTarget: _refreshButtonKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Expanded(
                child: Center(
                  child: Text(
                    'Click here to load the latest data.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      TargetFocus(
        color: Colors.pink,
        identify: 'deleteButton',
        alignSkip: AlignmentDirectional.bottomCenter,
        keyTarget: _deleteButtonKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Expanded(
                child: Center(
                  child: Text(
                    'Click here to delete all todos.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      TargetFocus(
        color: Colors.pink,
        identify: 'changeButton',
        keyTarget: _changeThemeButtonKey,
        alignSkip: AlignmentDirectional.bottomCenter,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Expanded(
                child: Center(
                  child: Text(
                    'Click here to toggle application theme.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ];

    final tutorial = TutorialCoachMark(
      targets: targets,
      onFinish: () {
        log("finish");
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        log("target: $target");
        log("Clickd at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickTarget: (target) {
        print(target);
      },
    );
    tutorial.show(context: context);
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
          key: _refreshButtonKey,
          onPressed: () {
            widget.ref
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
          key: _deleteButtonKey,
          onPressed: () {
            _handleDelete(context);
          },
          icon: const Icon(
            Icons.delete,
          ),
        ),
        IconButton(
          key: _changeThemeButtonKey,
          onPressed: () {
            widget.ref
                .watch(isDarkThemeProvider.notifier)
                .updateTheme(!widget.ref.watch(isDarkThemeProvider));
          },
          icon: Icon(
            widget.isDarkValue ? FontAwesomeIcons.moon : Icons.sunny,
          ),
        ),
      ],
    );
  }
}
