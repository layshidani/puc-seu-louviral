import 'package:get/instance_manager.dart';
import 'package:seu_lourival/app/modules/users_manager/controller.dart';

class UsersManagerBinding implements Bindings {
   @override
  void dependencies() {
    Get.put(UsersManagerController());
  }
}
