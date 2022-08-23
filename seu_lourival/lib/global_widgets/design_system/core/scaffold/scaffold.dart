import 'package:flutter/material.dart';

import 'package:seu_lourival/global_widgets/design_system/core/scaffold/drawer/drawer.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold_widget/scaffold_widget.dart';


class DSScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool? hasDrawer;
  final Widget? floatingActionButton;

  const DSScaffold(
      {Key? key, this.hasDrawer = false,
      required this.title,
      required this.body,
      this.floatingActionButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (hasDrawer == true)
        ? DSDrawer(title: title, body: body, floatButton: floatingActionButton)
        : DSScaffoldWidet(
            title: title,
            body: body,
            floatingActionButton: floatingActionButton,
          );
  }
}
