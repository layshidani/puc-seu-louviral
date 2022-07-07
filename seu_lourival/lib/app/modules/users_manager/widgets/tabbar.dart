import 'package:flutter/material.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users_list/page.dart';
import 'package:seu_lourival/app/modules/users_manager/widgets/registered_list.dart';
import 'package:seu_lourival/core/values/colors.dart';

class UsersManagerTabbar extends StatelessWidget {
  UsersManagerTabbar({super.key});

  List<Tab> tabNames = [
    const Tab(text: 'Pré registro'),
    const Tab(text: 'Cadastrados'),
  ];

  List<Widget> tabList = [
    AddUsersList(),
    RegisteredList(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabNames.length,
      child: Column(
        children: [
          TabBar(
            labelColor: DSColors.primary,
            indicatorColor: DSColors.primary,
            unselectedLabelColor: Colors.grey[700],
            tabs: tabNames,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TabBarView(
                children: tabList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// listbuilder
