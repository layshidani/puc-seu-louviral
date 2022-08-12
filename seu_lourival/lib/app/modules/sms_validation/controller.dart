import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/data/models/user_model.dart';
import 'package:seu_lourival/app/data/services/sms_authentication_service.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/routes/routes.dart';

import '../../widgets/custom_snack_bar.dart';

class SmsValidationController extends GetxController {
  var smsCode = ''.obs;
  final _key = GlobalKey<FormState>();
  final UserService _service;

  GlobalKey<FormState> get key => _key;

  SmsValidationController(this._service);

  Future<void> authenticateUser() async {
    try {
      final service = Get.find<SmsAuthenticationService>();
      final credential = PhoneAuthProvider.credential(
        verificationId: service.id,
        smsCode: smsCode.value,
      );
      final result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint('--> login result: $result');

      if (result.user?.uid != null) {
        _validateUser();
      } else {
        debugPrint('--> result user is null');
      }
    } catch (e) {
      final snackbar = CustomSnackBar(
        title: 'Erro ao validar código SMS',
        style: SnackbarStyle.error,
        duration: const Duration(seconds: 10),
      ).build();
      Get.showSnackbar(snackbar);
      debugPrint('--> LOGIN FAILURE: ${e.toString()}');
    }
  }

  bool isValidForm() {
    return key.currentState!.validate();
  }

  void _validateUser() async {
    if (await _validatePreRegister()) {
      Get.to(DummyPage('PRÉ REGISTER'));
    } else if (await _validateTrustedUser()) {
      Get.offAllNamed(Routes.reportList);
    } else {
      await _deleteUser();
      Get.offNamed(Routes.loginError);
    }
  }

  Future<bool> _validatePreRegister() async {
    debugPrint('--> _validateLogin');
    debugPrint('--> telefone: ${Get.find<SmsAuthenticationService>().phone}');
    try {
      final result = await FirebaseFirestore.instance
          .collection('pre-registered')
          .where('telefone',
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
    print("--> _validateTrustedUser");
    try {
      final uuid = FirebaseAuth.instance.currentUser?.uid ?? '';
      print("--> USER ID: ${uuid}");
      final result =
          await FirebaseFirestore.instance.collection('users').doc(uuid).get();
      if (result.exists) {
        _service.user = UserModel.fromJson(result.data(), uuid: result.id);
        return true;
      }
      return false;
    } catch (e) {
      print("--> _validateTrustedUser catch error: ${e}");
      return false;
    }
  }

  Future<void> _deleteUser() async {
    //todo: descomentar essa função para deletar automaticamente usuarios que nao devem acessar o sistema
    // await FirebaseAuth.instance.currentUser?.delete();
  }
}

class DummyPage extends StatelessWidget {
  final String title;
  DummyPage(this.title);
  @override
  Widget build(BuildContext context) {
    return DSScaffold(
      title: title,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print(Get.find<UserService>().user.toString());
          },
          child: Text("print user"),
        ),
      ),
    );
  }
}
