import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:seu_lourival/core/values/text_size.dart';
import 'package:seu_lourival/routes/routes.dart';

class DSDrawer extends StatelessWidget {
  const DSDrawer({Key? key}) : super(key: key);

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
                  'Pedro Santos | pedro.santos@email.com',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 64.0),
                  child: const Text(
                    'Morador - Apto 231, Bloco 3',
                    style: TextStyle(color: Colors.white),
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
