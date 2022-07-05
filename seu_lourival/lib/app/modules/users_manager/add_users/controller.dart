import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users/page.dart';

class AddUsersController extends GetxController {
  var _currentStep = 0.obs;
  var formModel = AddUserFormModel();

  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  int get currentStep => _currentStep.value;
  List<GlobalKey<FormState>> get formKeys => _formKeys;

  tapped(int step) {
    _currentStep.value = step;
  }

  continued() async {
    if (_formKeys[currentStep].currentState!.validate()) {
      if (currentStep == 3) {
        await saveUser();
        return;
      }
      _currentStep.value < 4 ? _currentStep.value += 1 : null;
    }
  }

  cancel() {
    _currentStep.value > 0 ? _currentStep.value -= 1 : null;
  }

  saveUser() async {}
}
