import 'package:flutter/cupertino.dart';
import 'package:seu_lourival/app/modules/add_users/widgets/tabbar.dart';


import '../../../global_widgets/design_system/core/scaffold/scaffold.dart';

class AddUsersPage extends StatelessWidget {
  const AddUsersPage({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return DSScaffold(
      title: 'Gerenciamento de usuários',
      body: UsersManagerTabbar(),
    );
  }
}
