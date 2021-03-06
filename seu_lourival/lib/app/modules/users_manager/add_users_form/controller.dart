import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users_list/controller.dart';

import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';
import 'package:seu_lourival/core/values/strings.dart';

class AddUsersFormController extends GetxController {
  static const int _fisrtStep = 0;
  static const int _lastFormStep = 3;
  static const int _lastStep = 4;

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
  int get fisrtStep => _fisrtStep;
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
          await _onSaveUser();
          await _addUsersListController.getPreRegisteredList();
          _addStep();
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
    currentStep > _fisrtStep ? _takeStep() : null;
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

  Future<void> _onSaveUser() async {
    try {
      await FirebaseFirestore.instance
          .collection('pre-registered')
          .add(getFormData());

      _showSnackBar(
          style: SnackbarStyle.success,
          message: AddUsersFormStrings.onSaveUserSuccess);
    } catch (e) {
      _showSnackBar(
          style: SnackbarStyle.error, message: AddUsersFormStrings.onSaveUserError);
    }
  }

  Map<String, dynamic> getFormData() {
    return {
      'type': addUserForm.type,
      'name': addUserForm.name,
      'cpf': addUserForm.cpf,
      'phone': addUserForm.phone,
      'email': addUserForm.email,
      'apartmentNumber': addUserForm.apartmentNumber,
      'tower': addUserForm.tower,
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
  String apartmentNumber = '';
  String tower = '';
}
