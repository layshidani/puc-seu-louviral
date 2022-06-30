import 'package:flutter/material.dart';

import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';

class UsersManagerPage extends StatelessWidget {
  const UsersManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSScaffold(
      title: 'Gerenciamento de usuários',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DSText.lg('Gerenciamento de usuários - Em Construção'),
        ],
      ),
    );
  }
}
