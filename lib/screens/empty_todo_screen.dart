import 'package:flutter/material.dart';

class EmptyTodoScreen extends StatelessWidget {
  const EmptyTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No Tasks Left!',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
