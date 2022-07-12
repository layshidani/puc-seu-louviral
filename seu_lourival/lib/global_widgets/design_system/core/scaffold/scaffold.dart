import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/global_widgets/design_system/core/drawer/drawer.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';

// TODO: refatorar p/ nao precisar ser stateful
// TODO: preencher c/ dados do usuário
// TODO: refatorar p/ ficar dinâmico os tipos de menu de acordo com o tipo de user
// TODO: refatorar mudança de rota/pagina

class DSScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final Widget? floatButton;
  final bool hasDrawer;

  const DSScaffold(
      {required this.title,
      required this.body,
      this.floatButton,
      this.hasDrawer = false
      });

  @override
  _DSScaffoldState createState() => _DSScaffoldState();
}

class _DSScaffoldState extends State<DSScaffold> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: DSColors.primaryDark,
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
      drawer: const DSDrawer(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: DSColors.primary,
          title: DSText.base(widget.title),
          leading: IconButton(
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
          ),
        ),
        floatingActionButton: widget.floatButton,
        body: widget.body,
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
