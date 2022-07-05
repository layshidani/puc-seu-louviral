import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users/page.dart';

class AddUsersController extends GetxController {
  var _currentStep = 0.obs;
  var formModel = AddUserFormModel();
  int get currentStep => _currentStep.value;

  tapped(int step) {
   _currentStep.value = step;
  }

  continued() async {
    if (currentStep == 3) {
      await saveUser();
      return;
    }

    _currentStep.value < 4 ? _currentStep.value += 1 : null;
  }

  cancel() {
    _currentStep.value > 0 ?_currentStep.value -= 1 : null;
  }

  saveUser() async {

  }
}
