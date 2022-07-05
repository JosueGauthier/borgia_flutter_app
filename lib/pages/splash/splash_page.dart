import 'dart:async';

import 'package:borgiaflutterapp/controllers/auth_controller.dart';
import 'package:borgiaflutterapp/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late Animation<double> animation;

  late AnimationController animationController;

  Future<void> _loadRessources() async {}

  bool indentifiersProvided = false;

  getIdentifiersSharedpref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List? list = prefs.getStringList(AppConstants.IDENTIFIERS_LIST);
    final AuthController authController;

    Get.find<AuthController>();

    authController = Get.find<AuthController>();

    if (list == null) {
    } else {
      authController.login(list[0], list[1]).then((status) {
        if (status.isSuccess) {
          AppConstants.USERNAME = list[0];
          AppConstants.PASSWORD = list[1];
          AppConstants.isfinishedRotate = false;
          Get.find<UserController>().getUserList(AppConstants.USERNAME);

          indentifiersProvided = true;
        } else {}
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _loadRessources();

    getIdentifiersSharedpref();

    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();

    animation = CurvedAnimation(parent: animationController, curve: Curves.bounceOut); //bounceOut

    Timer(
        const Duration(seconds: 3), (() => (indentifiersProvided == true) ? Get.toNamed(RouteHelper.getInitial()) : Get.offNamed(RouteHelper.getLoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ScaleTransition(
          scale: animation,
          child: Center(
            child: Image.asset(
              "assets/image/logoImage.png",
              width: Dimensions.width20 * 5,
            ),
          ),
        ),
        ScaleTransition(
          scale: animation,
          child: Center(
            child: Image.asset(
              "assets/image/logoText.png",
              width: Dimensions.width20 * 7,
            ),
          ),
        )
      ]),
    );
  }
}
