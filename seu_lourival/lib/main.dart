import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seu_lourival/routes/pages.dart';
import 'package:seu_lourival/routes/routes.dart';

import 'firebase_options.dart';

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
    bool isDebugMode = false;
    return GetMaterialApp(
      title: 'Seu Lourival',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: isDebugMode ? Routes.login : Routes.debug,
      initialBinding: InitialBinding(),
      getPages: Pages.pages,
    );
  }
}

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
  }
}
