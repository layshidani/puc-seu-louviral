import 'package:flutter/material.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/field/text_field.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';

class PreRegisterForm extends StatefulWidget {
  @override
  _PreRegisterFormState createState() => _PreRegisterFormState();
}

class _PreRegisterFormState extends State<PreRegisterForm> {
  int _currentStep = 0;
  List<String> userTypes = [
    "Morador",
    "Porteiro",
    "Manutenção",
    "Zelador",
    "Financeiro",
    "Outros",
  ];

  @override
  Widget build(BuildContext context) {
    return DSScaffold(
      title: 'Cadastro de usuário',
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title: DSText.base('Qual o tipo de usuário?'),
                    content: DropdownButtonFormField<String>(
                      items: userTypes.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value != null && value.length >= 1) {
                          return null;
                        }
                        return 'Selecione um tipo de usuário';
                      },
                      decoration: const InputDecoration(
                        labelText: 'Selecione um tipo de usuário',
                      ),
                      onChanged: (_) {},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: DSText.base('Dados pessoais'),
                    content: Column(
                      children: <Widget>[
                        DSTextField(
                          labelText: 'Nome completo',
                          iconData: Icons.person_outline,
                          validator: (value) {
                            return (value != null && value.isValidName())
                                ? null
                                : 'Ops! Informe o nome completo';
                          },
                        ),
                        DSTextField(
                          labelText: 'CPF',
                          iconData: Icons.document_scanner_outlined,
                          validator: (value) {
                            return (value != null)
                                ? null
                                : 'Ops! Informe o CPF completo';
                          },
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: DSText.base('Informações de contato'),
                    content: Column(
                      children: <Widget>[
                        DSTextField(
                          labelText: 'Celular',
                          keyboardType: TextInputType.phone,
                          iconData: Icons.phone_android,
                          validator: (value) {
                            return (value != null)
                                ? null
                                : 'Ops! Informe um telefone válido';
                          },
                        ),
                        DSTextField(
                          labelText: 'E-mail',
                          keyboardType: TextInputType.emailAddress,
                          iconData: Icons.email_outlined,
                          validator: (value) {
                            return (value != null && value.isValidEmail())
                                ? null
                                : 'Ops! Informe um e-mail válido';
                          },
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: DSText.base('Dados da moradia'),
                    content: Column(
                      children: <Widget>[
                        DSTextField(
                          labelText: 'Apartamento',
                          iconData: Icons.apartment_outlined,
                          validator: (value) {
                            if (value != null && value.length >= 1) {
                              return null;
                            }
                            return 'Ops! Informe qual o apartamento';
                          },
                        ),
                        DSTextField(
                          labelText: 'Complemento (bloco, torre, etc)',
                          iconData: Icons.domain_outlined,
                          validator: (value) {
                            if (value != null && value.length >= 1) {
                              return null;
                            }
                            return 'Ops! Informe qual o complemento';
                          },
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 3
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: DSText.base('🎉 Sucesso!'),
                    content: Column(
                      children: <Widget>[
                        DSText.base(
                            'Pré cadastrado concluído. Agora é só solicitar ao usuário para instalar o app e fazer o login!'),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 4
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}

extension StringValidators on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidName() {
    return RegExp(
            r'^[A-ZÀ-ŸA-zÀ-ÿ][A-ZÀ-ŸA-zÀ-ÿ]+\s([A-ZÀ-ŸA-zÀ-ÿ]\s?)*[A-ZÀ-ŸA-zÀ-ÿ][A-ZÀ-ŸA-zÀ-ÿ]+$')
        .hasMatch(this);
  }
}
