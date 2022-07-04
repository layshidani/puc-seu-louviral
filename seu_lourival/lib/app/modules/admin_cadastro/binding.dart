import 'package:get/instance_manager.dart';
import 'repository.dart';
import 'controller.dart';

class Admin_cadastroBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(Admin_cadastroController(Admin_cadastroRepository()));
  }
}
