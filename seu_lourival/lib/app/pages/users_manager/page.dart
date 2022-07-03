import 'package:flutter/material.dart';
import 'package:seu_lourival/app/pages/users_manager/widgets/tabbar.dart';
import 'package:seu_lourival/core/values/colors.dart';

import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';

class UsersManagerPage extends StatefulWidget {
  const UsersManagerPage({Key? key}) : super(key: key);

  @override
  State<UsersManagerPage> createState() => _UsersManagerPageState();
}

class _UsersManagerPageState extends State<UsersManagerPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DSScaffold(
      title: 'Gerenciamento de usuários',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const UsersManagerTabbar(),
        ],
      ),
    );
  }
}
