import 'package:get/utils.dart';

class DSInputValidators {
  static String? isValidName(String? value) {
    return (value != null && value.isValidName())
        ? null
        : 'Ops! Informe o nome completo';
  }

  static String? isValidCPF(String? value) {
    return (GetUtils.isCpf(value!)) ? null : 'Ops! CPF inválido';
  }

  static String? isValidPhone(String? value) {
    return (GetUtils.isPhoneNumber(value!))
        ? null
        : 'Ops! Informe um número de celular válido';
  }

  static String? isValidSMS(String? value) {
    return (GetUtils.isLengthGreaterOrEqual(value, 6))
        ? null
        : 'Ops! Preencha o código corretamente';
  }

  static String? isValidEmail(String? value) {
    return (GetUtils.isEmail(value!)) ? null : 'Ops! Informe um e-mail válido';
  }

  static String? isValidApartment(String? value) {
    return GetUtils.isLengthBetween(value, 1, 10)
        ? null
        : 'Ops! Informe qual o nº do apartamento';
  }

  static String? isValidApartmentComplement(String? value) {
    return GetUtils.isLengthBetween(value, 4, 10)
        ? null
        : 'Ops! Informe qual o complemento. (Ex: Bloco A)';
  }

  static String? isUserTypeSelected(String? value) {
    return (GetUtils.isLengthGreaterOrEqual(value, 1))
        ? null
        : 'Ops! Selecione um tipo de usuário';
  }

  static String? isFieldValid({required int minCharacters, String? value}) {
    if (value == null) {
      print("--> ${value}, --> ${value?.length}");
      return "Campo obrigatório";
    } else if (value.length < minCharacters) {
      return "Este campo deve ter pelo menos $minCharacters caracteres";
    }
    return null;
  }
}

extension StringRegex on String {
  bool isValidName() {
    return RegExp(
            r'^[A-ZÀ-ŸA-zÀ-ÿ][A-ZÀ-ŸA-zÀ-ÿ]+\s([A-ZÀ-ŸA-zÀ-ÿ]\s?)*[A-ZÀ-ŸA-zÀ-ÿ][A-ZÀ-ŸA-zÀ-ÿ]+$')
        .hasMatch(this);
  }
}
