import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late Animation<double> animation;

  late AnimationController animationController;

  Future<void> _loadRessources() async {
    //await Get.find<PopularProductController>().getPopularProductList();
    //await Get.find<RecommendedProductController>().getRecomendedProductList();
  }

  @override
  void initState() {
    super.initState();

    _loadRessources();

    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();

    animation = CurvedAnimation(parent: animationController, curve: Curves.bounceOut); //bounceOut

    Timer(const Duration(seconds: 3), (() => Get.offNamed(RouteHelper.getLoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ScaleTransition(
          scale: animation,
          child: Center(
            child: Image.asset(
              "assets/image/logoborgia.png",
              width: Dimensions.width20 * 5,
            ),
          ),
        ),
        ScaleTransition(
          scale: animation,
          child: Center(
            child: Image.asset(
              "assets/image/textlogoBorgia.png",
              width: Dimensions.width20 * 7,
            ),
          ),
        )
      ]),
    );
  }
}
