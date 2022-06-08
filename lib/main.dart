import 'package:borgiaflutterapp/routes/route_helper.dart';
import 'package:borgiaflutterapp/theme/theme.dart';
import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
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
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.system,
      // theme: ThemeClass.lightTheme,
      // darkTheme: ThemeClass.darkTheme,
      defaultTransition: Transition.fadeIn,
      title: 'Flutter Demo',
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,
    );
  }
}
