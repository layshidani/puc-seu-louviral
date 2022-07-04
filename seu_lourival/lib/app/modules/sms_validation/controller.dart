import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/data/services/sms_authentication_service.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';
import 'package:seu_lourival/routes/routes.dart';

class SmsValidationController extends GetxController {
  var smsCode = "".obs;

  Future<void> authenticateUser() async {
    // try {
    //   final service = Get.find<SmsAuthenticationService>();
    //   final credential = PhoneAuthProvider.credential(
    //     verificationId: service.id,
    //     smsCode: smsCode.value,
    //   );
    //   final result =
    //       await FirebaseAuth.instance.signInWithCredential(credential);
    //   debugPrint("--> login result: $result");
    //
    //   if (result.user?.uid != null) {
    //     _validateUser();
    //   } else {
    //     debugPrint("--> result user is null");
    //   }
    // } catch (e) {
    //   final snackbar = CustomSnackBar(
    //     title: "Erro ao validar código SMS",
    //     style: SnackbarStyle.error,
    //     duration: const Duration(seconds: 10),
    //   ).build();
    //   Get.showSnackbar(snackbar);
    //   debugPrint("--> LOGIN FAILURE: ${e.toString()}");
    // }
  }

  void _validateUser() async {
    if (await _validatePreRegister()) {
      Get.to(DummyPage("PRÉ REGISTER"));
    } else if (await _validateTrustedUser()) {
      Get.to(DummyPage("Usuário confirmado"));
    } else {
      await _deleteUser();
      Get.to(DummyPage("Não autorizado"));
    }
  }

  Future<bool> _validatePreRegister() async {
    debugPrint("--> _validateLogin");
    debugPrint("--> telefone: ${Get.find<SmsAuthenticationService>().phone}");
    try {
      final result = await FirebaseFirestore.instance
          .collection("pre-registered")
          .where("telefone",
              isEqualTo: Get.find<SmsAuthenticationService>().phone)
          .get();
      if (result.docs.length != 1) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> _validateTrustedUser() async {
    try {
      final uuid = FirebaseAuth.instance.currentUser?.uid ?? "";
      final result =
          await FirebaseFirestore.instance.collection("users").doc(uuid).get();
      return result.exists;
    } catch (e) {
      return false;
    }
  }

  Future<void> _deleteUser() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }
}

class DummyPage extends StatelessWidget {
  final String title;
  DummyPage(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
