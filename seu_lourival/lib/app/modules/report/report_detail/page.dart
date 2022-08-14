import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/data/models/report_model.dart';
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
  final _formKey = GlobalKey<FormState>();

  final report = Get.arguments as ReportModel;

  Widget _buildListTile(String title, String subtitle) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      title: Text(
        title,
        style: TextStyle(
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
    final report = Get.arguments as ReportModel;

    return DSScaffold(
      title: ReportDetailsStrings.title,
      floatingActionButton: SpeedDial(
        closedBackgroundColor: DSColors.primary,
        openBackgroundColor: DSColors.primary,
        child: Icon(Icons.contact_phone),
        speedDialChildren: [
          SpeedDialChild(
            child: Icon(Icons.phone),
            backgroundColor: Colors.amber[700],
            onPressed: () {
              launchUrl(Uri.parse("tel:${report.phone}"));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.whatsapp),
            backgroundColor: Colors.green[700],
            onPressed: () async {
              try {
                await FlutterLaunch.launchWhatsapp(
                    phone: report.phone,
                    message:
                        "Olá, estou entrando em contato para falar sobre seu manifesto: *${report.title}*");
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          controller.onDownloadImage(report);

                          // TODO
                          print("exibir tela com imagem");
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
                                  child: report.photoURL.toString().length > 1
                                      ? Image(
                                          image: NetworkImage(report.photoURL),
                                          fit: BoxFit.cover,
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
                              child: InkWell(
                                onTap: () async {
                                  controller.onDownloadImage(report);
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
                        initialValue: report.title,
                      ),
                      DSTextField(
                        labelText: ReportDetailsStrings.reportDescription,
                        maxLines: null,
                        enabled: false,
                        initialValue: report.description,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: Spacing.s4),
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          hint: DSText.base('${report.category}'),
                          items: const [],
                          onChanged: null,
                        ),
                      ),
                      CheckboxListTile(
                        value: report.isPrivate,
                        onChanged: null,
                        title: DSText.base(ReportDetailsStrings.privateReport),
                        secondary: Icon(
                          report.isPrivate ? Icons.lock : Icons.lock_open_sharp,
                        ),
                      ),
                      const SizedBox(height: 0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildListTile(
                              "${report.author} - apto ${report.homeData.number} bloco ${report.homeData.tower}",
                              "Autor"),
                          _buildListTile(report.status, "Status"),
                          _buildListTile(report.createdAt, "Data de criação"),
                          _buildListTile(
                              report.updatedAt, "Última modificação"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
