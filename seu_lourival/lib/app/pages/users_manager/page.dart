import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:seu_lourival/app/pages/users_manager/widgets/tabbar.dart';

import '../../../global_widgets/design_system/core/scaffold/scaffold.dart';

class UsersManagerPage extends StatelessWidget {
  const UsersManagerPage({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return DSScaffold(
      title: 'Gerenciamento de usuários',
      body: UsersManagerTabbar(),
    );
  }
}
