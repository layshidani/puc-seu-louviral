import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/app/data/models/report_model.dart';
import 'package:seu_lourival/app/modules/report/report_detail/controller.dart';
import 'package:seu_lourival/global_widgets/design_system/text/title.dart';

class ReportDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ReportDetailController _controller = Get.find();
    final report = Get.arguments as ReportModel;
    print(report.author);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [DSTitle.lg('Detalhes do manifesto')],
    );
  }
}
