import 'package:flutter/material.dart';

import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';

class VisitorsPage extends StatelessWidget {
  const VisitorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSScaffold(
      hasDrawer: true,
      title: 'Financeiro',
      body: Center(
        child: DSText.lg('Visitantes - Em Construção'),
      ),
    );
  }
}
