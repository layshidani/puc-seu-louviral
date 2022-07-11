import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/data/services/sms_authentication_service.dart';
import 'package:seu_lourival/routes/routes.dart';

class LoginController extends GetxController {
  final _phoneNumber = ''.obs;
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  String get phoneNumber => '+55${_phoneNumber.value}';

  set phoneNumber(String number) => _phoneNumber.value = number;

  Future<void> sendToken() async {
    // SendTokenData? data;
    await FirebaseAuth.instance.verifyPhoneNumber(
      // timeout: Duration(minutes: 2),
      phoneNumber: phoneNumber,
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
        Get.find<SmsAuthenticationService>().phone = phoneNumber;
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
