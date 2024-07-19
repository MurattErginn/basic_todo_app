import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/font_sizes.dart';

class PriorityPickerField extends StatefulWidget {
  final String? selectedPriority;
  final ValueChanged<String?> onPrioritySelected;

  const PriorityPickerField({
    Key? key,
    required this.selectedPriority,
    required this.onPrioritySelected,
  }) : super(key: key);

  @override
  State<PriorityPickerField> createState() => _PriorityPickerFieldState();
}

class _PriorityPickerFieldState extends State<PriorityPickerField> {
  final List<String> priorityLevels = ['High', 'Medium', 'Low'];
  final Map<String, Color> priorityColors = {
    'High': AppColors.tdPrioLevelHigh,
    'Medium': AppColors.tdPrioLevelMedium,
    'Low': AppColors.tdPrioLevelLow,
  };

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.selectedPriority,
      onChanged: widget.onPrioritySelected,
      dropdownColor: AppColors.tdBGColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: priorityColors[widget.selectedPriority] ?? Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        border: OutlineInputBorder(),
        labelText: 'Priority',
        labelStyle: const TextStyle(
          fontSize: smallSize,
        ),
        floatingLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: mediumSize2,
        ),
      ),
      items: priorityLevels.map((String priority) {
        return DropdownMenuItem<String>(
            value: priority,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: priorityColors[priority],
                  radius: 10,
                ),
                SizedBox(width: 8,),
                Text(priority),
              ],
            ),
        );
      }).toList(),
    );
  }



  /*Widget build(BuildContext context) {
    return CustomRadioButton(
      elevation: 0,
      absoluteZeroSpacing: true,
      unSelectedColor: Theme.of(context).canvasColor,
      buttonLables: [
        'Student',
        'Parent',
        'Teacher',
      ],
      buttonValues: [
        "STUDENT",
        "PARENT",
        "TEACHER",
      ],
      buttonTextStyle: ButtonTextStyle(
          selectedColor: Colors.white,
          unSelectedColor: Colors.black,
          textStyle: TextStyle(fontSize: 16)),
      radioButtonValue: (value) {
        print(value);
      },
      selectedColor: Colors.red,
    );
  }*/


}
