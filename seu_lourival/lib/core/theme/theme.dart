import 'package:flutter/material.dart';
import 'package:seu_lourival/core/values/colors.dart';

class DSTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: DSColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: DSColors.primary,
    ),
  );
}
