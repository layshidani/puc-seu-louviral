import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
import '../../../routes/routes.dart';
import 'repository.dart';

class OnboardingController extends GetxController {
  final OnboardingRepository _repository;
  final _firestore = FirebaseFirestore.instance;

  OnboardingController(this._repository);

  Future<void> didFinishOnboarding() async {
    final preRegisterdUser = Get.find<UserService>().user;
    final loggedUserUid = FirebaseAuth.instance.currentUser?.uid;
    if (preRegisterdUser != null && loggedUserUid != null) {
      print("--> DELETAR: ${preRegisterdUser.uuid}");
      print("--> USUARIO LOGADO: ${loggedUserUid}");
      await _firestore
          .collection('pre-registered')
          .doc(preRegisterdUser.uuid)
          .delete();
      final result = await _firestore
          .collection('users')
          .doc(loggedUserUid)
          .set(preRegisterdUser.toJson());
      Get.find<UserService>().user?.uuid = loggedUserUid;

      Get.offAllNamed(Routes.reportList);
    }
  }
}
