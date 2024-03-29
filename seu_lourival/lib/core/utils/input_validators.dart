import 'package:get/utils.dart';
import 'package:seu_lourival/core/utils/ds_extensions.dart';

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
    return (GetUtils.isPhoneNumber(value!)) &&
            (GetUtils.isEqual(value.length, 15))
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

  static String? istypeSelected(String? value) {
    return (GetUtils.isLengthGreaterOrEqual(value, 1))
        ? null
        : 'Ops! Selecione um tipo de usuário';
  }

  static String? isFieldValid({required int minCharacters, String? value}) {
    if (value == null) {
      return "Campo obrigatório";
    } else if (value.length < minCharacters) {
      return "Este campo deve ter pelo menos $minCharacters caracteres";
    }
    return null;
  }
}
