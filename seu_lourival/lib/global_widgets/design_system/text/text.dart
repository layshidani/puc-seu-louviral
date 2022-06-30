import 'package:flutter/material.dart';
import 'package:seu_lourival/core/theme/text_style.dart';

class DSText {
  static Text base(String text) {
    return getWidget(text, DSTextStyle.textBase);
  }
  static Text sm(String text) {
    return getWidget(text, DSTextStyle.textSm);
  }
  static Text lg(String text) {
    return getWidget(text, DSTextStyle.textLg);
  }

  static Text getWidget(String text, TextStyle type) {
    return Text(text, style: type);
  }
}
