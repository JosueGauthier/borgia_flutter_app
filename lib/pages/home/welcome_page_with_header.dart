import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
            //! Showing the header
            Container(
              height: Dimensions.height45 * 2.7,
              decoration: BoxDecoration(
                //* without gradient

                color: Colors.white.withOpacity(0.1),

                //color: Colors.white,
                /* borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.height20),
                    bottomRight: Radius.circular(Dimensions.height20),
                  ), */

                /* gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerLeft,
                  stops: [
                    0.1,
                    0.6,
                  ],
                  colors: [AppColors.mainColor, Colors.white],
                ), */
              ),
              margin: EdgeInsets.only(bottom: Dimensions.height10 / 10),
              padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
              child: Center(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  (AppConstants.isfinishedRotate == false)
                      ? DefaultTextStyle(
                          style: TextStyle(fontSize: Dimensions.height45 * 0.8, fontFamily: 'Montserrat-Bold', letterSpacing: 2, color: AppColors.titleColor),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              RotateAnimatedText('', duration: Duration(milliseconds: 500)),
                              RotateAnimatedText('Bonjour'),
                              RotateAnimatedText('Josué', duration: Duration(seconds: 4)),
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
                          style: TextStyle(fontSize: Dimensions.height45 * 0.8, fontFamily: 'Montserrat-Bold', letterSpacing: 2, color: AppColors.titleColor),
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
                            color: AppColors.titleColor,
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
                            color: AppColors.titleColor,
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

            //! Showing the body

            Expanded(
                child: SingleChildScrollView(
              child: WelcomePage(),
            )),
          ],
        ));
  }
}
