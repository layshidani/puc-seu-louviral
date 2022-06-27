import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String buttonText;
  final IconData? iconData;
  final void Function()? onPressAction;

  CustomIconButton({
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
                child: Text(
                  buttonText,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              icon: Icon(iconData),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 45, 84, 116)),
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
