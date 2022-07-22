import 'package:flutter/cupertino.dart';

import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';

class BillboardPage extends StatelessWidget {
  const BillboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return DSScaffold(
      hasDrawer: true,
      title: 'Comunicados',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DSText.lg('Comunicados - Em Construção'),
        ],
      ),
    );
  }
}
