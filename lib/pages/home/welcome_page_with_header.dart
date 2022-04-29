import 'package:flutter/material.dart';

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
    //print("height" + MediaQuery.of(context).size.height.toString());
    //print("width" + MediaQuery.of(context).size.width.toString());
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            //! Showing the header
            Container(
              height: Dimensions.height45 * 2.5,
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.height20),
                    bottomRight: Radius.circular(Dimensions.height20),
                  )),
              margin: EdgeInsets.only(bottom: Dimensions.height15),
              padding: EdgeInsets.only(bottom: Dimensions.height15, top: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/image/logoAMAngers.jpg"),
                    ),
                    Positioned(
                        bottom: -15,
                        right: -10,
                        child: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: AppColors.secondColor,
                          size: Dimensions.height30 * 1.5,
                        ))
                  ],
                ),
                Text(
                  "Boquette",
                  style: TextStyle(fontSize: Dimensions.height45 * 1.2, fontFamily: 'AnglicanText', letterSpacing: 2, color: Colors.white),
                ),
                /* BigText(
                  text: "Boquette",
                  color: Colors.white,
                ), */
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height10),
                  width: Dimensions.height45,
                  height: Dimensions.height45,
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.width15), color: AppColors.mainColor),
                ),
              ]),
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
