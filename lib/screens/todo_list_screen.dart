import 'package:flutter/material.dart';
import 'package:todoei/models/todo_manager.dart';
import 'package:todoei/screens/todo_item_screen.dart';
import 'package:todoei/widgets/todo_tile.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({
    super.key,
    required this.manager,
  });

  final TodoManager manager;

  @override
  Widget build(BuildContext context) {
    final taskItems = manager.todoTasks;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final task = taskItems[index];
          return Dismissible(
            key: Key(task.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            onDismissed: (direction) {
              manager.deleteTask(index);
              manager.dissmissTask();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${task.name} removed'),
                ),
              );
            },
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoItemScreen(
                    originalTask: task,
                    onCreate: (item) {},
                    onUpdate: (item) {
                      manager.updateTask(item, index);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              child: TodoTile(
                key: Key(task.id),
                task: task,
                onComplete: (change) {
                  if (change != null) {
                    manager.completeTask(index, change);
                  }
                },
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
        itemCount: taskItems.length,
      ),
    );
  }
}
