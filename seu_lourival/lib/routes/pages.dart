import 'package:get/route_manager.dart';

import 'package:seu_lourival/_debug/page.dart';
import 'package:seu_lourival/app/modules/login/binding.dart';
import 'package:seu_lourival/app/modules/login/page.dart';
import 'package:seu_lourival/app/modules/report/new_report/binding.dart';
import 'package:seu_lourival/app/modules/report/new_report/page.dart';

import 'package:seu_lourival/_debug/DS_catalog/page.dart';
import 'package:seu_lourival/_debug/page.dart';
import 'package:seu_lourival/app/modules/billboard/page.dart';
import 'package:seu_lourival/app/modules/finance/page.dart';
import 'package:seu_lourival/app/modules/login/binding.dart';
import 'package:seu_lourival/app/modules/login/page.dart';
import 'package:seu_lourival/app/modules/login_error/page.dart';

import 'package:seu_lourival/app/modules/sms_validation/binding.dart';
import 'package:seu_lourival/app/modules/sms_validation/page.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users/binding.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users/page.dart';
import 'package:seu_lourival/app/modules/users_manager/binding.dart';
import 'package:seu_lourival/app/modules/users_manager/page.dart';
import 'package:seu_lourival/routes/routes.dart';

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
      name: Routes.newReport,
      page: () => NewReportPage(),
      binding: NewReportBinding(),
    ),
    GetPage(
      name: Routes.debug,
      page: () => DebugHomePage(),
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
      name: Routes.usersManager,
      page: () => const UsersManagerPage(),
      binding: UsersManagerBinding(),
    ),
    GetPage(
      name: Routes.addUsersForm,
      page: () => AddUsersPage(),
      binding: AddUsersBinding(),
    ),


    // Theme Catalog / Debug
    GetPage(
      name: Routes.themeCatalog,
      page: () => const ThemesCatalogPage(),
    ),
    GetPage(
      name: Routes.debug,
      page: () => const DebugHomePage(),
    ),
  ];
}
