import 'package:get/instance_manager.dart';
import 'package:seu_lourival/app/modules/report/report_detail/controller.dart';

class ReportDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ReportDetailController());
  }
}
