import 'package:get/get.dart';
import 'package:seu_lourival/app/modules/report/report_list/controller.dart';

class ReportListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ReportListController());
  }
}
