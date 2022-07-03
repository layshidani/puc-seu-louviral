import 'package:flutter/material.dart';

import 'package:seu_lourival/app/pages/users_manager/pre-register/list/page.dart';
import 'package:seu_lourival/core/values/colors.dart';

class UsersManagerTabbar extends StatelessWidget {
  const UsersManagerTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelColor: DSColors.primary,
              indicatorColor: DSColors.primary,
              unselectedLabelColor: Colors.grey[700],
              tabs: const [
                Tab(text: 'Pré registro'),
                Tab(text: 'Cadastrados'),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  PreRegisterListPage(),
                  Icon(Icons.construction_outlined),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// listbuilder
