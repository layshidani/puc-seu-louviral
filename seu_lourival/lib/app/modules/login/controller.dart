import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/data/services/sms_authentication_service.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
import 'package:seu_lourival/routes/routes.dart';

class LoginController extends GetxController {
  final _phone = ''.obs;
  final RxBool _isLoading = false.obs;
  final UserService _service;

  bool get isLoading => _isLoading.value;

  String get phone => '+55${_phone.value}';

  set phone(String number) => _phone.value = number;

  LoginController(this._service);

  @override
  void onInit() async {
    if (_service.isLoggedIn) {
      final success = await _service.loadCurrentUser();
      if (success) {
        Get.offAllNamed(Routes.reportList);
      }
    }
    super.onInit();
  }

  Future<void> sendToken() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      // timeout: Duration(minutes: 2),
      phoneNumber: phone,
      // se o android ler o sms automaticamente
      verificationCompleted: (PhoneAuthCredential credential) {
        //  todo: retornar um credential
        print('--> verificationCompleted');
      },
      // erro ao enviar sms
      verificationFailed: (FirebaseAuthException error) {
        //  todo: retornar um erro
        print('--> verificationFailed: $error');
      },
      // quando enviar o sms
      codeSent: (verificationId, _) {
        //  todo: retornar um id
        print('--> codeSent');
        Get.find<SmsAuthenticationService>().id = verificationId;
        Get.find<SmsAuthenticationService>().phone = phone;
        Get.toNamed(Routes.smsValidation);
      },
      codeAutoRetrievalTimeout: (String str) {
        print('--> codeAutoRetrievalTimeout');
      },
    );
    // return data;
  }
}
