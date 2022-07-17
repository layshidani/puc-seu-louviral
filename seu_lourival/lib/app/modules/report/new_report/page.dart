import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seu_lourival/app/modules/report/new_report/strings.dart';
import 'package:seu_lourival/core/values/spacing.dart';
import 'package:seu_lourival/global_widgets/design_system/button/icon_button.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/field/text_field.dart';
import 'controller.dart';

class NewReportPage extends StatelessWidget {
  NewReportPage({Key? key}) : super(key: key);
  final _controller = Get.find<NewReportController>();
  final _picker = ImagePicker();

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
            iconData: Icons.camera_alt_outlined,
          ),
          BottomSheetOption(
            title: "Galeria",
            onTap: () {
              _showImagePicker(ImageSource.gallery);
            },
            iconData: Icons.photo_album_outlined,
          ),
          SizedBox(height: 10),
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
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.all(Spacing.s4),
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
                            padding: EdgeInsets.only(top: 10),
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
                        return value != null && value.trim().isEmpty
                            ? "Campo obrigatório"
                            : null;
                      },
                      onChange: (value) {
                        _controller.formModel.title = value;
                      },
                    ),
                    DSTextField(
                      labelText: NewReportStrings.reportDescription,
                      maxLines: null,
                      validator: (value) {
                        return value != null && value.trim().isEmpty
                            ? "Campo obrigatório"
                            : null;
                      },
                      onChange: (value) {
                        _controller.formModel.description = value;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(Spacing.s3),
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: _controller.selectedCategory.value,
                        hint: Text("Selecione a categoria"),
                        items: _controller.categories.map((category) {
                          return DropdownMenuItem(
                            value: category.title,
                            child: category.title.trim().isEmpty
                                ? Text("")
                                : Text("${category.icon} - ${category.title}"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          print(value);
                          _controller.formModel.category = value ?? "";
                          // _controller.selectedCategory.value = value!;
                        },
                        validator: (value) {
                          return value != null && value.trim().isEmpty
                              ? "Campo obrigatório"
                              : null;
                        },
                      ),
                    ),
                    CheckboxListTile(
                      value: _controller.isPrivateReport,
                      onChanged: (value) {
                        _controller.isPrivateReport = value ?? false;
                      },
                      title: Text(NewReportStrings.privateReport),
                      secondary: Icon(
                        _controller.isPrivateReport
                            ? Icons.lock
                            : Icons.lock_open_sharp,
                      ),
                    ),
                    SizedBox(height: 10),
                    DSIconButton(
                        buttonText: "Salvar",
                        onPressAction: () {
                          _controller.saveReport(
                            onSuccess: () {
                              Get.back();
                              Get.showSnackbar(
                                GetSnackBar(
                                  title: "Sucesso",
                                  message: "Seu manifesto foi cadastrado",
                                  duration: 3.seconds,
                                ),
                              );
                            },
                          );
                        }),
                  ],
                ),
              ),
      ),
    );
  }
}

class BottomSheetOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData iconData;

  BottomSheetOption({
    required this.title,
    required this.onTap,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(iconData),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
