import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTaskScreen extends StatefulWidget {
  final Function(String, String) onAddTask;

  const CreateTaskScreen({super.key, required this.onAddTask});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  void _submitData() {
    final enteredTitle = _titleController.text.trim();
    final enteredNote = _noteController.text.trim();

    if (enteredTitle.isEmpty) return;

    widget.onAddTask(enteredTitle, enteredNote);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Task Input with Checkbox Indicator Prefix
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      autofocus: true,
                      style: GoogleFonts.hindSiliguri(textStyle: const TextStyle(fontSize: 16, color: Color(0xFF1E293B))),
                      decoration: const InputDecoration(
                        hintText: "What's in your mind?",
                        hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Notes Input Field
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2.0, left: 2),
                    child: Icon(Icons.edit_rounded, size: 20, color: Color(0xFFCBD5E1)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _noteController,
                      maxLines: null,
                      style: GoogleFonts.hindSiliguri(textStyle: const TextStyle(fontSize: 15, color: Color(0xFF475569))),
                      decoration: const InputDecoration(
                        hintText: 'Add a note',
                        hintStyle: TextStyle(color: Color(0xFFCBD5E1)),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              
              // Create Task Bottom Drawer Action Button
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEDF5FF),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 13)),
                    const Icon(Icons.add, color: Color(0xFF007FFF), size: 20),
                    const SizedBox(width: 6),
                    Text(
                      'Create task',
                      style: GoogleFonts.hindSiliguri(textStyle: const TextStyle(
                        color: Color(0xFF007FFF),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}