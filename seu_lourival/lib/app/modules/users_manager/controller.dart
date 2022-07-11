import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';

class UsersManagerController extends GetxController {
  // var _preRegisteredList = [].obs;
  // bool isLoading = false;
  // get preRegisteredList => _preRegisteredList.value;

  // setLoading(bool isLoading) {
  //   this.isLoading = isLoading;
  // }

  // _showSnackBar(
  //     {SnackbarStyle style = SnackbarStyle.info, String message = ''}) {
  //   final snackbar = CustomSnackBar(
  //     title: message,
  //     style: style,
  //     duration: const Duration(seconds: 5),
  //   ).build();
  //   Get.showSnackbar(snackbar);
  // }

  // Future<void> getPreRegisteredUsersList() async {
  //   print('🚩  INIT');

  //   setLoading(true);
  //   try {
  //     final result =
  //         await FirebaseFirestore.instance.collection('pre-registered').get();

  //     _preRegisteredList.value = result.docs.map((doc) {
  //       return doc.data();
  //     }).toList();

  //     setLoading(false);

  //     print('🚩🚩 $preRegisteredList');
  //   } catch (e) {
  //     setLoading(false);

  //     _showSnackBar(
  //         style: SnackbarStyle.error,
  //         message: 'Ops. Ocorreu um erro ao recuperar os dados');
  //   }
  // }
}
