import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoei/models/todo_task.dart';

class TodoTile extends StatelessWidget {
  TodoTile({
    super.key,
    required this.task,
    this.onComplete,
  }) : textDecoration =
            task.isComplete ? TextDecoration.lineThrough : TextDecoration.none;

  final TodoTask task;
  final Function(bool?)? onComplete;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 5.0,
                color: task.color,
              ),
              const SizedBox(width: 16.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.name,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          decoration: textDecoration,
                        ),
                  ),
                  const SizedBox(height: 4.0),
                  buildDate(context),
                  const SizedBox(height: 4.0),
                  buildImportance(context),
                ],
              ),
            ],
          ),
          buildCheckbox(),
        ],
      ),
    );
  }

  Widget buildImportance(BuildContext context) {
    if (task.importance == Importance.low) {
      return Text(
        'Low',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              decoration: textDecoration,
            ),
      );
    } else if (task.importance == Importance.medium) {
      return Text(
        'Medium',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w800,
              decoration: textDecoration,
            ),
      );
    } else if (task.importance == Importance.high) {
      return Text(
        'High',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w900,
              color: Colors.red,
              decoration: textDecoration,
            ),
      );
    } else {
      throw Exception('This importance type does not exist');
    }
  }

  Widget buildDate(BuildContext context) {
    final dateFormatter = DateFormat('MMMM dd h:mm a');
    final dateString = dateFormatter.format(task.date);
    return Text(
      dateString,
      style: Theme.of(context)
          .textTheme
          .displaySmall!
          .copyWith(decoration: textDecoration),
    );
  }

  Widget buildCheckbox() {
    return Checkbox(
      value: task.isComplete,
      onChanged: onComplete,
    );
  }
}
