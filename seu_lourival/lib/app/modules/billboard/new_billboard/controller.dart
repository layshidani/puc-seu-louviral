import 'dart:io';

import 'package:get/get.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
import 'package:seu_lourival/app/modules/billboard/controller.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';
import 'repository.dart';

class NewBillboardController extends GetxController {
  //repository
  final NewBillboardRepository _repository;
  final UserService _service;

  //loading
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  //category list
  List<String> categories = [];
  Rx<String?> selectedCategory = null.obs;

  //image file path
  var path = "".obs;

  //form model
  final formModel = StoryModel(id: "");

  NewBillboardController(
    this._repository,
    this._service,
  );

  @override
  void onInit() async {
    isLoading = true;
    print("CATEGORIAS: ${categories.isEmpty}");
    categories = await _repository.getCategories();
    isLoading = false;
    super.onInit();
  }

  Future<void> saveBillboard() async {
    isLoading = true;
    final ref =
        "billboard/${_service.user?.uuid ?? "error"}/${DateTime.now().toString()}";

    var uploadedURL;
    if (formModel.url != null) {
      uploadedURL = await _repository.uploadImage(
          file: File(formModel.url ?? ''), ref: ref);
    }
    final billboard = StoryModel(
      id: '${_service.user?.uuid}-${DateTime.now()}-${formModel.category}',
      caption: formModel.caption,
      url: uploadedURL,
      createdAt: DateTime.now(),
      category: formModel.category,
    );
    try {
      final billboardID = await _repository.addBillboard(billboard);
      Get.back();

      showSnackBar(
        message: "Seu comunicado foi salvo com sucesso!",
        style: SnackbarStyle.success,
      );
    } catch (e) {
      showSnackBar(
        message: "Erro ao salvar o comunicado: ${e.toString()}",
        style: SnackbarStyle.error,
      );
    } finally {
      final billboardController = Get.find<BillboardController>();
      billboardController.reloadStories();
      isLoading = false;
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
