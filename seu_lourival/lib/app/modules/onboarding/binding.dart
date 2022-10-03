import 'package:get/instance_manager.dart';
import 'controller.dart';
import 'repository.dart';

class OnboardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(OnboardingController(OnboardingRepository()));
  }
}