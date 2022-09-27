import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/data/models/report_model.dart';
import 'package:seu_lourival/app/modules/report/report_list/controller.dart';
import 'package:seu_lourival/app/widgets/custom_loading.dart';
import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/core/values/strings.dart';
import 'package:seu_lourival/core/values/text_size.dart';
import 'package:seu_lourival/global_widgets/design_system/button/icon_button.dart';
import 'package:seu_lourival/global_widgets/design_system/core/scaffold/scaffold.dart';
import 'package:seu_lourival/global_widgets/design_system/text/text.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';
import 'package:seu_lourival/routes/routes.dart';

class ReportListPage extends StatelessWidget {
  const ReportListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<ReportListController>();

    return DSScaffold(
      hasDrawer: true,
      title: ReportListStrings.scaffoldTitle,
      actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: _controller.reportSearch);
          },
          icon: const Icon(Icons.search),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        backgroundColor: DSColors.primary,
        onPressed: () {
          Get.toNamed(Routes.newReport);
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _controller.getReports();
        },
        child: Obx(
          () => _controller.isLoading
              ? CustomLoading()
              : _controller.isReportListEmpty
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DSText.lg("Nenhum item a ser exibido"),
                          DSIconButton(
                              buttonText: "Recarregar",
                              onPressAction: () {
                                _controller.getReports();
                              }),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListView.builder(
                        itemCount: _controller.reportList.length,
                        itemBuilder: (context, index) {
                          final report = _controller.reportList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 5.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  Routes.reportDetail,
                                  arguments: report,
                                )?.then((value) => _controller.getReports());
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 110,
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        color: getReportCategoryColor(
                                            report.category),
                                        width: 70,
                                        height: 110,
                                        child: getReportCategoryIcon(
                                            report.category),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            DSTitle.base('${report.title}'),
                                            DSText.sm(report.author),
                                            DSText.sm(report.createdAt),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Chip(
                                                  label: Icon(
                                                      report.isPrivate
                                                          ? Icons.lock
                                                          : Icons
                                                              .lock_open_sharp,
                                                      size: DSTextSize.sm,
                                                      color: DSColors.grey800),
                                                ),
                                                Chip(
                                                  label:
                                                      DSText.xsm(report.status),
                                                  labelStyle: TextStyle(
                                                      color: DSColors.grey800),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox.fromSize(
                                        size: const Size(
                                            56, 56), // button width and height
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors
                                                .transparent, // button color
                                            child: InkWell(
                                              splashColor: DSColors
                                                  .primary, // splash color
                                              onTap: () => Get.toNamed(Routes
                                                  .reportDetail), // button pressed
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: DSColors.primary,
                                                  ), // icon
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ),
      ),
    );
  }
}
