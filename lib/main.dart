import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoei/models/todo_manager.dart';
import 'package:todoei/screens/todo_screen.dart';
import 'package:todoei/theme/todo_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => TodoManager(),
        child: const TodoScreen(),
      ),
      theme: TodoTheme.todoThemeData,
    );
  }
}
