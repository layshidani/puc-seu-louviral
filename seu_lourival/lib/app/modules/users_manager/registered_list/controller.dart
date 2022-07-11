import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';
import 'package:seu_lourival/global_widgets/dialog/confirm_dialog.dart';

class RegisteredListController extends GetxController {
 @override
  void onInit() async {
    _selectedFilter = defaultFilter.obs;
    await getUsersList();
    super.onInit();
  }

  static const String defaultFilter = 'Todos';
  final RxBool _isLoading = false.obs;
  final _usersList = [].obs;
  final _usersListFiltered = [].obs;
  RxString _selectedFilter = defaultFilter.obs;
  var _userToDelete;

  get usersList => _usersList.value;
  get usersListFiltered => _usersListFiltered.value;
  get selectedFilter => _selectedFilter.value;
  get isLoading => _isLoading.value;

  Future<void> getUsersList() async {
    _setLoading(true);

    try {
      final data = await UserService.getUsersList();
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
  
  Future<void> onConfirmDelete(context, user) async {
    _setLoading(true);
    _userToDelete = user;

    DSConfirmDialog(
            context: context,
            title: 'Excluir usuário',
            descriptionLine1: 'Essa ação não poderá ser desfeita.',
            descriptionLine2:
                'Você deseja excluir o usuário  ${_userToDelete['name']} (${_userToDelete['type']}) do sistema?',
            onConfirmAction: _onDeleteUser)
        .show();
  }

  Future<void> _onDeleteUser() async {
    try {
      final cpf = _userToDelete['cpf'];

      await UserService.onDeleteUser(cpf: cpf);

      _clearDelete();
      getUsersList();

      _showSnackBar(style: SnackbarStyle.success, message: 'Usuário excluído.');
    } catch (e) {
      _clearDelete();
      _showSnackBar(
          style: SnackbarStyle.error,
          message: 'Ops. Ocorreu um erro, tente novamente.');
    }
  }

  void clearFilter() {
    _selectedFilter = defaultFilter.obs;
    _usersListFiltered.value = _usersList.value;
  }

  void _clearDelete() {
    _userToDelete = {};
    _setLoading(false);
    Get.back();
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
