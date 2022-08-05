import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seu_lourival/core/theme/text_style.dart';
import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/core/values/login_strings.dart';
import 'package:seu_lourival/core/values/spacing.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';

class DSTextField extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final AutovalidateMode autovalidateMode;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final String prefix;
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
    this.prefix = '',
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
          suffixIcon: Icon(iconData, color: DSColors.primary,),
          prefix: DSText.base(prefix),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(Spacing.s5),
          // ),
          labelText: labelText,
          labelStyle: const TextStyle(color: DSColors.primary),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: DSColors.primary),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: DSColors.primary),
          ),
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
