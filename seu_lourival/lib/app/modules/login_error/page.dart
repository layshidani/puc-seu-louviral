import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/global_widgets/design_system/button/icon_button.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';
import 'package:seu_lourival/routes/routes.dart';

class LoginErrorPage extends StatelessWidget {
  const LoginErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DSScaffold(
      title: 'Seu Lourival',
      // automaticallyImplyLeading: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DSTitle.lg(
                  'Ops, não encontramos seu cadastro 😔',
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 50),
                  child: DSText.base(
                    'Entre em contato com o administrador do seu condomínio.',
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          DSIconButton(
            buttonText: 'Tentar novamente',
            iconData: Icons.refresh_outlined,
            onPressAction: () => Get.toNamed(Routes.login),
          ),
        ],
      ),
    );
  }
}
