import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';

class AddUsersListController extends GetxController {
  List<String> userTypes = [
    'Todos',
    'Morador',
    'Porteiro',
    'Manutenção',
    'Zelador',
    'Financeiro',
    'Outros',
  ];

  bool isLoading = false;
  var _preRegisteredList = [].obs;
  RxString _filter = ''.obs;

  get preRegisteredList => _preRegisteredList.value;
  String get filter => _filter.value;

  onFilterPreRegisterUsers({required String type}) async {
    _filter.value = type;

    var result =
        preRegisteredList.where((user) => user['type'] == filter).toList();

    if (filter == 'Todos') {
      await getPreRegisteredUsersList();
      return;
    }

    if (result.length >= 1) {
      await getPreRegisteredUsersList();
      _preRegisteredList.value = result;
      return;
    }

    _showSnackBar(message: 'A busca não retornou nenhum resultado.');
    return;
  }

  setLoading(bool isLoading) {
    this.isLoading = isLoading;
  }

  _showSnackBar(
      {SnackbarStyle style = SnackbarStyle.info, String message = ''}) {
    final snackbar = CustomSnackBar(
      title: message,
      style: style,
      duration: const Duration(seconds: 5),
    ).build();
    Get.showSnackbar(snackbar);
  }

  Future<void> getPreRegisteredUsersList() async {
    setLoading(true);
    try {
      final result =
          await FirebaseFirestore.instance.collection('pre-registered').get();

      _preRegisteredList.value = result.docs.map((doc) {
        return doc.data();
      }).toList();

      setLoading(false);
    } catch (e) {
      setLoading(false);

      _showSnackBar(
          style: SnackbarStyle.error,
          message: 'Ops. Ocorreu um erro ao recuperar os dados');
    }
  }
}
