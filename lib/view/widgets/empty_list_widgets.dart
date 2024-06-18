import 'package:flutter/material.dart';

import '../../router/app_routes.dart';

class EmptyListWidgets extends StatelessWidget {
  const EmptyListWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/write_todo.png'),
        const SizedBox(height: 32),
        Text(
          'Create your first to-do-list...',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 32),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 40,
            minWidth: 250,
          ),
          child: ElevatedButton.icon(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              iconAlignment: IconAlignment.start,
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.createNewListRoute),
              label: Text(
                'New List',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.white),
              )),
        ),
      ],
    );
  }
}
