import 'package:get/route_manager.dart';
import 'package:seu_lourival/app/modules/login/binding.dart';
import 'package:seu_lourival/app/modules/login/page.dart';
import 'package:seu_lourival/app/modules/sms_validation/binding.dart';
import 'package:seu_lourival/app/modules/sms_validation/page.dart';
import 'package:seu_lourival/routes/routes.dart';

import '../app/modules/report/page.dart';

class Pages {
  static List<GetPage<dynamic>>? pages = [
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.smsValidation,
      page: () => SmsValidationPage(),
      binding: SmsValidationBinding(),
    ),
    GetPage(
      name: Routes.reportList,
      page: () => ReportListPage(),
    ),
  ];
}
