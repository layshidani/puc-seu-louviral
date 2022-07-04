import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/modules/login/controller.dart';
import 'package:seu_lourival/app/widgets/custom_loading.dart';
import 'package:seu_lourival/core/theme/text_style.dart';
import 'package:seu_lourival/core/values/login_strings.dart';
import 'package:seu_lourival/global_widgets/design_system/button/icon_button.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.find<LoginController>();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LoginStrings.scaffoldTitle),
      ),
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
                    const Text(
                      LoginStrings.title,
                      style: DSTextStyle.titleBase,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 60),
                    Form(
                      key: _key,
                      child: TextFormField(
                        onSaved: (text) {
                          controller.phoneNumber = text ?? "";
                        },
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        // validator: (value) {
                        // if (value != null && value.length > 14) {
                        //   return null;
                        // }
                        // return LoginStrings.phoneError;
                        // },
                        // inputFormatters: [controller.phoneMaskConfig],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefix: const Text(LoginStrings.phonePrefix),
                          suffixIcon: const Icon(Icons.phone_android_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: LoginStrings.phoneLabel,
                        ),
                        style: const TextStyle(fontSize: 18),
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
