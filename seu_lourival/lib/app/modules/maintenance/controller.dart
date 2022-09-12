import 'package:flutter_launch/flutter_launch.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/modules/maintenance/widgets/maintenance_contact_list_tile.dart';
import 'package:seu_lourival/core/utils/input_validators.dart';
import 'package:url_launcher/url_launcher.dart';
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
    _isLoading.value = false;
    super.onInit();
  }

  Future<void> getMaintenanceContacts() async {
    final json = await _repository.getMaintenanceContacts();
    final contactList = json.map((element) {
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
  }) {
    switch (action) {
      case MaintenanceContactListTileAction.call:
        return _makePhoneCall(contact);
      case MaintenanceContactListTileAction.whatsapp:
        return _openWhatsapp(contact);
    }
  }

  Future<void> _makePhoneCall(MaintenanceContactModel contact) async {
    launchUrl(Uri.parse("tel:${contact.phone}"));
  }

  Future<void> _openWhatsapp(MaintenanceContactModel contact) async {
    final phone = contact.phone.removeAllWhitespace
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("-", "");
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
}
