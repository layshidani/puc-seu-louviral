import 'package:flutter/material.dart';
import 'package:seu_lourival/core/theme/custom_text_style.dart';
import 'package:seu_lourival/core/values/custom_colors.dart';
import 'package:seu_lourival/global_widgets/text/text.dart';

class MyIconButton extends StatelessWidget {
  final String buttonText;
  final IconData? iconData;
  final void Function()? onPressAction;

  MyIconButton({
    required this.buttonText,
    this.iconData = Icons.check,
    this.onPressAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 250,
            child: ElevatedButton.icon(
              label: Padding(
                padding: EdgeInsets.all(12),
                child: CustomText(
                  text: buttonText,
                ),
              ),
              icon: Icon(iconData),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(CustomColors.primary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
              ),
              onPressed: onPressAction,
            ),
          ),
        ],
      ),
    );
  }
}
