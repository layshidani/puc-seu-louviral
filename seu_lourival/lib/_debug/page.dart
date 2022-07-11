import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

// import 'package:seu_lourival/_debug/DS_catalog/page.dart';
// import 'package:seu_lourival/app/modules/report/new_report/page.dart';
// import 'package:seu_lourival/app/pages/login/page.dart';
// import 'package:seu_lourival/app/pages/login_error/page.dart';
// import 'package:seu_lourival/app/pages/reports/page.dart';

import 'package:seu_lourival/routes/routes.dart';

class DebugHomePage extends StatelessWidget {
  const DebugHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Aplicação >> Login'),
              onPressed: () => Get.toNamed(Routes.login),
            ),
            ElevatedButton(
              child: const Text(
                  'Aplicação >> Home Page (ReportList): Usuário cadastrado'),
              onPressed: () => Get.toNamed(Routes.reportList),
            ),
            ElevatedButton(
              child: const Text('Aplicação >> Gerenciamento de usuários'),
              onPressed: () => Get.toNamed(Routes.usersManager),
            ),
            const Divider(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red[300],
              ),
              onPressed: () => Get.toNamed(Routes.loginError),
              child: const Text('Aplicação >> Usuário não encontrado'),
            ),
            const Divider(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple[400],
              ),
              onPressed: () => Get.toNamed(Routes.themeCatalog),
              child: const Text('Design System >> Catálogo de Temas'),
            ),
            const Divider(),
            ElevatedButton(
              child: const Text('Feature >> Add Report'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple[400],
              ),
              onPressed: () => Get.toNamed(Routes.newReport),
            ),
            const Divider(),
            ElevatedButton(
              child: const Text('Feature >> show camera'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple[400],
              ),
              onPressed: () async {
                final picker = ImagePicker();
                try {
                  await picker.pickImage(
                      source: ImageSource.camera, imageQuality: 50);
                } catch (e) {
                  print(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
