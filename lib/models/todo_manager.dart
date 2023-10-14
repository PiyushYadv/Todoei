import 'package:flutter/material.dart';
import 'package:todoei/models/todo_task.dart';

class TodoManager extends ChangeNotifier {
  final _todoTasks = <TodoTask>[];

  int _completedTasks = 0;

  int get completedTasks => _completedTasks;

  List<TodoTask> get todoTasks => List.unmodifiable(_todoTasks);

  void currentTasks() {
    _todoTasks.length;
    notifyListeners();
  }

  void deleteTask(int index) {
    _todoTasks.removeAt(index);
    notifyListeners();
  }

  void addTask(TodoTask item) {
    _todoTasks.add(item);
    notifyListeners();
  }

  void updateTask(TodoTask item, int index) {
    _todoTasks[index] = item;
    notifyListeners();
  }

  void completeTask(int index, bool change) {
    final task = _todoTasks[index];
    _todoTasks[index] = task.copyWith(isComplete: change);
    _completedTasks++;
    notifyListeners();
  }

  void dissmissTask() {
    _completedTasks--;
  }
}
