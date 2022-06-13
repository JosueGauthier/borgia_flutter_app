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
  @override
  Widget build(BuildContext context) {
    Get.find<UserController>().getUserList(AppConstants.USERNAME);
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: GetBuilder<UserController>(builder: (userController) {
                      int compteur = 0;
                      return (userController.isLoaded)
                          ? Column(children: [
                              GestureDetector(
                                onTap: () {
                                  compteur += 1;

                                  if (compteur > 3) {
                                    Get.toNamed(RouteHelper.getneonPage());
                                  }
                                },
                                child: Stack(
                                  children: [
                                    ShaderMask(
                                      shaderCallback: (rect) {
                                        return const LinearGradient(
                                          begin: Alignment.center,
                                          end: Alignment.bottomCenter,
                                          colors: [Colors.white, Colors.transparent],
                                        ).createShader(Rect.fromLTRB(0, Dimensions.height20 * 7, rect.width, rect.height));
                                      },
                                      blendMode: BlendMode.dstIn,
                                      child: Image.asset(
                                        "assets/image/cloitre.png",
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
                                          decoration: const BoxDecoration(),
                                          padding: EdgeInsets.only(top: Dimensions.height30 * 1.3, left: Dimensions.width20 * 1.5, right: Dimensions.width20),
                                          child: Center(
                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                              (AppConstants.isfinishedRotate == false)
                                                  ? DefaultTextStyle(
                                                      style: TextStyle(
                                                          fontSize: Dimensions.height45 * 0.8,
                                                          fontFamily: 'Montserrat-Bold',
                                                          letterSpacing: 2,
                                                          color: AppColors.white),
                                                      child: AnimatedTextKit(
                                                        animatedTexts: [
                                                          RotateAnimatedText('', duration: const Duration(milliseconds: 300)),
                                                          RotateAnimatedText('Bonjour,'),
                                                          RotateAnimatedText(userController.welcomeUserModel.surname!, rotateOut: false),
                                                        ],
                                                        isRepeatingAnimation: false,
                                                        onFinished: () {
                                                          AppConstants.isfinishedRotate = true;
                                                          setState(() {});
                                                        },
                                                      ),
                                                    )
                                                  : Text(
                                                      userController.welcomeUserModel.surname!,
                                                      style: TextStyle(
                                                          fontSize: Dimensions.height45 * 0.8,
                                                          fontFamily: 'Montserrat-Bold',
                                                          letterSpacing: 2,
                                                          color: AppColors.white),
                                                    ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(RouteHelper.getCartPage());
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(top: Dimensions.height10),
                                                      width: Dimensions.height45 * 1.2,
                                                      height: Dimensions.height45 * 1.2,
                                                      child: Icon(
                                                        Icons.history_rounded,
                                                        color: AppColors.white,
                                                        size: Dimensions.height20 * 1.5,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(RouteHelper.getProfilepage());
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(top: Dimensions.height10),
                                                      width: Dimensions.height45 * 1.2,
                                                      height: Dimensions.height45 * 1.2,
                                                      child: Icon(
                                                        Icons.settings_sharp,
                                                        color: AppColors.white,
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
                                              decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.9), borderRadius: const BorderRadius.only(topRight: Radius.circular(50))),
                                            ),
                                            Positioned(
                                              top: Dimensions.height10 * 2,
                                              left: Dimensions.height10 * 2 * 1.5,
                                              child: Text(
                                                "Solde:",
                                                style: TextStyle(
                                                    fontSize: Dimensions.height45 * 0.4,
                                                    fontFamily: 'Montserrat-Bold',
                                                    letterSpacing: 2,
                                                    color: AppColors.titleColor),
                                              ),
                                            ),
                                            Center(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: Dimensions.height20 * 1.8),
                                                  Text(
                                                    userController.userList[0].balance + "€",
                                                    style: TextStyle(
                                                        fontSize: Dimensions.height45 * 1.3,
                                                        fontFamily: 'OpenSansExtraBold',
                                                        letterSpacing: 2,
                                                        color: AppColors.titleColor),
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
                                          height: Dimensions.height100 * 4,
                                        ),
                                        //! Showing the body
                                        const WelcomePage(),
                                        SizedBox(
                                          height: Dimensions.height100 * 0.5,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ])
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
