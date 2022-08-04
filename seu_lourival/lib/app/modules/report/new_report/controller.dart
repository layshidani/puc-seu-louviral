import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seu_lourival/routes/routes.dart';
import 'repository.dart';

class NewReportController extends GetxController {
  //repository
  final NewReportRepository _repository;

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

  NewReportController(this._repository);

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
        "reports/uuid_aleatorio_do_usuario_${Random().nextInt(999)}/${DateTime.now().toString()}";
    final uploadedURL = await _repository.uploadImage(
        file: File(formModel.imagePath), ref: ref);
    final author = Author(
        uuid: "a123ubl1j2hl2k3h4lkjh",
        name: "Bryan Barreto",
        phone: "5521912121212");
    final report = Report(
      title: formModel.title,
      description: formModel.description,
      photoURL: uploadedURL,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: "Em aberto",
      author: author,
      isPrivate: formModel.isPrivate,
      category: formModel.category,
    );
    await _repository.addReport(report);
    isLoading = false;
    onSuccess();
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
