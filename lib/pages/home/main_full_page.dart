import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';
import 'welcome_page.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
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
              margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              child: Container(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(
                    children: [
                      BigText(
                        text: "France",
                        color: AppColors.mainColor,
                      ),
                      Row(
                        children: [SmallText(text: "Lyon"), Icon(Icons.arrow_drop_down_rounded)],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.width15), color: AppColors.mainColor),
                    ),
                  )
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
