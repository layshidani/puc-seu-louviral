import 'package:flutter/material.dart';
import 'package:seu_lourival/core/theme/text_style.dart';

class DSTitle {
  static Text base(String title) {
    return getWidget(title, DSTextStyle.titleBase);
  }

  static Text sm(String title) {
    return getWidget(title, DSTextStyle.titleSm);
  }

  static Text lg(String title) {
    return getWidget(title, DSTextStyle.titleLg);
  }

  static Text getWidget(String text, TextStyle type) {
    return Text(text, style: type);
  }
}
