import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
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
  final RxBool _isLoading = false.obs;
  final _usersList = [].obs;
  final _usersListFiltered = [].obs;
  var _selectedFilter = defaultFilter.obs;

  get usersList => _usersList.value;
  get usersListFiltered => _usersListFiltered.value;
  get selectedFilter => _selectedFilter.value;
  get isLoading => _isLoading.value;

  Future<void> getUsersList() async {
    _setLoading(true);

    try {
      final data = await UserService().getUsersList();
      _setListValue(data);
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      _showSnackBar(
          style: SnackbarStyle.error,
          message: 'Ops. Ocorreu um erro ao recuperar os dados');
    }
  }

  void onFilterUsers(String filter) async {
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

  void clearFilter() {
    _selectedFilter = defaultFilter.obs;
    _usersListFiltered.value = _usersList.value;
  }

  void _showSnackBar(
      {SnackbarStyle style = SnackbarStyle.info, String message = ''}) {
    final snackbar = CustomSnackBar(
      title: message,
      style: style,
      duration: const Duration(seconds: 5),
    ).build();
    Get.showSnackbar(snackbar);
  }

  void _setListValue(List<Map<String, dynamic>> data) {
    _usersList.value = data;
    _usersListFiltered.value = data;
  }

  void _setLoading(bool isLoading) {
    _isLoading.value = isLoading;
  }
}
