import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users_form/controller.dart';

import 'package:seu_lourival/core/utils/input_validators.dart';
import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/core/values/user_types.dart';
import 'package:seu_lourival/global_widgets/design_system/field/text_field.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';

class AddUsersFormPage extends StatelessWidget {
  AddUsersFormPage({Key? key}) : super(key: key);
  var controller = Get.put(AddUsersFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DSText.base('Cadastro de usuário'),
        backgroundColor: DSColors.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return Theme(
                data: ThemeData(
                    colorScheme: const ColorScheme.light(primary: DSColors.primary)),
                child: Stepper(
                  physics: const ScrollPhysics(),
                  currentStep: controller.currentStep,
                  onStepTapped: (step) => controller.onTapped(step),
                  onStepContinue: controller.onContinue,
                  onStepCancel: controller.onCancel,
                  controlsBuilder:
                      (BuildContext context, ControlsDetails controls) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () => controller.onContinue(),
                            style: ElevatedButton.styleFrom(primary: DSColors.primary),
                            child: Text(controller.isLastStep() ? 'Ok' : 'Continuar'),
                          ),
                          controller.shouldShowCancelButton() ? Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: ElevatedButton(
                              onPressed: () =>  controller.onCancel(),
                              style: ElevatedButton.styleFrom(primary: Colors.white),
                              child: const Text('Cancelar', style: TextStyle(color: DSColors.primary),),
                            ),
                          ) : Container(),
                        ],
                      ),
                    );
                  },
                  steps: <Step>[
                    Step(
                      title: DSText.base('Qual o tipo de usuário?'),
                      content: Form(
                        key: controller.formKeys[0],
                        child: DropdownButtonFormField<String>(
                          items: userTypes.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          validator: (value) =>
                              DSInputValidators.isUserTypeSelected(value),
                          decoration: const InputDecoration(
                            labelText: 'Selecione um tipo de usuário',
                          ),
                          onChanged: (value) {
                            controller.addUserForm.type = value ?? '';
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      isActive: controller.currentStep >= 0,
                      state: controller.currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: DSText.base('Dados pessoais'),
                      content: Form(
                        key: controller.formKeys[1],
                        child: Column(
                          children: <Widget>[
                            DSTextField(
                              labelText: 'Nome completo',
                              iconData: Icons.person_outline,
                              validator: (value) =>
                                  DSInputValidators.isValidName(value),
                              onChange: (value) {
                                controller.addUserForm.name = value;
                              },
                            ),
                            DSTextField(
                              labelText: 'CPF',
                              iconData: Icons.document_scanner_outlined,
                              keyboardType: TextInputType.number,
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CpfInputFormatter(),
                              ],
                              validator: (value) =>
                                  DSInputValidators.isValidCPF(value),
                              onChange: (value) {
                                controller.addUserForm.cpf = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      isActive: controller.currentStep >= 0,
                      state: controller.currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: DSText.base('Informações de contato'),
                      content: Form(
                        key: controller.formKeys[2],
                        child: Column(
                          children: <Widget>[
                            DSTextField(
                              labelText: 'Celular',
                              keyboardType: TextInputType.phone,
                              iconData: Icons.phone_android,
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TelefoneInputFormatter(),
                              ],
                              validator: (value) =>
                                  DSInputValidators.isValidPhone(value),
                              onChange: (value) {
                                controller.addUserForm.phone = value;
                              },
                            ),
                            DSTextField(
                              labelText: 'E-mail',
                              keyboardType: TextInputType.emailAddress,
                              iconData: Icons.email_outlined,
                              validator: (value) =>
                                  DSInputValidators.isValidEmail(value),
                              onChange: (value) {
                                controller.addUserForm.email = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      isActive: controller.currentStep >= 0,
                      state: controller.currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: DSText.base('Dados adicionais'),
                      content: Form(
                        key: controller.formKeys[3],
                        child: Column(
                          children: <Widget>[
                            DSTextField(
                              labelText: 'Apartamento',
                              iconData: Icons.apartment_outlined,
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  DSInputValidators.isValidApartment(value),
                              onChange: (value) {
                                controller.addUserForm.apartmentNumber = value;
                              },
                            ),
                            DSTextField(
                              labelText: 'Complemento (bloco, torre, etc)',
                              iconData: Icons.domain_outlined,
                              validator: (value) =>
                                  DSInputValidators.isValidApartmentComplement(
                                      value),
                              onChange: (value) {
                                controller.addUserForm.tower = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      isActive: controller.currentStep >= 0,
                      state: controller.currentStep >= 3
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: DSText.base('🎉 Sucesso'),
                      content: Column(
                        children: <Widget>[
                          DSText.base(
                              'Pré cadastrado concluído. Agora é só solicitar ao usuário para instalar o app e fazer o login!'),
                        ],
                      ),
                      isActive: controller.currentStep >= 0,
                      state: controller.currentStep >= 4
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
