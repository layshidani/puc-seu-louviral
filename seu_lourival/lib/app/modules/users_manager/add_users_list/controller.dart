import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';

class AddUsersListController extends GetxController {
  @override
  void onInit() async {
    _selectedFilter = defaultFilter.obs;
    await getPreRegisteredUsersList();
    super.onInit();
  }

  List<String> userTypes = [
    'Todos',
    'Morador',
    'Porteiro',
    'Manutenção',
    'Zelador',
    'Financeiro',
    'Outros',
  ];
  static const String defaultFilter = 'Todos';
  RxBool _isLoading = false.obs;
  var _preRegisteredList = [].obs;
  var _preRegisteredListFiltered = [].obs;
  var _selectedFilter = defaultFilter.obs;

  get preRegisteredList => _preRegisteredList.value;
  get preRegisteredListFiltered => _preRegisteredListFiltered.value;
  get selectedFilter => _selectedFilter.value;
  get isLoading => _isLoading.value;

  clearFilter() {
    _selectedFilter = defaultFilter.obs;
    _preRegisteredListFiltered.value = _preRegisteredList.value;
  }

  onFilterPreRegisterUsers(String filter) async {
    _selectedFilter.value = filter;

    print('>>>> ${selectedFilter}');
    var result =
        preRegisteredList.where((user) => user['type'] == filter).toList();

    if (filter == defaultFilter) {
      _preRegisteredListFiltered.value = _preRegisteredList.value;
      return;
    }

    if (result.length >= 1) {
      _preRegisteredListFiltered.value = result;
      return;
    }

    _showSnackBar(message: 'A busca não retornou nenhum resultado.');
    return;
  }

  setLoading(bool isLoading) {
    _isLoading.value = isLoading;
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

      final data = result.docs.map((doc) {
        return doc.data();
      }).toList();

      _preRegisteredList.value = data;
      _preRegisteredListFiltered.value = data;

      setLoading(false);
    } catch (e) {
      setLoading(false);

      _showSnackBar(
          style: SnackbarStyle.error,
          message: 'Ops. Ocorreu um erro ao recuperar os dados');
    }
  }
}
