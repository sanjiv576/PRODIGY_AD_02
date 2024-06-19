import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
