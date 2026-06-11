import 'package:flutter/material.dart';
import 'models/task.dart';
import 'screens/todo_task_screen.dart';
import 'screens/create_task_screen.dart';
import 'screens/completed_task_screen.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(const TaskiApp());
}

class TaskiApp extends StatefulWidget {
  const TaskiApp({super.key});

  @override
  State<TaskiApp> createState() => _TaskiAppState();
}

class _TaskiAppState extends State<TaskiApp> {
  // Shared runtime source repository
  final List<Task> _allTasks = [];

  void _addNewTask(String title, String note) {
    setState(() {
      _allTasks.add(
        Task(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          note: note,
        ),
      );
    });
  }

  void _toggleTaskCompletion(String id) {
    setState(() {
      final taskIndex = _allTasks.indexWhere((task) => task.id == id);
      if (taskIndex >= 0) {
        _allTasks[taskIndex].isCompleted = !_allTasks[taskIndex].isCompleted;
      }
    });
  }

  void _deleteTask(String id) {
    setState(() {
      _allTasks.removeWhere((task) => task.id == id);
    });
  }

  void _clearAllCompletedTasks() {
    setState(() {
      _allTasks.removeWhere((task) => task.isCompleted);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taski Todo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.hindSiliguri().fontFamily, // Fits standard modern platform layouts perfectly
        primaryColor: const Color(0xFF007FFF),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TodoScreen(
              tasks: _allTasks,
              onToggleComplete: _toggleTaskCompletion,
              onDeleteTask: _deleteTask,
            ),
        '/create': (context) => CreateTaskScreen(
              onAddTask: _addNewTask,
            ),
        '/completed': (context) => CompletedScreen(
              tasks: _allTasks,
              onDeleteTask: _deleteTask,
              onDeleteAllCompleted: _clearAllCompletedTasks,
            ),
      },
    );
  }
}