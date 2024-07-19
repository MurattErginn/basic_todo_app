import 'package:flutter/material.dart';
import 'package:untitled/constants/colors.dart';

class CalenderIcon extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CalenderIcon({
    super.key,
    required this.onDateSelected,
  });

  @override
  State<CalenderIcon> createState() => _CalenderIconState();
}

class _CalenderIconState extends State<CalenderIcon> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.calendar_month_rounded, color: AppColors.tdPurple,),
      onPressed: () async {
        final DateTime? dateTime = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(3000),
        );
        if (dateTime != null) {
          setState(() {
            selectedDate = dateTime;
          });
          widget.onDateSelected(selectedDate);
        }
      },
    );
  }
}

