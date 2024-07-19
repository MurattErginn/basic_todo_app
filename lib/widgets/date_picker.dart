import 'package:flutter/material.dart';
import '../constants/font_sizes.dart';
import 'calender_icon.dart';

class DatePickerField extends StatefulWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {

  @override
  Widget build(BuildContext context) {
    String formattedDate = widget.selectedDate != null
        ? '${widget.selectedDate!.day.toString().padLeft(2, '0')}.${widget.selectedDate!.month.toString().padLeft(2, '0')}.${widget.selectedDate!.year}'
        : '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          readOnly: true,
          controller: TextEditingController(text: formattedDate),
          decoration: InputDecoration(
            suffixIcon: CalenderIcon(onDateSelected: widget.onDateSelected),
            hintText: 'DD.MM.YYYY',
            border: const OutlineInputBorder(),
            labelText: 'Date',
            labelStyle: const TextStyle(
              fontSize: smallSize,
            ),
            floatingLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: mediumSize2,
            ),
          ),
        ),
      ],
    );
  }
}
