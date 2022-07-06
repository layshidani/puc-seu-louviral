import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users/page.dart';

class AddUsersController extends GetxController {
  var _currentStep = 0.obs;
  var addUserForm = AddUserFormModel();
  TextEditingController userType = TextEditingController();
  // TextEditingController personalData = TextEditingController();
  // TextEditingController contact = TextEditingController();
  // TextEditingController aditionalData = TextEditingController();

  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  int get currentStep => _currentStep.value;
  List<GlobalKey<FormState>> get formKeys => _formKeys;

  onTapped(int step) {
    _currentStep.value = step;
  }

  onContinued() async {
    // onSaveUser();
    if (_formKeys[currentStep].currentState!.validate()) {
      if (currentStep == 3) {
        await onSaveUser();
      }
      
      _currentStep.value < 4 ? _currentStep.value += 1 : null;
    }
  }

  onCancel() {
    _currentStep.value > 0 ? _currentStep.value -= 1 : null;
  }

  Future<void> onSaveUser() async {
    await FirebaseFirestore.instance
        .collection('pre-registered').add(getFormData());
  }

  Map<String, String> getFormData() {
    return {
      'type': addUserForm.type,
      'name': addUserForm.name,
      'cpf': addUserForm.cpf,
      'phone': addUserForm.phone,
      'email': addUserForm.email,
      'apto': addUserForm.apto,
      'tower': addUserForm.tower,
    };
  }
}
class AddUserFormModel {
  String type = '';
  String name = '';
  String cpf = '';
  String phone = '';
  String email = '';
  String apto = '';
  String tower = '';
}
