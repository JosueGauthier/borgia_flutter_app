import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class ProductItemWidget extends StatelessWidget {
  final CachedNetworkImage illustImage;
  final String titleText;
  final String priceProduct;

  const ProductItemWidget({Key? key, required this.illustImage, required this.priceProduct, required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.height10),
      decoration: BoxDecoration(
        color: AppColors.cardDarkColor,
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.width20)),
        //border: Border.all(color: AppColors.borderDarkColor)
      ),
      //margin: EdgeInsets.only(right: Dimensions.width10),
      //height: Dimensions.height100 * 0.7,
      child: Row(children: [
        //! image section

        Container(
          height: Dimensions.height100 * 0.7,
          width: Dimensions.height100 * 0.7,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: SizedBox(
            height: Dimensions.height100 * 0.5,
            width: Dimensions.height100 * 0.5,
            child: illustImage,
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
                  child: Text(
                    titleText,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),

                  /* SmallText(
                    fontTypo: 'Helvetica-Bold',
                    text: titleText,
                    size: Dimensions.height25 * 0.8,
                    color: AppColors.titleColor,
                    allowOverFlow: true,
                    maxLines: 1,
                  ), */
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Text(
                  "$priceProduct €",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.mainColor),
                ),
                /* BigText(
                  fontTypo: 'Montserrat-Bold',
                  size: Dimensions.height20 * 1.2,
                  text: "$priceProduct €",
                  color: AppColors.secondColor,
                ), */
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
