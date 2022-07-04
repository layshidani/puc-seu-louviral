import 'package:get/instance_manager.dart';
import 'package:seu_lourival/app/modules/sms_validation/controller.dart';

class SmsValidationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SmsValidationController());
  }
}
