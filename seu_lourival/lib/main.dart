import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:seu_lourival/core/values/colors.dart';
import 'package:seu_lourival/firebase_options.dart';
import 'package:seu_lourival/routes/pages.dart';
import 'package:seu_lourival/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Seu Lourival',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primaryColor: DSColors.primary,
      ),
      initialRoute: Routes.debug,
      // initialRoute: isDebugMode ? Routes.login : Routes.debug,
      // initialBinding: InitialBinding(),
      getPages: Pages.pages,
    );
  }
}
