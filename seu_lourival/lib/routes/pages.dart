import 'package:get/route_manager.dart';

import 'package:seu_lourival/_debug/page.dart';
import 'package:seu_lourival/app/modules/billboard/binding.dart';
import 'package:seu_lourival/app/modules/login/binding.dart';
import 'package:seu_lourival/app/modules/login/page.dart';
import 'package:seu_lourival/app/modules/maintenance/binding.dart';
import 'package:seu_lourival/app/modules/maintenance/page.dart';
import 'package:seu_lourival/app/modules/onboarding/binding.dart';
import 'package:seu_lourival/app/modules/onboarding/page.dart';
import 'package:seu_lourival/app/modules/report/new_report/binding.dart';
import 'package:seu_lourival/app/modules/report/new_report/page.dart';

import 'package:seu_lourival/_debug/DS_catalog/page.dart';
import 'package:seu_lourival/app/modules/billboard/page.dart';
import 'package:seu_lourival/app/modules/finance/page.dart';
import 'package:seu_lourival/app/modules/login_error/page.dart';
import 'package:seu_lourival/app/modules/report/report_detail/binding.dart';
import 'package:seu_lourival/app/modules/report/report_detail/page.dart';
import 'package:seu_lourival/app/modules/report/report_list/binding.dart';
import 'package:seu_lourival/app/modules/report/report_list/page.dart';

import 'package:seu_lourival/app/modules/sms_validation/binding.dart';
import 'package:seu_lourival/app/modules/sms_validation/page.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users_form/binding.dart';
import 'package:seu_lourival/app/modules/users_manager/add_users_form/page.dart';
import 'package:seu_lourival/app/modules/users_manager/binding.dart';
import 'package:seu_lourival/app/modules/users_manager/page.dart';
import 'package:seu_lourival/app/modules/visitors/page.dart';
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
      name: Routes.reportList,
      page: () => ReportListPage(),
      binding: ReportListBinding(),
    ),
    GetPage(
      name: Routes.newReport,
      page: () => NewReportPage(),
      binding: NewReportBinding(),
    ),
    GetPage(
      name: Routes.reportDetail,
      page: () => ReportDetailPage(),
      binding: ReportDetailBinding(),
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
      name: Routes.financial,
      page: () => const FinancePage(),
    ),
    GetPage(
      name: Routes.visitors,
      page: () => const VisitorsPage(),
    ),
    GetPage(
      name: Routes.usersManager,
      page: () => const UsersManagerPage(),
      binding: UsersManagerBinding(),
    ),
    GetPage(
      name: Routes.addUsersForm,
      page: () => AddUsersFormPage(),
      binding: AddUsersFormBinding(),
    ),
    GetPage(
      name: Routes.maintenance,
      page: () => MaintenancePage(),
      binding: MaintenanceBinding(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.billboard,
      page: () => BillboardPage(),
      binding: BillboardBinding(),
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
