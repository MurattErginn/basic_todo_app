import 'package:flutter/material.dart';
import 'package:untitled/constants/font_sizes.dart';


class TodoTextField extends StatefulWidget {
  final Function(String) onTextChanged;
  final String? initialText;

  const TodoTextField(
      {
        super.key,
        required this.onTextChanged,
        this.initialText,
      });

  @override
  State<TodoTextField> createState() => _TodoTextFieldState();
}

class _TodoTextFieldState extends State<TodoTextField> {
  late TextEditingController _todoController;

  @override
  void initState() {
    super.initState();
    _todoController = TextEditingController(text: widget.initialText);
    _todoController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _todoController.removeListener(_onTextChanged);
    _todoController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    widget.onTextChanged(_todoController.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _todoController,
      decoration: const InputDecoration(
        //prefixIcon: Icon(Icons.task_rounded, color: tdPurple,),
        hintText: 'Enter your todo',
        border: OutlineInputBorder(),
        labelText: 'Todo',
        labelStyle: TextStyle(
          fontSize: smallSize,
        ),
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: mediumSize2,
        ),
      ),
    );
  }
}
