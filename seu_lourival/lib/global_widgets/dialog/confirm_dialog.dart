import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';

class DSConfirmDialog {
  final String title;
  final String descriptionLine1;
  final String descriptionLine2;
  final BuildContext context;
  final bool shouldHideCancel;
  final Function()? onConfirmAction;

  DSConfirmDialog({
    required this.context,
    required this.title,
    required this.descriptionLine1,
    required this.onConfirmAction,
    this.shouldHideCancel = false,
    this.descriptionLine2 = '',
  });

  Future<void> show() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
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
            shouldHideCancel
                ? Container()
                : TextButton(
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
