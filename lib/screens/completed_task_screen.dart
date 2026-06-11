import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedScreen extends StatelessWidget {
  final List<Task> tasks;
  final Function(String) onDeleteTask;
  final Function() onDeleteAllCompleted;

  const CompletedScreen({
    super.key,
    required this.tasks,
    required this.onDeleteTask,
    required this.onDeleteAllCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks.where((t) => t.isCompleted).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF007FFF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(Icons.check, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Taski',
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E293B),
                    ),
                    
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // Action Subheaders Dashboard Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Completed Tasks',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  ),
                  if (completedTasks.isNotEmpty)
                    TextButton(
                      onPressed: onDeleteAllCompleted,
                      style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 0)),
                      child: const Text(
                        'Delete all',
                        style: TextStyle(color: Color(0xFFFF4D4D), fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // Completed Items Loop View Wrapper
              Expanded(
                child: completedTasks.isEmpty
                    ? const Center(
                        child: Text(
                          'No completed tasks yet.',
                          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )
                    : ListView.builder(
                        itemCount: completedTasks.length,
                        itemBuilder: (context, index) {
                          final task = completedTasks[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              leading: Transform.scale(
                                scale: 1.1,
                                child: Checkbox(
                                  value: true,
                                  activeColor: const Color(0xFFDDE3EA),
                                  checkColor: const Color(0xFFFFFFFF),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  side: BorderSide.none,
                                  onChanged: (_) {},
                                ),
                              ),
                              title: Text(
                                task.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF94A3B8),
                                  decoration: TextDecoration.none, // Kept regular as per custom layout graphic
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Color(0xFFFF4D4D), size: 20),
                                onPressed: () => onDeleteTask(task.id),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 2),
    );
  }

  // Uses custom Bottom Bar method extracted globally inside todo.dart source setup block context.
  Widget _buildBottomNav(BuildContext context, int activeIndex) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9), width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
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
          if (index == 0) Navigator.pushReplacementNamed(context, '/');
          if (index == 1) Navigator.pushNamed(context, '/create');
          if (index == 2) Navigator.pushReplacementNamed(context, '/completed');
        },
        items: const [
  BottomNavigationBarItem(
    icon: Center(
      child: ImageIcon(
        AssetImage('assets/icons/check1.png'),
        size: 24,
      ),
    ),
    label: 'Todo',
  ),

  BottomNavigationBarItem(
    icon: Center(
      child: ImageIcon(
        AssetImage('assets/icons/add.png'),
        size: 24,
      ),
    ),
    label: 'Create',
  ),

  BottomNavigationBarItem(
    icon: Center(
      child: ImageIcon(
        AssetImage('assets/icons/check.png'),
        size: 24,
      ),
    ),
    label: 'Done',
  ),
],
      ),
    );
  }
}