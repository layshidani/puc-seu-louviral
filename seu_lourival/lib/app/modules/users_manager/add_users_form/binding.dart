import 'package:get/get.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users_form/controller.dart';

class AddUsersFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddUsersFormController());
  }
  
}
