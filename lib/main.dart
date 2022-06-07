// ignore_for_file: unused_import

import 'package:borgiaflutterapp/controllers/product_controller.dart';
import 'package:borgiaflutterapp/routes/route_helper.dart';
import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/cart_controller.dart';
import 'controllers/shop_controller.dart';
import 'helper/dependencies.dart' as dep;

import '../../utils/app_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());

  //SharedPreferences preferences = await SharedPreferences.getInstance();
  //await preferences.clear();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //! permet de retirer le contenu sauvegarder localement sur le telephone

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.mainColor,
          selectionColor: AppColors.bluePastelColor,
          selectionHandleColor: AppColors.bluePastelColor,
        ),
      ),

      defaultTransition: Transition.fadeIn,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      //home: SplashScreen(),
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,
    );
  }
}
