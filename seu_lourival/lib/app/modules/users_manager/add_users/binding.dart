import 'package:get/get.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users/controller.dart';

class AddUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddUsersController());
  }
  
}
