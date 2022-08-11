import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'controller.dart';
import 'repository.dart';

class NewReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(NewReportController(
      NewReportRepository(),
      Get.find(),
    ));
  }
}
