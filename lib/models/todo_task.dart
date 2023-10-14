import 'package:flutter/painting.dart';

enum Importance {
  low,
  medium,
  high,
}

class TodoTask {
  final String id;
  final String name;
  final Importance importance;
  final Color color;
  final DateTime date;
  final bool isComplete;

  TodoTask({
    required this.id,
    required this.name,
    required this.importance,
    required this.color,
    required this.date,
    this.isComplete = false,
  });

  TodoTask copyWith({
    String? id,
    String? name,
    Importance? importance,
    Color? color,
    DateTime? date,
    bool? isComplete,
  }) {
    return TodoTask(
      id: id ?? this.id,
      name: name ?? this.name,
      importance: importance ?? this.importance,
      color: color ?? this.color,
      date: this.date,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
