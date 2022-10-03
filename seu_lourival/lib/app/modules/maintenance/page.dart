import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:seu_lourival/app/data/models/user_model.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
import 'package:seu_lourival/app/modules/maintenance/widgets/category_selector.dart';
import 'package:seu_lourival/app/modules/maintenance/widgets/maintenance_contact_list_tile.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/field/text_field.dart';
import 'controller.dart';

class MaintenancePage extends StatelessWidget {
  MaintenancePage({Key? key}) : super(key: key);

  final _controller = Get.find<MaintenanceController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _loggedUser = Get.find<UserService>().user;
    return DSScaffold(
      title: "Manutenção",
      hasDrawer: true,
      floatingActionButton: _loggedUser?.type == UserType.ADMIN
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Novo contato de manutenção"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancelar")),
                          TextButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _controller.saveMaintenanceContact();
                                }
                              },
                              child: Text("Salvar")),
                        ],
                        content: Obx(
                          () => _controller.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DSTextField(
                                        labelText: "Nome",
                                        onChange: (value) {
                                          _controller.contact.name = value;
                                        },
                                        validator: (value) {
                                          return _controller
                                              .validateTextFormField(
                                            value,
                                            4,
                                          );
                                        },
                                      ),
                                      DSTextField(
                                        labelText: "Telefone",
                                        prefix: "+55 ",
                                        keyboardType: TextInputType.phone,
                                        formatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          TelefoneInputFormatter(),
                                        ],
                                        onChange: (value) {
                                          _controller.contact.phone = value;
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return "Campo obrigatório";
                                          } else if (value.length < 14) {
                                            return "Preencha um número válido";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 8),
                                      Expanded(
                                        child: Scrollbar(
                                          thumbVisibility: true,
                                          child: SingleChildScrollView(
                                            child: Wrap(
                                              direction: Axis.horizontal,
                                              children: _controller.categories
                                                  .map((category) {
                                                return CategorySelector(
                                                  label: category,
                                                  selectedCategories:
                                                      _controller
                                                          .contact.category,
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      );
                    });
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: Obx(
        () => _controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _controller.contacts.isEmpty
                ? const Center(
                    child: Text(
                      "Nenhum contato de manutenção cadastrado",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await _controller.getMaintenanceContacts();
                    },
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final contact = _controller.contacts[index];
                        return MaintenanceContactListTile(
                          contact: contact,
                          onDelete: () async {
                            await _controller.deleteMaintenanceContact(contact);
                          },
                          onTap: (action) {
                            _controller.didSelectAction(action,
                                contact: contact);
                          },
                        );
                      },
                      padding: EdgeInsets.all(16),
                      itemCount: _controller.contacts.length,
                    ),
                  ),
      ),
    );
  }
}
