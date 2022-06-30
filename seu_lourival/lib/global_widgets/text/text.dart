import 'package:flutter/material.dart';
import 'package:seu_lourival/core/theme/custom_text_style.dart';

class DSText {
  static Text base(String text) {
    return getWidget(text, CustomTextStyle.textBase);
  }
  static Text sm(String text) {
    return getWidget(text, CustomTextStyle.textSm);
  }
  static Text lg(String text) {
    return getWidget(text, CustomTextStyle.textLg);
  }

  static Text getWidget(String text, TextStyle type) {
    return Text(text, style: type);
  }
}
