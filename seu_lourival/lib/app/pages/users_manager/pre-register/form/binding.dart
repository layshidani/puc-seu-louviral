import 'package:get/get.dart';

import 'package:seu_lourival/app/pages/users_manager/pre-register/form/controller.dart';

class PreRegisterFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PreRegisterFormController());
  }
  
}
