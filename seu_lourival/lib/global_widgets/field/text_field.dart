import 'package:flutter/material.dart';
import 'package:seu_lourival/core/theme/custom_text_style.dart';
import 'package:seu_lourival/core/theme/spacing.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final AutovalidateMode autovalidateMode;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final IconData? iconData;
  final Function(String)? onChange;
  final String? Function(String?)? validator;

  CustomTextField({
    this.iconData,
    this.keyboardType = TextInputType.text,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Spacing.s5),
          ),
          labelText: labelText,
        ),
        style: CustomTextStyle.textBase,
        autovalidateMode: autovalidateMode,
        validator: validator,
        onChanged: this.onChange,
      ),
    );
  }
}
