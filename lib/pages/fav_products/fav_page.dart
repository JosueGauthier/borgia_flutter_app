import 'package:borgiaflutterapp/widget/productItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
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
          margin: EdgeInsets.only(bottom: Dimensions.height10),
          padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20 * 2, right: Dimensions.width20),
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
            var _cartList = cartController.getItems;

            return Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _cartList.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        width: double.maxFinite,
                        height: Dimensions.width20 * 5,
                        color: Colors.white,
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        child: ProductItemWidget(
                          illustImage: NetworkImage(_cartList[index].img!),
                          titleText: _cartList[index].name!,
                          priceProduct: _cartList[index].price.toString(),
                        ),
                      );
                    })));
          },
        )
      ]),
    );
  }
}
