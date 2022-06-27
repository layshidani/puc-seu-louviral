import 'package:flutter/material.dart';
import 'package:seu_lourival/core/values/custom_colors.dart';

class CustomTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: CustomColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: CustomColors.primary,
    ),
  );
}
