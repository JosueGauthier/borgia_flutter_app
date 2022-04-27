// ignore_for_file: unused_import

import 'package:borgiaflutterapp/widget/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class SliderBottomSectionWidget extends StatelessWidget {
  final String titletext;

  const SliderBottomSectionWidget({Key? key, required this.titletext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: titletext,
          size: Dimensions.height30,
        ),
        /* SizedBox(
          height: Dimensions.height10,
        ), */
        /* Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => Icon(
                        Icons.star,
                        color: AppColors.mainColor,
                        size: 15,
                      )),
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: "4.5"),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: "1287"),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ), */
        /* Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(icon: Icons.circle, text: "Normal", iconcolor: Colors.amber),
            SizedBox(
              width: Dimensions.width20,
            ),
            IconAndTextWidget(icon: Icons.location_pin, text: "1.7 km", iconcolor: AppColors.mainColor),
            SizedBox(
              width: Dimensions.width20,
            ),
            IconAndTextWidget(icon: Icons.lock_clock, text: "16 min", iconcolor: Colors.pink),
          ],
        ), */
      ],
    );
  }
}
