class Task {
  String id;
  String title;
  String note;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.note = '',
    this.isCompleted = false,
  });
}