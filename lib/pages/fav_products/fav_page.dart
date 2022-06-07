import 'dart:developer';

import 'package:borgiaflutterapp/widget/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';

class FavPage extends StatelessWidget {
  const FavPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          height: Dimensions.height45 * 2.7,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Dimensions.height20),
                bottomRight: Radius.circular(Dimensions.height20),
              )),
          padding: EdgeInsets.only(top: Dimensions.height30 * 1.3, left: Dimensions.width20 * 2, right: Dimensions.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BigText(
                fontTypo: 'Montserrat-Bold',
                text: "Produits favoris",
                size: Dimensions.height10 * 3,
                color: AppColors.titleColor,
              ),
            ],
          ),
        ),
        GetBuilder<CartController>(
          builder: (cartController) {
            List favList = cartController.getItems;

            inspect(favList);

            favList.sort((b, a) => (a.quantity).compareTo(b.quantity));

            //inspect(_cartList);

            return Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: favList.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getProductList(favList[index].aProduct.categoryWhereProductIs!,
                              favList[index].aProduct.moduleIdWhereProductIs!, favList[index].aProduct.shop!, "favPage"));
                        },
                        child: Container(
                          width: double.maxFinite,
                          //color: Colors.green,
                          margin: EdgeInsets.only(left: Dimensions.width20),
                          child: ProductItemWidget(
                            illustImage: NetworkImage(favList[index].aProduct.image),
                            titleText: favList[index].name!,
                            priceProduct: favList[index].aProduct.manualPrice.toString(),
                          ),
                        ),
                      );
                    })));
          },
        )
      ]),
    );
  }
}
