import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:borgiaflutterapp/pages/home/home_page.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:borgiaflutterapp/widget/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sa3_liquid/liquid/plasma/plasma.dart';

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
  //bool isfinished = false;
  @override
  Widget build(BuildContext context) {
    //print("height" + MediaQuery.of(context).size.height.toString());
    //print("width" + MediaQuery.of(context).size.width.toString());
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: GetBuilder<UserController>(builder: (userController) {
                  return (userController.isLoaded)
                      ? Column(children: [
                          Stack(
                            children: [
                              ShaderMask(
                                shaderCallback: (rect) {
                                  return LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.black, Colors.transparent],
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
                                    decoration: BoxDecoration(
                                        //* without gradient

                                        //color: Colors.greenAccent.withOpacity(1),
                                        ),
                                    padding: EdgeInsets.only(top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
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
                                                    RotateAnimatedText('', duration: Duration(milliseconds: 200)),
                                                    RotateAnimatedText('Bonjour'),
                                                    RotateAnimatedText(userController.welcomeUserModel.surname!),
                                                    RotateAnimatedText('Boquette', rotateOut: false, duration: Duration(seconds: 2)),
                                                  ],
                                                  isRepeatingAnimation: false,
                                                  onFinished: () {
                                                    //print("aaaaa");
                                                    AppConstants.isfinishedRotate = true;
                                                    //isfinished = true;
                                                    setState(() {});
                                                  },
                                                ),
                                              )
                                            : Text(
                                                "Boquette",
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
                                                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.width15), color: AppColors.titleColor),
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
                                                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.width15), color: AppColors.titleColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10 * 14,
                                  ),
                                  GestureDetector(
                                    /* onTap: () {
                                      Get.toNamed(RouteHelper.getLydiaPage());
                                    }, */
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: Dimensions.height30 * 3,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.width20),
                                            color: AppColors.white.withOpacity(0.65),
                                            backgroundBlendMode: BlendMode.srcOver,
                                          ),
                                        ),
                                        Positioned(
                                          top: Dimensions.height10 * 1.5,
                                          left: Dimensions.height10 * 2,
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
                                          //heightFactor: 10,
                                          child: Column(
                                            children: [
                                              SizedBox(height: Dimensions.height20 * 1.1),
                                              Text(
                                                userController.userList[0].balance + "€",
                                                style: TextStyle(
                                                    fontSize: Dimensions.height45 * 1.3,
                                                    fontFamily: 'OpenSansExtraBold',
                                                    letterSpacing: 2,
                                                    color: AppColors.titleColor),

                                                //Color.fromARGB(200, 1, 152, 117)
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  SizedBox(
                                    height: Dimensions.height100 * 3.7,
                                  ),
                                  //! Showing the body
                                  WelcomePage(),
                                  SizedBox(
                                    height: Dimensions.height100 * 0.5,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ])
                      : Center(child: CircularProgressIndicator());
                }),
              ),
            ),
          ],
        ));
  }
}
