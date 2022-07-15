import 'package:get/get.dart';
import 'package:seu_lourival/app/data/models/report_model.dart';
import 'package:seu_lourival/app/data/services/report_service.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';

class ReportListController extends GetxController {
  @override
  void onInit() async {
    await getReports();
    super.onInit();
  }

  final RxList _reportList = [].obs;
  get reportList => _reportList.value;

  final RxBool _isLoading = false.obs;
  get isLoading => _isLoading.value;

  _setLoading(bool isLoading) {
    _isLoading.value = isLoading;
  }

  Future<void> getReports() async {
    try {
      final data = await ReportService.getReports();
      _setListValue(data);
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      _showSnackBar(
          style: SnackbarStyle.error,
          message: 'Ops. Ocorreu um erro ao recuperar os dados');
    }
  }

  void _setListValue(data) {
    _reportList.value = data;
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
}
