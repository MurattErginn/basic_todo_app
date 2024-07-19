import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/font_sizes.dart';
import '../models/todo.dart';
import '../pages/todo_editing.dart';

class ToDoItem extends StatefulWidget {
  final ToDo todo;

  final onToDoChanged;
  final onDeleteItem;
  final onEditItem;

  const ToDoItem({
    super.key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
    required this.onEditItem,
  });

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  @override
  Widget build(BuildContext context) {
    final Map<String, Color> priorityColors = {
      "High": AppColors.tdPrioLevelHigh,
      "Medium": AppColors.tdPrioLevelMedium,
      "Low": AppColors.tdPrioLevelLow,
    };

    return Card(
      child: ExpansionTile(
        backgroundColor:
            AppColors.getDarkerColor(priorityColors[widget.todo.priority]!),
        //trailing: const SizedBox(), To make trailing arrow not displayed.
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        collapsedBackgroundColor:
            priorityColors[widget.todo.priority] ?? AppColors.tdTextLight,
        leading: IconButton(
          icon: Icon(
            widget.todo.isDone
                ? Icons.check_box
                : Icons.check_box_outline_blank,
            color: AppColors.tdPurple,
          ),
          onPressed: () {
            setState(() {
              widget.todo.isDone != widget.todo.isDone;
            });
            widget.onToDoChanged(widget.todo);
          },
        ),
        title: Text(
          widget.todo.todoText!, //+ ' (' + todo.date! +')',
          style: TextStyle(
            fontSize: mediumSize,
            color: AppColors.tdBlack,
            decoration: widget.todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.tdDarkGrey,
                ),
                onPressed: () async {
                  final editedToDo = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TodoEditing(todo: widget.todo),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.tdDarkGrey,
                ),
                onPressed: () {
                  widget.onDeleteItem(widget.todo.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
