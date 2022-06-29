import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:seu_lourival/core/theme/custom_text_style.dart';

class CustomTitle extends StatelessWidget {
  final String text;
  final TextStyle? style;

  CustomTitle({required this.text, this.style = CustomTextStyle.titleBase});

  @override
  Widget build(BuildContext context) {
     return Center(
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
