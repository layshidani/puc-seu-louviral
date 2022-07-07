import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:seu_lourival/_debug/DS_catalog/page.dart';
import 'package:seu_lourival/app/modules/report/new_report/page.dart';
import 'package:seu_lourival/app/pages/login/page.dart';
import 'package:seu_lourival/app/pages/login_error/page.dart';
import 'package:seu_lourival/app/pages/reports/page.dart';
import 'package:seu_lourival/routes/routes.dart';

class DebugHomePage extends StatelessWidget {
  const DebugHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Debug')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Aplicação >> Login'),
              onPressed: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                ),
              },
            ),
            ElevatedButton(
              child: const Text('Aplicação >> Home Page: Usuário cadastrado'),
              onPressed: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReportPage(),
                  ),
                ),
              },
            ),
            const Divider(),
            ElevatedButton(
              child: const Text('Aplicação >> Usuário não encontrado'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red[300],
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginErrorPage(),
                  ),
                ),
              },
            ),
            const Divider(),
            ElevatedButton(
              child: const Text('Design System >> Catálogo de Temas'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple[400],
              ),
              onPressed: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ThemesCatalogPage(),
                  ),
                ),
              },
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
