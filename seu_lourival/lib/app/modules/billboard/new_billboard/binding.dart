import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'controller.dart';
import 'repository.dart';

class NewBillboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NewBillboardController(
      NewBillboardRepository(),
      Get.find(),
    ));
  }
}
