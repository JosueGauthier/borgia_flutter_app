import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:borgiaflutterapp/widget/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ProfileBox extends StatelessWidget {
  final IconData icon;
  final Color backgroundcolor;
  final String text;
  final Color iconcolor;
  final Color textColor;
  final bool isEditable;

  ProfileBox(
      {Key? key,
      required this.icon,
      required this.textColor,
      required this.backgroundcolor,
      required this.text,
      required this.iconcolor,
      this.isEditable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
      margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
      height: Dimensions.height45 * 1.7,
      width: double.maxFinite,
      decoration: BoxDecoration(color: backgroundcolor, borderRadius: BorderRadius.all(Radius.circular(10))),
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
              SmallText(
                text: text,
                color: textColor,
                size: Dimensions.height20,
              ),
            ],
          ),
          isEditable == true
              ? Icon(
                  Icons.edit,
                  color: AppColors.darkgrey,
                )
              : Container(),
        ],
      ),
    );
  }
}
