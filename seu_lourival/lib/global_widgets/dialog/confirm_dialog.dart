import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';

class DSConfirmDialog {
  final String title;
  final String descriptionLine1;
  final String descriptionLine2;
  final BuildContext context;
  final Future<void> Function()? onConfirmAction;

  DSConfirmDialog({
    required this.context,
    required this.title,
    required this.descriptionLine1,
    this.descriptionLine2 = '',
    this.onConfirmAction,
  });

  Future<void> show() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: DSTitle.sm(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                DSText.base(descriptionLine1),
                DSText.base(descriptionLine2),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: DSText.base('Cancelar'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              onPressed: onConfirmAction,
              child: DSText.base('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
