import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:seu_lourival/app/modules/sms_validation/controller.dart';

import '../../../global_widgets/design_system/button/icon_button.dart';

class SmsValidationPage extends StatelessWidget {
  final controller = Get.find<SmsValidationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SMS code validation"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Digite o código recebido no seu celular"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  controller.smsCode.value = text;
                },
                beforeTextPaste: (text) {
                  if (int.tryParse(text ?? "") == null) {
                    return false;
                  }
                  return true;
                },
              ),
            ),
            DSIconButton(
                buttonText: "Validar",
                onPressAction: () {
                  controller.authenticateUser();
                }),
          ],
        ),
      ),
    );
  }
}
