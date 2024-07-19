import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:untitled/constants/colors.dart';

class DatePickerTimeline extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const DatePickerTimeline({required this.onDateSelected, super.key});

  @override
  State<DatePickerTimeline> createState() => _DatePickerTimelineState();
}

class _DatePickerTimelineState extends State<DatePickerTimeline> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.tdLightGrey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DatePicker(
              height: 100,
              DateTime.now(),
              initialSelectedDate: selectedDate,
              selectionColor: AppColors.tdBlue,
              selectedTextColor: Colors.white,
              daysCount: _getDaysCount(),
              onDateChange: (date) {
                // New date selected
                setState(() {
                  selectedDate = date;
                  widget.onDateSelected(date); //Home.of(context)?.updateSelectedDate(date); // Notify Home widget about date change
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  int _getDaysCount() {
    DateTime now = DateTime.now();
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);// last day of current month

    return lastDayOfMonth.day - now.day;
  }
}
