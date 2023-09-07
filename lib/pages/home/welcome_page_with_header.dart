import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'welcome_page.dart';

class WelcomePageWithHeader extends StatefulWidget {
  const WelcomePageWithHeader({Key? key}) : super(key: key);

  @override
  State<WelcomePageWithHeader> createState() => _WelcomePageWithHeaderState();
}

class _WelcomePageWithHeaderState extends State<WelcomePageWithHeader> {
  bool isLight = false;
  String backImageNight = "assets/image/cloitreNuit.png";
  String backImageDay = "assets/image/cloitre.png";

  @override
  Widget build(BuildContext context) {
    Get.find<UserController>().getUserList(AppConstants.USERNAME);
    return Scaffold(
        extendBody: true,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: GetBuilder<UserController>(builder: (userController) {
                      int compteur = 0;

                      bool isLightTheme = false;
                      if (Theme.of(context).scaffoldBackgroundColor == Theme.of(context).colorScheme.surface) {
                        isLightTheme = true;
                      }
                      return (userController.isLoaded)
                          ? GestureDetector(
                              onTap: () {
                                compteur += 1;

                                if (compteur > 73) {
                                  Get.toNamed(RouteHelper.getNeonPage());
                                }
                              },
                              child: Stack(
                                children: [
                                  ShaderMask(
                                    shaderCallback: (rect) {
                                      return LinearGradient(
                                        begin: Alignment.center,
                                        end: Alignment.bottomCenter,
                                        colors: [Theme.of(context).colorScheme.surface, Colors.transparent],
                                      ).createShader(Rect.fromLTRB(0, Dimensions.height20 * 9, rect.width, rect.height));
                                    },
                                    blendMode: BlendMode.dstIn,
                                    child: (isLightTheme == false)
                                        ? Image.asset(
                                            backImageNight,
                                            fit: BoxFit.contain,
                                          )
                                        : Image.asset(
                                            backImageDay,
                                            fit: BoxFit.contain,
                                          ),
                                  ),

                                  //! Showing the header
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: Dimensions.height45 * 2.7,
                                        width: double.maxFinite,
                                        padding: EdgeInsets.only(top: Dimensions.height30 * 1.3, left: Dimensions.width20 * 1.5, right: Dimensions.width20),
                                        child: Center(
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                            (AppConstants.bienvenueUsernameisfinishedRotate == false)
                                                ? DefaultTextStyle(
                                                    style: Theme.of(context).textTheme.bodyLarge!,
                                                    child: AnimatedTextKit(
                                                      animatedTexts: [
                                                        RotateAnimatedText('', duration: const Duration(milliseconds: 300)),
                                                        RotateAnimatedText('Bonjour,'),
                                                        RotateAnimatedText(userController.userModelController.surname!, rotateOut: false),
                                                      ],
                                                      isRepeatingAnimation: false,
                                                      onFinished: () {
                                                        AppConstants.bienvenueUsernameisfinishedRotate = true;
                                                        setState(() {});
                                                      },
                                                    ),
                                                  )
                                                : Text(userController.userModelController.surname!, style: Theme.of(context).textTheme.bodyLarge),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    AppConstants.bienvenueUsernameisfinishedRotate = true;
                                                    Get.toNamed(RouteHelper.getCartPage());
                                                  },
                                                  child: SizedBox(
                                                    width: Dimensions.height45 * 1.2,
                                                    height: Dimensions.height10 * 3,
                                                    child: Icon(
                                                      Icons.history_rounded,
                                                      color: Theme.of(context).colorScheme.surface,
                                                      size: Dimensions.height20 * 1.5,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    AppConstants.bienvenueUsernameisfinishedRotate = true;
                                                    Get.toNamed(RouteHelper.getProfilepage());
                                                  },
                                                  child: SizedBox(
                                                    width: Dimensions.height45 * 1.2,
                                                    height: Dimensions.height45 * 1.2,
                                                    child: Icon(
                                                      Icons.settings_sharp,
                                                      color: Theme.of(context).colorScheme.surface,
                                                      size: Dimensions.height20 * 1.5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10 * 17,
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            height: Dimensions.height20 * 10,
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: const BorderRadius.only(topRight: Radius.circular(50))),
                                          ),
                                          Positioned(
                                            top: Dimensions.height10 * 2,
                                            left: Dimensions.height10,
                                            child: Text(
                                              "Solde:",
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              children: [
                                                SizedBox(height: Dimensions.height20 * 1.8),
                                                Text(
                                                  userController.userList[0].balance + "€",
                                                  style: Theme.of(context).textTheme.titleLarge,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Column(
                                    children: [
                                      SizedBox(
                                        height: Dimensions.height100 * 4.2,
                                      ),
                                      //! Showing the body
                                      const WelcomePage(),
                                      SizedBox(
                                        height: Dimensions.height100 * 0.5,
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    right: Dimensions.width20 * 2.4,
                                    top: Dimensions.height20 * 8.2,
                                    child: GestureDetector(
                                      onDoubleTap: () {
                                        setState(() {
                                          //isLight = true;
                                          backImageDay = "assets/image/promss220.jpg";
                                          backImageNight = "assets/image/promss220.jpg";
                                        });
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        height: Dimensions.height15 * 2,
                                        width: Dimensions.width10 * 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 4,
                                color: AppColors.mainColor,
                              ),
                            );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
