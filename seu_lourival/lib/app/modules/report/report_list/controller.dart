import 'package:get/get.dart';
import 'package:seu_lourival/app/data/models/report_model.dart';
import 'package:seu_lourival/app/data/services/report_service.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';
import 'package:seu_lourival/core/values/strings.dart';

class ReportListController extends GetxController {
  @override
  void onReady() async {
    await getReports();
    super.onReady();
  }

  final RxList _reportList = [].obs;
  get reportList => _reportList.value;

  final RxBool _isLoading = false.obs;
  get isLoading => _isLoading.value;

  bool get isReportListEmpty => _reportList.length <= 0;

  _setLoading(bool isLoading) {
    _isLoading.value = isLoading;
  }

  Future<void> getReports() async {
    try {
      _setLoading(true);
      final data = await ReportService.getReports();
      _setListValue(data);
      _setLoading(false);

      print('🎯🎯🎯🎯🎯🎯🎯🎯🎯 GET REPORTS');
    } catch (e) {
      _setLoading(false);
      _showSnackBar(
          style: SnackbarStyle.error,
          message: ReportListStrings.getReportsError);
    }
  }

  void _setListValue(data) {
    _reportList.value = data;
  }

  void setReport(ReportModel model) {
    _reportList.insert(0, model);
    // _reportList.add(model);
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
