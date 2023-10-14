import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoei/models/todo_manager.dart';
import 'package:todoei/theme/todo_theme.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TodoManager>(context);
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 30,
        right: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${tasks.todoTasks.length}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Created Tasks',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: kInactiveColor,
                    ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${tasks.completedTasks}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Completed Tasks',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: kInactiveColor,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
