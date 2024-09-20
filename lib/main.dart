import 'package:app_clone/src/core/app_config.dart';
import 'package:app_clone/src/core/my_app.dart';
import 'package:app_clone/src/core/routes.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppConfig(
    appName: "appClone",
    debugTag: true,
    //flavorName: "dev",
    initialRoute: AppRouter.HOME,
    child: MyApp.runWidget(),
  ));
}
