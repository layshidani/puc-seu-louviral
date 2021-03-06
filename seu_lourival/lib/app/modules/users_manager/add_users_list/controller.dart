import 'package:get/get.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';
import 'package:seu_lourival/global_widgets/dialog/confirm_dialog.dart';
import 'package:seu_lourival/core/values/strings.dart';

class AddUsersListController extends GetxController {
  @override
  void onInit() async {
    _selectedFilter = defaultFilter.obs;
    await getPreRegisteredList();
    super.onInit();
  }

  static const String defaultFilter = 'Todos';
  final RxBool _isLoading = false.obs;
  final _preRegisteredList = [].obs;
  final _preRegisteredListFiltered = [].obs;
  RxString _selectedFilter = defaultFilter.obs;
  var _userToDelete;

  get preRegisteredList => _preRegisteredList.value;
  get preRegisteredListFiltered => _preRegisteredListFiltered.value;
  get selectedFilter => _selectedFilter.value;
  get isLoading => _isLoading.value;

  Future<void> getPreRegisteredList() async {
    _selectedFilter = defaultFilter.obs;
    _setLoading(true);

    try {
      final data = await UserService.getPreRegisteredUsersList();
      _setListValue(data);
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      _showSnackBar(
          style: SnackbarStyle.error,
          message: UsersManagerStrings.getDataError);
    }
  }

  void onFilterPreRegisterUsers(String filter) async {
    _selectedFilter.value = filter;
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

    _showSnackBar(message: UsersManagerStrings.emptySearch);
    return;
  }

  void clearFilter() {
    _selectedFilter = defaultFilter.obs;
    _preRegisteredListFiltered.value = _preRegisteredList.value;
  }

  void _clearDelete() {
    _userToDelete = {};
    _setLoading(false);
    Get.back();
  }

  Future<void> onConfirmDelete(context, user) async {
    _setLoading(true);
    _userToDelete = user;

    DSConfirmDialog(
            context: context,
            title: 'Excluir usu??rio',
            descriptionLine1: 'Essa a????o n??o poder?? ser desfeita.',
            descriptionLine2: 'Voc?? deseja excluir o usu??rio  ${_userToDelete['name']} (${_userToDelete['type']}) do pr?? registro?',
            onConfirmAction: _onDeletePreregistered)
        .show();
  }

  Future<void> _onDeletePreregistered() async {
    try {
      final cpf = _userToDelete['cpf'];

      await UserService.onDeletePreRegistered(cpf: cpf);

      _clearDelete();
      getPreRegisteredList();

      _showSnackBar(style: SnackbarStyle.success, message: 'Usu??rio exclu??do.');
    } catch (e) {
      _clearDelete();
      _showSnackBar(
          style: SnackbarStyle.error,
          message: 'Ops. Ocorreu um erro, tente novamente.');
    }
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
    _preRegisteredList.value = data;
    _preRegisteredListFiltered.value = data;
  }

  void _setLoading(bool isLoading) {
    _isLoading.value = isLoading;
  }
}
