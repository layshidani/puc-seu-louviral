import 'package:flutter/cupertino.dart';
import 'package:seu_lourival/app/modules/users_manager/widgets/tabbar.dart';
import 'package:seu_lourival/core/values/strings.dart';
import '../../../global_widgets/design_system/core/scaffold/scaffold.dart';

class UsersManagerPage extends StatelessWidget {
  const UsersManagerPage({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return DSScaffold(
      hasDrawer: true,
      title: UsersManagerStrings.scaffoldTitle,
      body: UsersManagerTabbar(),
    );
  }
}
