import 'package:borgiaflutterapp/widget/small_text.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';

class ProductItemWidget extends StatelessWidget {
  final NetworkImage illustImage;
  final String titleText;
  final String priceProduct;

  const ProductItemWidget({Key? key, required this.illustImage, required this.priceProduct, required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10, bottom: Dimensions.height10),
      child: Row(children: [
        //! image section

        Container(
          margin: EdgeInsets.only(bottom: Dimensions.height10),
          height: Dimensions.height100 * 0.6,
          width: Dimensions.height100 * 0.6,
          decoration: BoxDecoration(
            //color: Colors.amber,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: illustImage,
            ),
          ),
        ),

        SizedBox(
          width: Dimensions.width20 * 1,
        ),

        //! text section

        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: Dimensions.width10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: SmallText(
                    fontTypo: 'Helvetica-Bold',
                    text: titleText,
                    size: Dimensions.height25 * 0.8,
                    color: AppColors.titleColor,
                    allowOverFlow: true,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                BigText(
                  fontTypo: 'Montserrat-Bold',
                  size: Dimensions.height20 * 1.2,
                  text: priceProduct + " €",
                  color: AppColors.secondColor,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
