import 'package:flutter/material.dart';
import 'package:animate_icons/animate_icons.dart';
import 'package:untitled/constants/font_sizes.dart';
import '../constants/colors.dart';

class SpecialAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onStartIconPress;
  final VoidCallback onEndIconPress;
  final bool isPrefixOn;

  const SpecialAppBar({
    super.key,
    required this.onStartIconPress,
    required this.onEndIconPress,
    this.isPrefixOn = true,
  });

  @override
  Widget build(BuildContext context) {
    AnimateIconController controller = AnimateIconController();

    return AppBar(
      toolbarHeight: kToolbarHeight + 20,
      scrolledUnderElevation: 0.0,
      // For disabling the changing bg color to darker when scrolling.
      backgroundColor: AppColors.tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isPrefixOn
              ? AnimateIcons(
                  startIconColor: AppColors.tdPurple,
                  endIconColor: AppColors.tdPurple,
                  startIcon: Icons.menu_rounded,
                  endIcon: Icons.date_range_rounded,
                  onStartIconPress: () {
                    onStartIconPress();
                    return true;
                  },
                  onEndIconPress: () {
                    onEndIconPress();
                    return true;
                  },
                  controller: controller,
                  size: largeSize + 10,
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
          const Text(
            'ToDo App',
            style: TextStyle(
              fontFamily: 'Brownist',
              fontSize: largeSize + 20,
              color: AppColors.tdTextDark,
            ),
          ),
          SizedBox(
            width: 55,
            height: 55,
            child: Image.asset('assets/images/avatar.png'),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
