import 'package:flutter/material.dart';
import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';

class DSScaffoldWidet extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? leading;
  final List<Widget>? actions;

  DSScaffoldWidet(
      {required this.title,
      required this.body,
      this.floatingActionButton,
      this.leading,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DSColors.primary,
        title: DSTitle.base(title),
        leading: leading,
        actions: actions,
      ),
      floatingActionButton: floatingActionButton,
      body: body,
    );
  }
}
