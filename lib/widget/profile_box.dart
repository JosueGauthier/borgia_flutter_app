import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:flutter/material.dart';

import 'big_text.dart';

class ProfileBox extends StatelessWidget {
  final IconData icon;
  final Color backgroundcolor;
  final String text;
  final Color iconcolor;
  final Color textColor;
  final bool isEditable;
  final double radius;

  const ProfileBox(
      {Key? key,
      required this.icon,
      required this.textColor,
      required this.backgroundcolor,
      required this.text,
      required this.iconcolor,
      this.isEditable = true,
      this.radius = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
      margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
      height: Dimensions.height45 * 1.7,
      width: double.maxFinite,
      decoration: BoxDecoration(color: backgroundcolor, borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconcolor,
              ),
              SizedBox(
                width: Dimensions.width20,
              ),
              BigText(
                fontTypo: 'Helvetica-Bold',
                text: text,
                size: Dimensions.height25 * 0.8,
                color: textColor,
              ),
            ],
          ),
          isEditable == true
              ? const Icon(
                  Icons.edit,
                  color: AppColors.titleColor,
                )
              : Container(),
        ],
      ),
    );
  }
}
