import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';

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
  var _selectedFilter = defaultFilter.obs;

  get preRegisteredList => _preRegisteredList.value;
  get preRegisteredListFiltered => _preRegisteredListFiltered.value;
  get selectedFilter => _selectedFilter.value;
  get isLoading => _isLoading.value;

  Future<void> getPreRegisteredList() async {
    _setLoading(true);

    try {
      final data = await UserService.getPreRegisteredUsersList();
      _setListValue(data);
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      _showSnackBar(
          style: SnackbarStyle.error,
          message: 'Ops. Ocorreu um erro ao recuperar os dados');
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

    _showSnackBar(message: 'A busca não retornou nenhum resultado.');
    return;
  }

  void clearFilter() {
    _selectedFilter = defaultFilter.obs;
    _preRegisteredListFiltered.value = _preRegisteredList.value;
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
