import 'package:flutter/material.dart';
import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';

class DSIconButton extends StatelessWidget {
  final String buttonText;
  final IconData? iconData;
  final Function() onPressAction;

  DSIconButton({
    required this.buttonText,
    required this.onPressAction,
    this.iconData = Icons.check,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton.icon(
            onPressed: onPressAction,
            icon: Icon(iconData),
            label: DSText.base(buttonText),
            style: ElevatedButton.styleFrom(primary: DSColors.primary),
          ),
        ],
      ),
    );
  }
}
