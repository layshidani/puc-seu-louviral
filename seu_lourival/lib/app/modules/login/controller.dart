import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/data/services/sms_authentication_service.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';
import 'package:seu_lourival/routes/routes.dart';

class LoginController extends GetxController {
  final _phone = ''.obs;
  final RxBool _isLoading = false.obs;
  final UserService _service;

  bool get isLoading => _isLoading.value;

  String get phone => '+55${_phone.value}';

  set phone(String number) => _phone.value = number;
  set _loading(bool loading) => _isLoading.value = loading;

  LoginController(this._service);

  @override
  void onInit() async {
    if (_service.isLoggedIn) {
      print("--> is logged in: ${FirebaseAuth.instance.currentUser}");
      _loading = true;
      final success = await _service.loadCurrentUser();
      if (success) {
        Get.offAllNamed(Routes.reportList);
      } else {
        _loading = false;
      }
    }
    super.onInit();
  }

  Future<void> sendToken() async {
    _loading = true;
    await FirebaseAuth.instance.verifyPhoneNumber(
      // timeout: Duration(minutes: 2),
      phoneNumber: phone,
      // se o android ler o sms automaticamente
      verificationCompleted: (PhoneAuthCredential credential) {
        //  todo: retornar um credential
        _loading = false;
        print('--> verificationCompleted');
      },
      // erro ao enviar sms
      verificationFailed: (FirebaseAuthException error) {
        //  todo: retornar um erro
        print('--> verificationFailed: $error');
        _loading = false;
        final snackbar = CustomSnackBar(
          title: "Erro ao enviar token SMS",
          style: SnackbarStyle.error,
          duration: const Duration(seconds: 5),
        ).build();
        Get.showSnackbar(snackbar);
      },
      // quando enviar o sms
      codeSent: (verificationId, _) {
        //  todo: retornar um id
        print('--> codeSent');
        _loading = false;
        Get.find<SmsAuthenticationService>().id = verificationId;
        Get.find<SmsAuthenticationService>().phone = phone;
        Get.toNamed(Routes.smsValidation);
      },
      codeAutoRetrievalTimeout: (String str) {
        print('--> codeAutoRetrievalTimeout');
        _loading = false;
      },
    );
  }
}
