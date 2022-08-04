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
    // SendTokenData? data;
    await FirebaseAuth.instance.verifyPhoneNumber(
      // timeout: Duration(minutes: 2),
      phoneNumber: phone,
      // se o android ler o sms automaticamente
      verificationCompleted: (PhoneAuthCredential credential) {
        // final service = Get.find<AuthenticationService>();
        // service.id = credential.verificationId ?? '';
        // service.token = credential.smsCode ?? '';
        // Get.toNamed(Routes.smsValidation);
        //  todo: retornar um credential
        // data?.result = SendTokenResult.verificationCompleted;
        // data?.credentials = Credentials(id: id, token: token);
        print('--> verificationCompleted');
      },
      // erro ao enviar sms
      verificationFailed: (FirebaseAuthException error) {
        //  todo: retornar um erro
        // data?.result = SendTokenResult.verificationFailed;
        // data?.error = error.message;
        print('--> verificationFailed: $error');
      },
      // quando enviar o sms
      codeSent: (verificationId, _) {
        //  todo: retornar um id
        // data?.result = SendTokenResult.codeSent;
        // data?.credentials = Credentials(id: verificationId, token: '');
        print('--> codeSent');
        Get.find<SmsAuthenticationService>().id = verificationId;
        Get.find<SmsAuthenticationService>().phone = phone;
        Get.toNamed(Routes.smsValidation);
        // codeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String str) {
        print('--> codeAutoRetrievalTimeout');
      },
    );
    // return data;
  }
}
