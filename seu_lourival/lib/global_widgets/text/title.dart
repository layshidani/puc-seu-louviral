import 'package:flutter/material.dart';
import 'package:seu_lourival/core/theme/custom_text_style.dart';

class DSTitle {
  static Text base(String title) {
    return getWidget(title, CustomTextStyle.titleBase);
  }

  static Text sm(String title) {
    return getWidget(title, CustomTextStyle.titleSm);
  }

  static Text lg(String title) {
    return getWidget(title, CustomTextStyle.titleLg);
  }

  static Text getWidget(String text, TextStyle type) {
    return Text(text, style: type);
  }
}
