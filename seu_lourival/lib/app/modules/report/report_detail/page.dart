import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:seu_lourival/app/data/models/report_model.dart';
import 'package:seu_lourival/app/modules/report/report_detail/controller.dart';
import 'package:seu_lourival/app/widgets/custom_loading.dart';
import 'package:seu_lourival/core/values/spacing.dart';
import 'package:seu_lourival/core/values/strings.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/field/text_field.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';

class ReportDetailPage extends StatelessWidget {
  final _controller = Get.find<ReportDetailController>();
  final _formKey = GlobalKey<FormState>();

  final report = Get.arguments as ReportModel;

  @override
  Widget build(BuildContext context) {
    final ReportDetailController _controller = Get.find();
    final report = Get.arguments as ReportModel;

    return DSScaffold(
      title: ReportDetailsStrings.title,
      body: Obx(
        () => _controller.isLoading
            ? CustomLoading()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(Spacing.s4),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          _controller.isLoading = true;
                          await ImageDownloader.downloadImage(report.photoURL,
                              destination:
                                  AndroidDestinationType.directoryPictures);
                          _controller.isLoading = false;
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
                                      ? Image.network(report.photoURL)
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
                                child: const Icon(
                                  Icons.download,
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
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DSText.sm('Autor (a): ${report.author}'),
                          DSText.sm('Criado em: ${report.createdAt}'),
                          DSText.sm(
                              'Última atualização em: ${report.updatedAt}'),
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
