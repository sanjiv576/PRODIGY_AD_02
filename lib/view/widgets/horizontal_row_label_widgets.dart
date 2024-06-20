import 'package:flutter/material.dart';

import '../../entities/list_entity.dart';

class HorizontalRowLabelWidgets extends StatelessWidget {
  const HorizontalRowLabelWidgets({
    super.key,
    required this.singleList,
  });

  final ListEntity singleList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          elevation: 5,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              singleList.label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          singleList.date,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(width: 8),
        Text(
          singleList.time,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
