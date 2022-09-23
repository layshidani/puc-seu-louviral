import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seu_lourival/app/data/services/email_service.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users_list/controller.dart';

import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';
import 'package:seu_lourival/core/utils/string_formater_helper.dart';
import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/core/values/strings.dart';

class AddUsersFormController extends GetxController {
  static const int _firstStep = 0;
  static const int _lastFormStep = 3;
  static const int _lastStep = 4;
  static const String _brazilDDI = '+55';

  final _addUsersListController = Get.find<AddUsersListController>();
  final _currentStep = 0.obs;
  final addUserForm = AddUserFormModel();
  TextEditingController type = TextEditingController();

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  int get currentStep => _currentStep.value;
  int get fisrtStep => _firstStep;
  int get lastStep => _lastStep;
  List<GlobalKey<FormState>> get formKeys => _formKeys;

  void _addStep() {
    _currentStep.value += 1;
  }

  void _takeStep() {
    _currentStep.value -= 1;
  }

  bool _isValidForm() {
    return _formKeys[currentStep].currentState!.validate();
  }

  void onTapped(int step) {
    _currentStep.value = step;
  }

  onContinue() async {
    switch (currentStep) {
      case _lastStep:
        Get.back();
        break;
      case _lastFormStep:
        if (_isValidForm()) {
          Get.showOverlay(
              asyncFunction: () async {
                final result = await _onSaveUser();
                if (result) {
                  await _addUsersListController.getPreRegisteredList();
                  _addStep();
                } else {}
              },
              loadingWidget: const Center(
                child: CircularProgressIndicator(
                  color: DSColors.primary,
                ),
              ));
        }
        break;
      default:
        if (_isValidForm()) {
          currentStep < _lastStep ? _addStep() : null;
        }
        break;
    }
  }

  void onCancel() {
    currentStep > _firstStep ? _takeStep() : null;
  }

  bool isLastStep() {
    return currentStep == _lastStep;
  }

  bool shouldShowCancelButton() {
    return currentStep != fisrtStep && currentStep != lastStep;
  }

  _showSnackBar(
      {SnackbarStyle style = SnackbarStyle.info, String message = ''}) {
    final snackbar = CustomSnackBar(
      title: message,
      style: style,
      duration: const Duration(seconds: 5),
    ).build();
    Get.showSnackbar(snackbar);
  }

  Future<bool> _onSaveUser() async {
    try {
      await FirebaseFirestore.instance
          .collection('pre-registered')
          .add(getFormData());

      final emailService = EmailService();
      final model = EmailServiceModel(
        name: addUserForm.name,
        email: addUserForm.email,
        phone: addUserForm.phone,
      );

      await emailService.sendEmail(model: model);

      _showSnackBar(
          style: SnackbarStyle.success,
          message: AddUsersFormStrings.onSaveUserSuccess);
      return true;
    } catch (e) {
      _showSnackBar(
          style: SnackbarStyle.error,
          message: AddUsersFormStrings.onSaveUserError);
      return false;
    }
  }

  Map<String, dynamic> getFormData() {
    return {
      'type': addUserForm.type,
      'name': addUserForm.name,
      'cpf': addUserForm.cpf,
      'phone': StringFormater.getOnlyNumbers('$_brazilDDI${addUserForm.phone}'),
      'email': addUserForm.email,
      'homeData': {
        'number': addUserForm.number,
        'tower': addUserForm.tower,
      },
      'createdAt': DateTime.now(),
    };
  }
}

class AddUserFormModel {
  String type = '';
  String name = '';
  String cpf = '';
  String phone = '';
  String email = '';
  String number = '';
  String tower = '';
}
