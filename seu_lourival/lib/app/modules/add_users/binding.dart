import 'package:get/instance_manager.dart';
import 'package:seu_lourival/app/modules/add_users/controller.dart';

class AddUsersBinding implements Bindings {
   @override
  void dependencies() {
    Get.put(AddUsersController());
  }
}
