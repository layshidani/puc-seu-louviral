import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:get/get.dart';
import 'package:image_fade/image_fade.dart';
import 'package:seu_lourival/app/data/models/report_model.dart';
import 'package:seu_lourival/app/data/models/user_model.dart';
import 'package:seu_lourival/app/data/services/user_service.dart';
import 'package:seu_lourival/app/modules/report/report_detail/controller.dart';
import 'package:seu_lourival/app/widgets/custom_loading.dart';
import 'package:seu_lourival/app/widgets/custom_snack_bar.dart';
import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/core/values/spacing.dart';
import 'package:seu_lourival/core/values/strings.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/field/text_field.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportDetailPage extends StatelessWidget {
  final controller = Get.find<ReportDetailController>();
  final isAdmin = Get.find<UserService>().user?.type == UserType.ADMIN;
  final _formKey = GlobalKey<FormState>();

  Widget _buildListTile(String title, String subtitle) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ReportDetailController controller = Get.find();

    final ReportModel report = Get.arguments as ReportModel;

    return DSScaffold(
      title: ReportDetailsStrings.title,
      actions: [
        controller.canDeleteReport()
            ? Row(
                children: [
                  IconButton(
                    onPressed: () =>
                        controller.onConfirmDelete(report, context),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              )
            : Container(),
      ],
      floatingActionButton: !isAdmin
          ? null
          : SpeedDial(
              closedBackgroundColor: DSColors.primary,
              openBackgroundColor: DSColors.primary,
              child: const Icon(Icons.contact_phone),
              speedDialChildren: [
                SpeedDialChild(
                  child: const Icon(Icons.phone),
                  backgroundColor: Colors.amber[700],
                  onPressed: () {
                    launchUrl(Uri.parse("tel:${controller.report.phone}"));
                  },
                ),
                SpeedDialChild(
                  child: const Icon(Icons.whatsapp),
                  backgroundColor: Colors.green[700],
                  onPressed: () async {
                    try {
                      await FlutterLaunch.launchWhatsapp(
                          phone: controller.report.phone,
                          message:
                              "Olá, estou entrando em contato para falar sobre seu manifesto: *${controller.report.title}*");
                    } catch (e) {
                      final snack = CustomSnackBar(
                        title: "Erro ao abrir Whatsapp",
                        style: SnackbarStyle.error,
                      ).build();
                      Get.showSnackbar(snack);
                    }
                  },
                ),
              ],
            ),
      body: Obx(
        () => controller.isLoading
            ? CustomLoading()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(Spacing.s4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: DSText.base(controller.status),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          backgroundColor: DSColors.tertiary,
                        ),
                        controller.canEditReport()
                            ? TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: DSColors.tertiary,
                                  shape: const CircleBorder(),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: DSColors.grey800,
                                ),
                                onPressed: () {
                                  controller
                                      .showChangeStatusBottomSheet(context);
                                },
                              )
                            : Container(),
                      ],
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              controller.onDownloadImage(controller.report);

                              // TODO exibir tela com imagem
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
                                      child: controller.report.photoURL
                                                  .toString()
                                                  .length >
                                              1
                                          ? ImageFade(
                                              // whenever the image changes, it will be loaded, and then faded in:
                                              image: NetworkImage(
                                                  controller.report.photoURL),

                                              // slow fade for newly loaded images:
                                              duration: const Duration(
                                                  milliseconds: 300),

                                              // if the image is loaded synchronously (ex. from memory), fade in faster:
                                              syncDuration: const Duration(
                                                  milliseconds: 150),

                                              // supports most properties of Image:
                                              alignment: Alignment.center,
                                              fit: BoxFit.cover,

                                              // shown behind everything:
                                              placeholder: Container(
                                                color: const Color(0xFFCFCDCA),
                                                alignment: Alignment.center,
                                                child: const Icon(Icons.photo,
                                                    color: Colors.white30,
                                                    size: 128.0),
                                              ),

                                              // shows progress while loading an image:
                                              loadingBuilder: (context,
                                                      progress, chunkEvent) =>
                                                  Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                              value: progress)),

                                              // displayed when an error occurs:
                                              errorBuilder: (context, error) =>
                                                  Container(
                                                color: const Color(0xFF6F6D6A),
                                                alignment: Alignment.center,
                                                child: const Icon(Icons.warning,
                                                    color: Colors.black26,
                                                    size: 128.0),
                                              ),
                                            )
                                          : Icon(Icons.image_outlined,
                                              size: 50,
                                              color: Colors.grey[500]),
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
                                  child: InkWell(
                                    onTap: () async {
                                      controller
                                          .onDownloadImage(controller.report);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[200]),
                                      child: const Icon(
                                        Icons.download,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DSTextField(
                            labelText: ReportDetailsStrings.reportTitle,
                            enabled: false,
                            initialValue: controller.report.title,
                          ),
                          DSTextField(
                            labelText: ReportDetailsStrings.reportDescription,
                            maxLines: null,
                            enabled: false,
                            initialValue: controller.report.description,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Spacing.s4),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              hint:
                                  DSText.base('${controller.report.category}'),
                              items: const [],
                              onChanged: null,
                            ),
                          ),
                          CheckboxListTile(
                            value: controller.report.isPrivate,
                            onChanged: null,
                            title:
                                DSText.base(ReportDetailsStrings.privateReport),
                            secondary: Icon(
                              controller.report.isPrivate
                                  ? Icons.lock
                                  : Icons.lock_open_sharp,
                            ),
                          ),
                          const SizedBox(height: 0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildListTile(
                                  "${controller.report.author}\nApto ${controller.report.homeData.number} - ${controller.report.homeData.tower}",
                                  "Autor"),
                              _buildListTile(controller.status, "Status"),
                              _buildListTile(controller.report.createdAt,
                                  "Data de criação"),
                              _buildListTile(
                                  controller.updatedAt, "Última modificação"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
