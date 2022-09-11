import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
import 'repository.dart';

class OnboardingController extends GetxController {
  final OnboardingRepository _repository;

  OnboardingController(this._repository);

  @override
  void onInit() {
    print(
        "--> ONBOARDING CONTROLLER USER: ${Get.find<UserService>().user?.phone}");
  }
}
