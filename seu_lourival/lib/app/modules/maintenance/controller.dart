import 'package:flutter_launch/flutter_launch.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/modules/maintenance/widgets/maintenance_contact_list_tile.dart';
import 'package:seu_lourival/app/widgets/custom_confirm_alert_dialog.dart';
import 'package:seu_lourival/core/utils/input_validators.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/maintenance_contact_model.dart';
import '../../widgets/custom_snack_bar.dart';
import 'repository.dart';
import 'package:flutter/material.dart';

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

  final contacts = <MaintenanceContactModel>[].obs;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  @override
  void onInit() async {
    _isLoading.value = true;
    await Future.delayed(2.seconds);
    _categories = await _repository.getCategories();
    await getMaintenanceContacts();
    print(contacts);
    _isLoading.value = false;
    super.onInit();
  }

  Future<void> getMaintenanceContacts() async {
    final json = await _repository.getMaintenanceContacts();
    print("--> ${json}");
    final contactList = json.map((element) {
      print("--> $element");
      return MaintenanceContactModel.fromJson(json: element);
    }).toList();
    contacts.value = contactList;
  }

  Future<void> saveMaintenanceContact() async {
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

  Future<void> didSelectAction(
    MaintenanceContactListTileAction action, {
    required MaintenanceContactModel contact,
  }) async {
    switch (action) {
      case MaintenanceContactListTileAction.call:
        return _makePhoneCall(contact);
      case MaintenanceContactListTileAction.whatsapp:
        return await _openWhatsapp(contact);
      case MaintenanceContactListTileAction.delete:
        return await _askToDeleteContact(contact);
    }
  }

  void _makePhoneCall(MaintenanceContactModel contact) {
    print("--> ${contact.phone}");
    launchUrl(Uri.parse("tel:${contact.phone}"));
  }

  Future<void> _openWhatsapp(MaintenanceContactModel contact) async {
    final phone = contact.phone.removeAllWhitespace
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("-", "");
    print("--> $phone");
    try {
      await FlutterLaunch.launchWhatsapp(
          phone: phone,
          message:
              "Olá, ${contact.name}. Gostaria de solicitar um orçamento para seu serviço de manutenção.");
    } catch (e) {
      final snack = CustomSnackBar(
        title: "Erro ao abrir Whatsapp",
        style: SnackbarStyle.error,
      ).build();
      Get.showSnackbar(snack);
    }
  }

  Future<void> _askToDeleteContact(MaintenanceContactModel contact) async {
    Get.dialog(
      CustomConfirmAlertDialog(
              title: contact.name,
              description: "Gostaria de deletar este contato de manutenção?",
              cancelAction: () => Get.back(),
              cancelTitle: "Cancelar",
              confirmAction: () async {
                await _deleteContact(contact.id);
              },
              confirmTitle: "Confirmar")
          .build(),
    );
  }

  Future<void> _deleteContact(String? id) async {
    Get.back();
    if (id != null) {
      isLoading = true;
      await _repository.deleteMaintenanceContact(id);
      contacts.removeWhere((contact) {
        return contact.id == id;
      });
      // update();
      print("--> LENGTH DOS CONTATOS DEPOIS DE DELETAR: ${contacts.length}");
      CustomSnackBar(
        title: 'Contato deletado com sucesso',
        style: SnackbarStyle.success,
      ).showSnackbar();
      isLoading = false;
    } else {
      CustomSnackBar(
        title: "Erro ao deletar contato de manutenção",
        style: SnackbarStyle.error,
      ).showSnackbar();
    }
  }
}
