import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoScreen extends StatelessWidget {
  final List<Task> tasks;
  final Function(String) onToggleComplete;
  final Function(String) onDeleteTask;

  const TodoScreen({
    super.key,
    required this.tasks,
    required this.onToggleComplete,
    required this.onDeleteTask,
  });

  @override
  Widget build(BuildContext context) {
    final pendingTasks = tasks.where((t) => !t.isCompleted).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand Header
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF007FFF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(Icons.check, color: Colors.white, size: 15),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Taski',
                    style: GoogleFonts.hindSiliguri(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xFF1E293B))),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // Welcome Header
              Row(
                children: [
                  Text(
                    'Welcome, ',
                    style: GoogleFonts.hindSiliguri(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  ),
                  Text(
                    'John.',
                    style: GoogleFonts.hindSiliguri(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF007FFF))),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                pendingTasks.isEmpty 
                    ? 'Create tasks to achieve more.' 
                    : "You've got ${pendingTasks.length} tasks to do.",
                style: GoogleFonts.hindSiliguri(textStyle: const TextStyle(fontSize: 16, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 24),

              // Dynamic Body View
              Expanded(
                child: pendingTasks.isEmpty
                    ? _buildEmptyState(context)
                    : _buildTaskList(pendingTasks),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 0),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Simplified to use your existing graphic directly instead of a complex stack
          Image.asset(
            'assets/icons/cpb.png',
            height: 60,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24),
          Text(
            'You have no task listed.',
            style: GoogleFonts.hindSiliguri(textStyle: const TextStyle(
              fontSize: 16, 
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w500,
            )),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/create'),
            icon: const Icon(Icons.add, size: 20, color: Color(0xFF007FFF), fontWeight: FontWeight.w700),
            label: Text(
              'Create task', 
              style: GoogleFonts.hindSiliguri(textStyle: const TextStyle(
                fontSize: 18, 
                color: Color(0xFF007FFF), 
                fontWeight: FontWeight.w700
              ))
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEDF5FF),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(List<Task> pendingTasks) {
    return ListView.builder(
      itemCount: pendingTasks.length,
      itemBuilder: (context, index) {
        final task = pendingTasks[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7F9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Transform.scale(
              scale: 1.1,
              child: Checkbox(
                value: task.isCompleted,
                activeColor: const Color(0xFF007FFF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
                onChanged: (_) => onToggleComplete(task.id),
              ),
            ),
            title: Text(
              task.title,
              style: GoogleFonts.hindSiliguri(textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF334155),
              )),
            ),
            trailing: const Icon(Icons.more_horiz, color: Color(0xFFCBD5E1)),
          ),
        );
      },
    );
  }
}

// Global Bottom Navigation Helper Shared UI layout across views
Widget _buildBottomNav(BuildContext context, int activeIndex) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: Color(0xFFF1F5F9), width: 1)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal:55),
      child: BottomNavigationBar(
      currentIndex: activeIndex,
      elevation: 0,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF007FFF),
      unselectedItemColor: const Color(0xFF94A3B8),
      selectedFontSize: 12,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
      unselectedFontSize: 12,
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == 0 && activeIndex != 0) Navigator.pushReplacementNamed(context, '/');
        if (index == 1 && activeIndex != 1) Navigator.pushNamed(context, '/create');
        if (index == 2 && activeIndex != 2) Navigator.pushReplacementNamed(context, '/completed');
      },
      items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/check1.png'),
            size: 24,
          ),
          label: 'Todo',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/add.png'),
            size: 24,
          ),
          label: 'Create',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/icons/check.png'),
            size: 24,
          ),
          label: 'Done',
        ),
      ],
      ),
    ),
  );
}