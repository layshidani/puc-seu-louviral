import 'package:flutter/material.dart';

class CustomConfirmAlertDialog {
  String title;
  String? description;
  String cancelTitle;
  String confirmTitle;
  VoidCallback? confirmAction;
  VoidCallback? cancelAction;

  CustomConfirmAlertDialog({
    required this.title,
    this.description,
    this.confirmAction,
    this.cancelAction,
    this.cancelTitle = "Cancelar",
    this.confirmTitle = "Salvar",
  });

  AlertDialog build() {
    return AlertDialog(
      title: Text(title),
      content: description != null ? Text(description ?? "") : null,
      actions: [
        TextButton(onPressed: cancelAction, child: Text(cancelTitle)),
        TextButton(onPressed: confirmAction, child: Text(confirmTitle)),
      ],
    );
  }
}
