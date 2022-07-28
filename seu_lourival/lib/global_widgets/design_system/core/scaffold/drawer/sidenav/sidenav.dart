import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:seu_lourival/core/values/text_size.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/routes/routes.dart';

class DSDrawerSidenav extends StatelessWidget {
  const DSDrawerSidenav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                Container(
                  width: 120.0, 
                  height: 120.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 10,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://viverdeblog.com/wp-content/uploads/2017/03/persona-topo.png',
                  ),
                ),
                const Text(
                  'Pedro Santos',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: DSTextSize.base,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    children: [
                      Chip(
                        label: DSText.sm('Morador'),
                        backgroundColor: const Color.fromARGB(46, 0, 155, 198),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Manifestos'),
              onTap: () {
                Get.toNamed(Routes.reportList);
              },
            ),
            ListTile(
              leading: const Icon(Icons.comment_bank_sharp),
              title: const Text('Comunicados'),
              onTap: () {
                Get.toNamed(Routes.billboard);
              },
            ),
            ListTile(
              leading: const Icon(Icons.payments_outlined),
              title: const Text('Financeiro'),
              onTap: () {
                Get.toNamed(Routes.financial);
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.people),
            //   title: const Text('Gerenciamento de usuários'),
            //   onTap: () {
            //     Navigator.of(context).pushReplacement(
            //       // Go to ReportPage
            //       MaterialPageRoute(builder: (_) => UsersManagerPage()),
            //     );
            //   },
            // ),
            const Spacer(),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: DSTextSize.xxs,
                color: Colors.white54,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: const Text('Seu Lourival'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
