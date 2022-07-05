import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              child: const Text('Aplicação >> Home Page: Usuário cadastrado'),
              onPressed: () => Get.toNamed(Routes.reportList),
            ),
            ElevatedButton(
              child: const Text('Aplicação >> Cadastro de usuário'),
              onPressed: () => Get.toNamed(Routes.addUsers),
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
          ],
        ),
      ),
    );
  }
}
