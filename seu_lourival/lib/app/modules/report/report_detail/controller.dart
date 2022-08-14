import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:seu_lourival/app/data/models/report_model.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';
import 'package:seu_lourival/core/values/strings.dart';

class ReportDetailController extends GetxController {
  //loading
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  void onDownloadImage(ReportModel report) async {
    _isLoading.value = true;
    try {
      await ImageDownloader.downloadImage(report.photoURL,
          destination: AndroidDestinationType.directoryPictures);

      showSnackBar(
          style: SnackbarStyle.success,
          message: ReportDetailsStrings.snackbarSuccess);
    } catch (e) {
      showSnackBar(
          style: SnackbarStyle.error,
          message: ReportDetailsStrings.snackbarError);
    }

    _isLoading.value = false;
  }

  void showSnackBar(
      {SnackbarStyle style = SnackbarStyle.info, String message = ''}) {
    final snackbar = CustomSnackBar(
      title: message,
      style: style,
      duration: const Duration(seconds: 5),
    ).build();
    Get.showSnackbar(snackbar);
  }
}
