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
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.surfaceTintColor,
            borderRadius: BorderRadius.all(Radius.circular(Dimensions.width20)),
          ),
          margin: EdgeInsets.only(bottom: Dimensions.height15, left: Dimensions.width20),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
            //! image section

            //! text section

            Container(
              height: Dimensions.height100 * 0.7,
              width: Dimensions.width10 * 20,
              margin: EdgeInsets.only(left: Dimensions.height10 * 6),
              alignment: Alignment.centerLeft,
              child: Text(
                titleText,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),

            Container(
              margin: EdgeInsets.only(right: Dimensions.width10),
              child: Text(
                "$priceProduct€",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.mainColor),
              ),
            ),
          ]),
        ),

        //! image section

        Container(
          height: Dimensions.height100 * 0.7,
          width: Dimensions.height100 * 0.7,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: SizedBox(height: Dimensions.height100 * 0.5, width: Dimensions.height100 * 0.5, child: illustImage),
        ),
      ],
    );
  }
}
