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
              height: Dimensions.height45 * 2.7,
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.height20),
                    bottomRight: Radius.circular(Dimensions.height20),
                  )),
              margin: EdgeInsets.only(bottom: Dimensions.height10),
              padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
              child: Center(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/image/logoAMAngers.jpg"),
                      ),
                      DropdownButton<String>(
                        items: <String>['A', 'B', 'C', 'D'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
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
