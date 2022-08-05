import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:seu_lourival/core/values/colors.dart';

class CustomSnackBar {
  final String title;
  final Duration duration;
  final SnackbarStyle style;

  CustomSnackBar({
    required this.title,
    this.duration = const Duration(seconds: 3),
    this.style = SnackbarStyle.info,
  });

  GetSnackBar build() {
    return GetSnackBar(
      duration: duration,
      messageText: Text(
        title,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: style.titleColor,
        ),
      ),
      backgroundColor: style.backgroundColor ?? Colors.grey,
    );
  }
}

enum SnackbarStyle {
  success,
  error,
  info;

  Color? get backgroundColor {
    switch (this) {
      case SnackbarStyle.success:
        return DSColors.success;
      case SnackbarStyle.error:
        return DSColors.error;
      case SnackbarStyle.info:
        return DSColors.info;
    }
  }

  Color? get titleColor {
    return Colors.white;
  }
}
