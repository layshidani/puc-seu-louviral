import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:brasil_fields/brasil_fields.dart';

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
  @override
  Widget build(BuildContext context) {
    return DSScaffold(
      title: LoginStrings.scaffoldTitle,
      body: Obx(() {
        return controller.isLoading
            ? CustomLoading()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    DSTitle.lg(
                      LoginStrings.title,
                    ),
                    const SizedBox(height: 60),
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
                          controller.phoneNumber = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 60),
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
