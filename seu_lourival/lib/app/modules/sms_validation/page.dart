import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:seu_lourival/app/modules/sms_validation/controller.dart';
import 'package:seu_lourival/core/utils/input_validators.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';

import '../../../global_widgets/design_system/button/icon_button.dart';

class SmsValidationPage extends StatelessWidget {
  final controller = Get.find<SmsValidationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS code validation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            DSTitle.base('Digite o código recebido no seu celular'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: controller.key,
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    controller.smsCode.value = text;
                  },
                  beforeTextPaste: (text) {
                    if (int.tryParse(text ?? '') == null) {
                      return false;
                    }
                    return true;
                  },
                  validator: (value) => DSInputValidators.isValidSMS(value),
                ),
              ),
            ),
            const Spacer(),
            DSIconButton(
                buttonText: 'Validar',
                onPressAction: () {
                  if (controller.isValidForm()) {
                    controller.authenticateUser();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
