import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';

class CustomHeader extends StatelessWidget {
  final String text;
  const CustomHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height45 * 2.7,
      margin: EdgeInsets.only(bottom: Dimensions.height10),
      padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SizedBox(
                    width: Dimensions.width15 * 4,
                    height: Dimensions.width15 * 4,
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.titleColor,
                    ),
                  )),
            ],
          ),
          Container(
            padding: EdgeInsets.only(right: Dimensions.width20),
            child: BigText(
              fontTypo: 'Montserrat-Bold',
              text: text,
              size: Dimensions.height10 * 3,
              color: AppColors.titleColor,
            ),
          ),
        ],
      ),
    );
  }
}
