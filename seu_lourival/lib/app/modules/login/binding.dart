import 'package:get/instance_manager.dart';
import 'package:seu_lourival/app/data/services/sms_authentication_service.dart';
import 'package:seu_lourival/app/modules/login/controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(Get.find()));
    Get.put(SmsAuthenticationService());
  }
}
