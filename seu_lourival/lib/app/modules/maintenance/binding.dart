import 'package:get/instance_manager.dart';
import 'controller.dart';
import 'repository.dart';

class MaintenanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MaintenanceController(MaintenanceRepository()));
  }
}