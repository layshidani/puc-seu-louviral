import 'package:get/route_manager.dart';
import 'package:seu_lourival/_debug/DS_catalog/page.dart';
import 'package:seu_lourival/_debug/page.dart';
import 'package:seu_lourival/app/modules/add_users/binding.dart';
import 'package:seu_lourival/app/modules/add_users/page.dart';
import 'package:seu_lourival/app/modules/add_users/pre-register/form/page.dart';
import 'package:seu_lourival/app/modules/billboard/page.dart';
import 'package:seu_lourival/app/modules/finance/page.dart';
import 'package:seu_lourival/app/modules/login/binding.dart';
import 'package:seu_lourival/app/modules/login/page.dart';
import 'package:seu_lourival/app/modules/login_error/page.dart';
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
    GetPage(
      name: Routes.addUsers,
      page: () => const AddUsersPage(),
      binding: AddUsersBinding(),
    ),
    GetPage(
      name: Routes.loginError,
      page: () => const LoginErrorPage(),
    ),
    GetPage(
      name: Routes.billboard,
      page: () => const BillboardPage(),
    ),
    GetPage(
      name: Routes.financial,
      page: () => const FinancePage(),
    ),
    GetPage(
      name: Routes.preRegister,
      page: () => PreRegisterFormPage(),
    ),

    GetPage(
      name: Routes.themeCatalog,
      page: () => const ThemesCatalogPage(),
    ),
    // Theme Catalog / Debug
    GetPage(
      name: Routes.debug,
      page: () => const DebugHomePage(),
    ),
  ];
}
