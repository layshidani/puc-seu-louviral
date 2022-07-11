import 'package:get/get.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users_form/controller.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users_list/controller.dart';

class AddUsersFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddUsersFormController());
    Get.put(AddUsersListController());
  }
}
