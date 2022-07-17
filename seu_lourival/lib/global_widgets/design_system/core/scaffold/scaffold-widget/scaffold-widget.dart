import 'package:flutter/material.dart';
import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';

class DSScaffoldWidet extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? leading;

  DSScaffoldWidet({required this.title, required this.body, this.floatingActionButton, this.leading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DSColors.primary,
        title: DSText.base(title),
        leading: leading,
      ),
      floatingActionButton: floatingActionButton,
      body: body,
    );
  }
}
