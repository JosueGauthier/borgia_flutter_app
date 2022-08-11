import 'dart:async';

import 'package:borgiaflutterapp/controllers/auth_controller.dart';
import 'package:borgiaflutterapp/controllers/user_controller.dart';
import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
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
  bool isLoading = false;

  double opacity = 0;

  getIdentifiersSharedpref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List? identifiersList = prefs.getStringList(AppConstants.IDENTIFIERS_LIST);
    print(identifiersList);
    final AuthController authController;

    Get.find<AuthController>();
    authController = Get.find<AuthController>();

    if (identifiersList == null) {
      Get.toNamed(RouteHelper.getLoginPage());
    } else {
      await authController.login(identifiersList[0], identifiersList[1]).then((status) {
        if (status.isSuccess) {
          AppConstants.USERNAME = identifiersList[0];
          AppConstants.PASSWORD = identifiersList[1];
          AppConstants.isfinishedRotate = false;
          Get.find<UserController>().getUserList(AppConstants.USERNAME);

          Get.toNamed(RouteHelper.getInitial());
          indentifiersProvided = true;
        } else {
          Get.toNamed(RouteHelper.getLoginPage());
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _loadRessources();

    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();

    animation = CurvedAnimation(parent: animationController, curve: Curves.bounceOut);

    Timer(
        const Duration(seconds: 2),
        (() => setState(() {
              isLoading = true;
              opacity = 1;
            }))); //bounceOut

    getIdentifiersSharedpref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            ),
          ]),
          Positioned(
              bottom: Dimensions.height100 / 2,
              child: AnimatedOpacity(
                  // If the widget is visible, animate to 0.0 (invisible).
                  // If the widget is hidden, animate to 1.0 (fully visible).
                  opacity: opacity,
                  duration: const Duration(milliseconds: 500),
                  // The green box must be a child of the AnimatedOpacity widget.
                  child: Container(
                    height: Dimensions.height100,
                    width: Dimensions.width10 * 10,
                    child: LoadingIndicator(
                        indicatorType: Indicator.pacman,

                        /// Required, The loading type of the widget
                        colors: [AppColors.mainColor, Theme.of(context).colorScheme.surface, AppColors.greenEmerald],

                        /// Optional, The color collections
                        strokeWidth: 2,

                        /// Optional, The stroke of the line, only applicable to widget which contains line
                        backgroundColor: Colors.transparent,

                        /// Optional, Background of the widget
                        pathBackgroundColor: Colors.black

                        /// Optional, the stroke backgroundColor
                        ),
                  )))
        ],
      ),
    );
  }
}
