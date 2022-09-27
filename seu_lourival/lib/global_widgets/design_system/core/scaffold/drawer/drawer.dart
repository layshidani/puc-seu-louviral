import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/drawer/sidenav/sidenav.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold-widget/scaffold-widget.dart';

// TODO: refatorar p/ nao precisar ser stateful
// TODO: preencher c/ dados do usuário
// TODO: refatorar p/ ficar dinâmico os tipos de menu de acordo com o tipo de user
// TODO: refatorar mudança de rota/pagina

class DSDrawer extends StatefulWidget {
  final String title;
  final Widget body;
  final Widget? floatButton;
  final List<Widget>? actions;

  DSDrawer(
      {required this.title,
      required this.body,
      this.floatButton,
      this.actions});

  @override
  _DSDrawerState createState() => _DSDrawerState();
}

class _DSDrawerState extends State<DSDrawer> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: DSColors.primary900,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: const DSDrawerSidenav(),
      child: DSScaffoldWidet(
        title: widget.title,
        body: widget.body,
        leading: getDefaultLeading(),
        floatingActionButton: widget.floatButton,
        actions: widget.actions,
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  IconButton getDefaultLeading() {
    return IconButton(
      onPressed: _handleMenuButtonPressed,
      icon: ValueListenableBuilder<AdvancedDrawerValue>(
        valueListenable: _advancedDrawerController,
        builder: (_, value, __) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Icon(
              value.visible ? Icons.clear : Icons.menu,
              key: ValueKey<bool>(value.visible),
            ),
          );
        },
      ),
    );
  }
}
