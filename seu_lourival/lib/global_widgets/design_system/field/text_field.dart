import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seu_lourival/core/theme/text_style.dart';
import 'package:seu_lourival/core/values/spacing.dart';

class DSTextField extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final AutovalidateMode autovalidateMode;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final IconData? iconData;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatters;

  DSTextField({
    this.iconData,
    this.keyboardType = TextInputType.text,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.formatters,
    this.maxLines = 1,
    this.onChange,
    this.textCapitalization = TextCapitalization.sentences,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Spacing.s5),
      child: TextFormField(
        textCapitalization: textCapitalization,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: Icon(iconData),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(Spacing.s5),
          // ),
          labelText: labelText,
        ),
        style: DSTextStyle.textBase,
        autovalidateMode: autovalidateMode,
        validator: validator,
        inputFormatters: formatters,
        onChanged: this.onChange,
      ),
    );
  }
}
