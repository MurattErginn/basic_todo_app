import 'package:flutter/material.dart';

class AppColors {
  static const Color tdRed = Color(0xffff6b6b);
  static const Color tdPurple = Color(0xff3742fa);

  static const Color tdFGColor = Color(0xff6c5ce7);
  static const Color tdBGColor = Color(0xffffffff);

  static const Color tdBlack = Color(0xFF2d3436);
  static const Color tdBlue = Color(0xff3742fa);
  static const Color tdGrey = Color(0xffebebeb);
  static const Color tdDarkGrey = Color(0xff5c5e63);
  static const Color tdLightGrey = Color(0xfff7f7f7);

  static const Color tdTextLight = Color(0xfff7f6ff);
  static const Color tdTextDark = Color(0xff2c2a32);

  static const Color tdPrioLevelHigh = Color(0xffff7675);
  static const Color tdPrioLevelMedium = Color(0xffffeaa7);
  static const Color tdPrioLevelLow = Color(0xff81ecec);

  static Color getDarkerColor(Color color, [double factor = 0.95]) {
    assert(0 <= factor && factor <= 1);

    return Color.fromRGBO(
      (color.red * factor).round(),
      (color.green * factor).round(),
      (color.blue * factor).round(),
      1,
    );
  }

  static Color getLighterColor(Color color, [double factor = 1.1]) {
    assert(factor >= 1);

    return Color.fromRGBO(
      (color.red * factor).clamp(0, 255).round(),
      (color.green * factor).clamp(0, 255).round(),
      (color.blue * factor).clamp(0, 255).round(),
      1,
    );
  }
}
