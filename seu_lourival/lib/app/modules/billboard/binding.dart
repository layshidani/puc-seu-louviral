import 'package:get/instance_manager.dart';
import 'controller.dart';
import 'repository.dart';

class BillboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BillboardController(BillboardRepository()));
  }
}