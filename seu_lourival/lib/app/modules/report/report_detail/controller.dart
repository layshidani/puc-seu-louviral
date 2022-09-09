import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:seu_lourival/app/data/models/report_model.dart';
import 'package:seu_lourival/app/data/services/report_service.dart';
import 'package:seu_lourival/app/modules/report/new_report/page.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';
import 'package:seu_lourival/core/utils/datetime_helper.dart';
import 'package:seu_lourival/core/values/strings.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/global_widgets/dialog/confirm_dialog.dart';
import 'package:seu_lourival/routes/routes.dart';

class ReportDetailController extends GetxController {
  //loading
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  ReportModel _report = Get.arguments;
  get report => _report;

  final Rx<String> _status = ''.obs;
  String get status => _status.value;
  final Rx<String> _updatedAt = ''.obs;
  String get updatedAt => _updatedAt.value;

  @override
  onReady() {
    super.onReady();
    _report = Get.arguments;
    _status.value = report.status;
    update();
  }

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

  void showChangeStatusBottomSheet(context) {
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DSText.base('Selecione o status'),
            ...getChangeStatusOptions(context)
          ],
        ),
      ),
      backgroundColor: Colors.white,
      isDismissible: true,
    );
  }

  List<Widget> getChangeStatusOptions(context) {
    final List<ReportStatus> statusOptions = [
      ReportStatus.OPEN,
      ReportStatus.IN_PROGRESS,
      ReportStatus.DONE
    ];

    final bottomSheetOptionList = statusOptions.map((status) => {
          BottomSheetOption(
            onTap: () {
              _onConfirmStatusChange(status, context);
              return;
            },
            title: status.description,
            icon: getReportStatusColor(status),
          ),
        });

    return bottomSheetOptionList.expand((i) => i).toList();
  }

  _onConfirmStatusChange(ReportStatus status, context) {
    DSConfirmDialog(
            context: context,
            onConfirmAction: () => _saveStatusChoice(status, context),
            title: 'Alterar status',
            descriptionLine1:
                'Você tem certeza que deseja alterar o status do manifesto para:',
            descriptionLine2: '${status.description}?')
        .show();
  }

  _saveStatusChoice(ReportStatus status, context) async {
    try {
      await ReportService.updateStatus(report.id, status);

      _status.value = status.description;
      _updatedAt.value = DateTimeHelper.fromTimeStamp(DateTime.now());

      Navigator.popUntil(context, ModalRoute.withName(Routes.reportDetail));

      showSnackBar(
          style: SnackbarStyle.success,
          message: 'Sucesso ao atualizar o status');
    } catch (e) {
      showSnackBar(
          style: SnackbarStyle.error,
          message: 'Ops. Ocorreu um erro, tente novamente.');
    }
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
