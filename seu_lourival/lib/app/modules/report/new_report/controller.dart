import 'dart:io';

import 'package:get/get.dart';
import 'package:seu_lourival/app/data/models/report_model.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
import 'package:seu_lourival/app/modules/report/report_list/controller.dart';
import 'package:seu_lourival/core/utils/datetime_helper.dart';
import 'repository.dart';

class NewReportController extends GetxController {
  //repository
  final NewReportRepository _repository;
  final UserService _service;
  final ReportListController _reportListController;

  //loading
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  //private report
  final _isPrivateReport = false.obs;
  bool get isPrivateReport => _isPrivateReport.value;
  set isPrivateReport(bool value) => _isPrivateReport.value = value;

  //category list
  List<String> categories = [];
  Rx<String?> selectedCategory = null.obs;

  //image file path
  var path = "".obs;

  //form model
  final formModel = AddReportFormModel();

  NewReportController(
      this._repository, this._service, this._reportListController);

  @override
  void onInit() async {
    isLoading = true;
    categories = await _repository.getCategories();
    isLoading = false;
    super.onInit();
  }

  Future<void> saveReport(
      {required Function onSuccess,
      required Function(String) onFailure}) async {
    if (path.isEmpty) {
      onFailure("Escolha uma foto para este manifesto");
      return;
    }
    isLoading = true;
    final ref =
        "reports/${_service.user?.uuid ?? "error"}/${DateTime.now().toString()}";
    final uploadedURL = await _repository.uploadImage(
        file: File(formModel.imagePath), ref: ref);
    final author = Author(
        uuid: _service.user?.uuid ?? "error",
        name: _service.user?.name ?? "error",
        phone: _service.user?.phone ?? "error",
        homeData: _service.user!.homeData!);
    final report = Report(
      title: formModel.title,
      description: formModel.description,
      photoURL: uploadedURL,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: "Em aberto",
      author: author,
      isPrivate: _isPrivateReport.value,
      category: formModel.category,
    );
    await _repository.addReport(report);
    isLoading = false;
    _addReportToList(report);
    onSuccess();
  }

  void _addReportToList(Report report) {
    final reportModel = ReportModel(
      phone: report.author.phone,
      authorId: report.author.uuid,
      isPrivate: report.isPrivate,
      title: report.title,
      category: report.category,
      author: report.author.name,
      createdAt: DateTimeHelper.fromTimeStamp(report.createdAt),
      description: report.description,
      photoURL: report.photoURL,
      status: report.status,
      updatedAt: DateTimeHelper.fromTimeStamp(report.updatedAt),
      homeData: report.author.homeData,
    );
    _reportListController.setReport(reportModel);
  }
}

class AddReportFormModel {
  String title = "";
  String description = "";
  String category = "";
  String imagePath = "";
  bool isPrivate = false;

  @override
  String toString() {
    return "{"
        "title: $title,"
        " description: $description, "
        "category: $category,"
        " imagePath: $imagePath,"
        " isPrivate: $isPrivate"
        "}";
  }
}
