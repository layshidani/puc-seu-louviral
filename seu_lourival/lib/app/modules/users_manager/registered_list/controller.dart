import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';

class RegisteredListController extends GetxController {
  @override
  void onInit() async {
    _selectedFilter = defaultFilter.obs;
    await getUsersList();
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
  var _usersList = [].obs;
  var _usersListFiltered = [].obs;
  var _selectedFilter = defaultFilter.obs;

  get usersList => _usersList.value;
  get usersListFiltered => _usersListFiltered.value;
  get selectedFilter => _selectedFilter.value;
  get isLoading => _isLoading.value;

  clearFilter() {
    _selectedFilter = defaultFilter.obs;
    _usersListFiltered.value = _usersList.value;
  }

  onFilterUsers(String filter) async {
    _selectedFilter.value = filter;

    var result =
        usersList.where((user) => user['type'] == filter).toList();

    if (filter == defaultFilter) {
      _usersListFiltered.value = _usersList.value;
      return;
    }

    if (result.length >= 1) {
      _usersListFiltered.value = result;
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

  Future<void> getUsersList() async {
    setLoading(true);
    try {
      final result =
          await FirebaseFirestore.instance.collection('users').get();

      final data = result.docs.map((doc) {
        return doc.data();
      }).toList();

      _usersList.value = data;
      _usersListFiltered.value = data;

      setLoading(false);
    } catch (e) {
      setLoading(false);

      _showSnackBar(
          style: SnackbarStyle.error,
          message: 'Ops. Ocorreu um erro ao recuperar os dados');
    }
  }
}
