import 'package:flutter/material.dart';
import 'package:untitled/widgets/priority_picker.dart';
import 'package:untitled/widgets/todo_textfield.dart';
import '../constants/colors.dart';
import '../constants/font_sizes.dart';
import '../models/todo.dart';
import '../widgets/date_picker.dart';
import '../widgets/special_appbar.dart';

class TodoEditing extends StatefulWidget {
  final ToDo todo;

  const TodoEditing({super.key, required this.todo});

  @override
  State<TodoEditing> createState() => _TodoEditingState();
}

class _TodoEditingState extends State<TodoEditing> {
  late String _todoText;
  DateTime? selectedDate;
  String? selectedPriority;

  @override
  void initState() {
    super.initState();
    _todoText = widget.todo.todoText!;
    selectedDate = widget.todo.date;
    selectedPriority = widget.todo.priority;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tdBGColor,
      appBar: SpecialAppBar(
        onStartIconPress: () => print('nice'),
        onEndIconPress: () => print('nice'),
        isPrefixOn: false,
      ),
      resizeToAvoidBottomInset: true,
      // Allows the resizing when keyboard is on.
      body: SingleChildScrollView(
        child: Container(
          width: 500,
          height: 800,
          color: AppColors.tdBGColor,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Todo',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      TodoTextField(
                        initialText: _todoText,
                        onTextChanged: (text) {
                          setState(() {
                            _todoText = text;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      DatePickerField(
                        selectedDate: selectedDate,
                        onDateSelected: _onDateSelected,
                      ),
                      const SizedBox(height: 30),
                      PriorityPickerField(
                        selectedPriority: selectedPriority,
                        onPrioritySelected: (String? newPriority) {
                          setState(() {
                            selectedPriority = newPriority;
                          });
                        },
                      ),
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                            WidgetStatePropertyAll(AppColors.tdPurple),
                            foregroundColor:
                            WidgetStatePropertyAll(AppColors.tdTextLight),
                            textStyle: WidgetStatePropertyAll(
                              TextStyle(
                                fontSize: mediumSize2,
                              ),
                            ),
                          ),
                          onPressed: _editTodo,
                          child: const Text("Save"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _editTodo() {
    if (_todoText.isEmpty || selectedDate == null || selectedPriority == null) {
      return;
    }

    setState(() {
      widget.todo.todoText = _todoText;
      widget.todo.date = selectedDate!;
      widget.todo.priority = selectedPriority!;
    });

    Navigator.pop(context, widget.todo);
  }

    //final todoText = _todoController.text;
/*    if (_todoText.isEmpty || selectedDate == null || selectedPriority == null) {
      return;
    }



    final newTodo = ToDo(
      id: DateTime.now().toString(),
      todoText: _todoText,
      date: selectedDate!,
      priority: selectedPriority!,
      isDone: false,
    );

    Navigator.pop(context, newTodo);
  }*/
}
