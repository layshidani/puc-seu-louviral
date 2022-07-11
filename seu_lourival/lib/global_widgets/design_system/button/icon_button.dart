import 'package:flutter/material.dart';
import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';

class DSIconButton extends StatelessWidget {
  final String buttonText;
  final IconData? iconData;
  final void Function()? onPressAction;

  DSIconButton({
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
            // width: 250,
            // child: ElevatedButton.icon(
            //   label: Padding(
            //     padding: EdgeInsets.all(12),
            //     child: DSText.base(
            //       buttonText,
            //     ),
            //   ),
            //   icon: Icon(iconData),
            //   style: ButtonStyle(
            //     backgroundColor:
            //         MaterialStateProperty.all(DSColors.primary),
            //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //       RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(22),
            //       ),
            //     ),
            //   ),
            //   onPressed: onPressAction,
            // ),
            // width: 150,
            child: ElevatedButton.icon(
                onPressed: () => onPressAction,
                icon: Icon(iconData),
                label: DSText.base(buttonText),
                style: ElevatedButton.styleFrom(primary: DSColors.primary)),
          ),
        ],
      ),
    );
  }
}
