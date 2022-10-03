import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seu_lourival/app/modules/report/new_report/strings.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';
import 'package:seu_lourival/core/utils/input_validators.dart';
import 'package:seu_lourival/core/values/spacing.dart';
import 'package:seu_lourival/global_widgets/design_system/button/icon_button.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/field/text_field.dart';
import 'controller.dart';

class NewReportPage extends StatelessWidget {
  NewReportPage({Key? key}) : super(key: key);
  final _controller = Get.find<NewReportController>();
  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  void _showModalBottomSheet() {
    Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetOption(
            title: "Câmera",
            onTap: () {
              _showImagePicker(ImageSource.camera);
            },
            icon: const Icon(Icons.camera_alt_outlined),
          ),
          BottomSheetOption(
            title: "Galeria",
            onTap: () {
              _showImagePicker(ImageSource.gallery);
            },
            icon: const Icon(Icons.photo_album_outlined),
          ),
          const SizedBox(height: 10),
        ],
      ),
      backgroundColor: Colors.white,
      isDismissible: true,
    );
  }

  void _showImagePicker(ImageSource source) async {
    //dismiss bottom sheet
    Get.back();

    final file = await _picker.pickImage(source: source);
    if (file != null) {
      _controller.path.value = file.path;
      _controller.formModel.imagePath = file.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DSScaffold(
      title: NewReportStrings.title,
      body: Obx(
        () => _controller.isLoading
            ? const Center(
                child: const CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(Spacing.s4),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _showModalBottomSheet();
                        },
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: <Widget>[
                            Container(
                              height: 250,
                              width: 250,
                              padding: const EdgeInsets.only(top: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(150),
                                child: Container(
                                  height: 250,
                                  width: 250,
                                  color: Colors.grey[200],
                                  child: _controller.path.isNotEmpty
                                      ? Image.file(
                                          File(_controller.path.value),
                                          fit: BoxFit.fill,
                                        )
                                      : Icon(Icons.image_outlined,
                                          size: 50, color: Colors.grey[500]),
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[200]),
                                child: Icon(
                                  _controller.path.isNotEmpty
                                      ? Icons.edit
                                      : Icons.add,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      DSTextField(
                        labelText: NewReportStrings.reportTitle,
                        validator: (value) {
                          return DSInputValidators.isFieldValid(
                              minCharacters: 5, value: value);
                        },
                        onChange: (value) {
                          _controller.formModel.title = value;
                        },
                      ),
                      DSTextField(
                        labelText: NewReportStrings.reportDescription,
                        maxLines: null,
                        validator: (value) {
                          return DSInputValidators.isFieldValid(
                              minCharacters: 10, value: value);
                        },
                        onChange: (value) {
                          _controller.formModel.description = value;
                        },
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: Spacing.s4),
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: _controller.selectedCategory.value,
                          hint: const Text("Selecione a categoria"),
                          items: _controller.categories.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: category.trim().isEmpty
                                  ? const Text("")
                                  : Text(category),
                            );
                          }).toList(),
                          onChanged: (value) {
                            _controller.formModel.category = value ?? "";
                          },
                          validator: (value) {
                            return DSInputValidators.isFieldValid(
                                minCharacters: 0, value: value);
                          },
                        ),
                      ),
                      CheckboxListTile(
                        value: _controller.isPrivateReport,
                        onChanged: (value) {
                          _controller.isPrivateReport = value ?? false;
                        },
                        title: const Text(NewReportStrings.privateReport),
                        secondary: Icon(
                          _controller.isPrivateReport
                              ? Icons.lock
                              : Icons.lock_open_sharp,
                        ),
                      ),
                      const SizedBox(height: 10),
                      DSIconButton(
                        buttonText: "Salvar",
                        onPressAction: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _controller.saveReport(onSuccess: () {
                              Get.back();
                              CustomSnackBar(
                                title: "Seu manifesto foi cadastrado",
                                style: SnackbarStyle.success,
                              ).build().show();
                            }, onFailure: (errorMessage) {
                              Get.showSnackbar(
                                GetSnackBar(
                                  message: errorMessage,
                                  duration: 3.seconds,
                                ),
                              );
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class BottomSheetOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Icon icon;

  BottomSheetOption({
    required this.title,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
