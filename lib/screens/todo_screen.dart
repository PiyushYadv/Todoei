import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoei/models/todo_manager.dart';
import 'package:todoei/screens/empty_todo_screen.dart';
import 'package:todoei/screens/todo_item_screen.dart';
import 'package:todoei/screens/todo_list_screen.dart';
import 'package:todoei/theme/todo_theme.dart';
import 'package:todoei/widgets/date.dart';
import 'package:todoei/widgets/tasks.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Date(),
          const Tasks(),
          Expanded(
            child: buildTodoScreen(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: kBackgroundColor,
          size: 36,
        ),
        onPressed: () {
          final manager = Provider.of<TodoManager>(context, listen: false);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TodoItemScreen(
                onCreate: (item) {
                  manager.addTask(item);
                  Navigator.pop(context);
                },
                onUpdate: (item) {},
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTodoScreen() {
    return Consumer<TodoManager>(
      builder: (context, manager, child) {
        if (manager.todoTasks.isNotEmpty) {
          return TodoListScreen(manager: manager);
        } else {
          return const EmptyTodoScreen();
        }
      },
    );
  }
}
