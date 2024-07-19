import 'package:untitled/constants/priority_level.dart';

class ToDo {
  String? id;
  String? todoText = 'default';
  DateTime date = DateTime.now();
  String priority;//Priority levels => High:red, Medium: yellow, Low: blue
  bool isDone;
  bool isTodoExpanded = false;

  ToDo({    
    required this.id,
    required this.todoText,
    required this.date,
    this.priority = prioLevelMedium,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    DateTime today = DateTime.now();
    DateTime tomorrow = DateTime(today.year, today.month, today.day + 1);
    DateTime twoDaysLater = DateTime(today.year, today.month, today.day + 2);
    DateTime threeDaysLater = DateTime(today.year, today.month, today.day + 3);

    return [
      ToDo(id: '01', todoText: 'Wake up', isDone: true, date: today, priority: prioLevelHigh),
      ToDo(id: '02', todoText: 'Have breakfast', isDone: true, date: today, priority: prioLevelLow),
      ToDo(id: '03', todoText: 'Cloth up', date: today, priority: prioLevelMedium),
      ToDo(id: '04', todoText: 'Go to Work', date: tomorrow, priority: prioLevelMedium),
      ToDo(id: '05', todoText: 'Have Lunch', date: tomorrow, priority: prioLevelMedium),
      ToDo(id: '06', todoText: 'Go back to home', date: tomorrow, priority: prioLevelMedium),
      ToDo(id: '07', todoText: 'Have dinner', date: tomorrow, priority: prioLevelLow),
      ToDo(id: '08', todoText: 'Go to Sleep', date: tomorrow, priority: prioLevelLow),
      ToDo(id: '09', todoText: 'Go to Market', date: tomorrow, priority: prioLevelMedium),
      ToDo(id: '10', todoText: 'Go to School', date: twoDaysLater, priority: prioLevelLow),
      ToDo(id: '11', todoText: 'Go to School2', date: twoDaysLater, priority: prioLevelHigh),
      ToDo(id: '12', todoText: 'Go to School3', date: twoDaysLater, priority: prioLevelLow),
      ToDo(id: '13', todoText: 'Go to School4', date: twoDaysLater, priority: prioLevelHigh),
      ToDo(id: '14', todoText: 'Demo todo 1', date: twoDaysLater, priority: prioLevelHigh),
      ToDo(id: '15', todoText: 'Demo todo 2', date: twoDaysLater, priority: prioLevelHigh),
      ToDo(id: '16', todoText: 'Demo todo 3', date: threeDaysLater, priority: prioLevelHigh),
      ToDo(id: '17', todoText: 'Demo todo 4', date: threeDaysLater, priority: prioLevelLow),
      ToDo(id: '18', todoText: 'Demo todo 5', date: threeDaysLater, priority: prioLevelLow),
      ToDo(id: '19', todoText: 'Demo todo 6', date: threeDaysLater, priority: prioLevelLow),
      ToDo(id: '20', todoText: 'Demo todo 7', date: threeDaysLater, priority: prioLevelMedium),
      ToDo(id: '21', todoText: 'Demo todo 8', date: threeDaysLater, priority: prioLevelMedium),
    ];
  }

  @override
  String toString() {
    return 'ToDo{id: $id, todoText: $todoText, date: $date, isDone: $isDone, priority: $priority}';
  }

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      todoText: json['todoText'],
      date: DateTime.parse(json['date']),
      isDone: json['isDone'],
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todoText': todoText,
      'date': date.toIso8601String(),
      'isDone': isDone,
      'priority': priority,
    };
  }
}