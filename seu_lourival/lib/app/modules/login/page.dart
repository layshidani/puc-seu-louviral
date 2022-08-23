import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:lottie/lottie.dart';

import 'package:seu_lourival/app/modules/login/controller.dart';
import 'package:seu_lourival/app/widgets/custom_loading.dart';
import 'package:seu_lourival/core/utils/input_validators.dart';
import 'package:seu_lourival/core/values/login_strings.dart';
import 'package:seu_lourival/global_widgets/design_system/button/icon_button.dart';
import 'package:seu_lourival/global_widgets/design_system/field/text_field.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.find<LoginController>();
  final _key = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return DSScaffold(
      title: LoginStrings.scaffoldTitle,
      body: Obx(() {
        return controller.isLoading
            ? const CustomLoading()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/loading/89621-rooms.json',
                      fit: BoxFit.fill,
                      height: 200,
                    ),
                    const SizedBox(height: 30),
                    DSTitle.lg(
                      LoginStrings.title,
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _key,
                      child: DSTextField(
                        labelText: LoginStrings.phoneLabel,
                        keyboardType: TextInputType.phone,
                        iconData: Icons.phone_android,
                        prefix: LoginStrings.phonePrefix,
                        formatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        validator: (value) =>
                            DSInputValidators.isValidPhone(value),
                        onChange: (value) {
                          controller.phone = value;
                        },
                      ),
                    ),
                    const Spacer(),
                    DSIconButton(
                      buttonText: LoginStrings.submitButton,
                      iconData: Icons.arrow_forward,
                      onPressAction: () {
                        _key.currentState?.save();
                        controller.sendToken();
                      },
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
