import 'dart:async';

import 'package:borgiaflutterapp/controllers/shop_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
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

    await Get.find<ShopController>().getShopList();
  }

  @override
  void initState() {
    super.initState();

    _loadRessources();

    animationController = new AnimationController(vsync: this, duration: Duration(seconds: 2))..forward();

    /*

          ? method 1
          ? animationController = new AnimationController(vsync: this, duration: Duration(seconds: 4))             
          ? animationController = animationController.forward();

          * method 2
          * animationController = new AnimationController(vsync: this, duration: Duration(seconds: 4))..forward();             

          
    */

    animation = new CurvedAnimation(parent: animationController, curve: Curves.bounceOut); //bounceOut

    Timer(Duration(seconds: 3), (() => Get.offNamed(RouteHelper.getInitial())));
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
