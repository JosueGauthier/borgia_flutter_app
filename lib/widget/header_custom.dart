import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/route_helper.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';

class HeaderCustom extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isIcon;
  final String route;

  HeaderCustom({
    Key? key,
    this.icon = Icons.abc,
    required this.text,
    required this.isIcon,
    this.route = "getInitial",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height45 * 2.7,
      decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimensions.height20),
            bottomRight: Radius.circular(Dimensions.height20),
          )),
      margin: EdgeInsets.only(bottom: Dimensions.height10),
      padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
              onTap: () {
                //Get.toNamed(RouteHelper.route)
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.titleColor,
              )),
          BigText(
            text: text,
            size: Dimensions.height10 * 3,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
