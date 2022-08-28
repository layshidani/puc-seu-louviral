import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:seu_lourival/app/modules/maintenance/page.dart';
import 'package:seu_lourival/core/utils/input_validators.dart';
import '../../data/models/maintenance_contact_model.dart';
import '../../widgets/custom_snack_bar.dart';
import 'repository.dart';

class MaintenanceController extends GetxController {
  final MaintenanceRepository _repository;
  MaintenanceController(this._repository);

  var contact = MaintenanceContactModel(
    category: [],
    name: "",
    phone: "",
  );

  List<String> _categories = [];
  List<String> get categories => _categories;

  var contacts = <MaintenanceContactModel>[].obs;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  @override
  void onInit() async {
    _isLoading.value = true;
    await Future.delayed(2.seconds);
    _categories = await _repository.getCategories();
    _isLoading.value = false;
    super.onInit();
  }

  Future<void> saveMaintenanceContact() async {
    print("--> is empty? ${contact.category.isEmpty}");
    print("length: ${contact.category.length}");
    if (contact.category.isEmpty) {
      _showSnackbar(
        message: "Escolha pelo menos uma categoria",
        style: SnackbarStyle.error,
      );
      return;
    }
    isLoading = true;
    final json = contact.toJson();
    final id = await _repository.saveMaintenanceContact(json);
    contact.id = id;
    contacts.add(contact);
    isLoading = false;
    Get.back();
    _showSnackbar(
      message: "Contato salvo com sucesso",
      style: SnackbarStyle.success,
    );
    contact = MaintenanceContactModel(
      category: [],
      name: "",
      phone: "",
    );
  }

  String? validateTextFormField(String? value, int minCharacters) {
    return DSInputValidators.isFieldValid(
      minCharacters: minCharacters,
      value: value,
    );
  }

  void _showSnackbar({required String message, required SnackbarStyle style}) {
    final snackbar = CustomSnackBar(
      title: message,
      style: style,
    ).build();
    Get.showSnackbar(snackbar);
  }
}
