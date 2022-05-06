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
          padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
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
                        margin: EdgeInsets.only(bottom: Dimensions.height20),
                        child: Card(
                          elevation: 0,
                          shadowColor: AppColors.secondColor,
                          //color: Colors.blue,
                          child: Row(
                            children: [
                              SizedBox(
                                width: Dimensions.width20,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: Dimensions.width20 * 5,
                                  height: Dimensions.width20 * 5,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(fit: BoxFit.contain, image: NetworkImage(_cartList[index].img!)),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(Dimensions.radius20)),
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.width20,
                              ),
                              //? an expanded widget take all space of the parent
                              Expanded(
                                  child: SizedBox(
                                //color: Colors.redAccent,
                                height: Dimensions.width20 * 5,
                                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  BigText(
                                    text: _cartList[index].name!,
                                    color: AppColors.darkGreyColor,
                                    size: Dimensions.height30 * 0.8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                        text: _cartList[index].price.toString() + " €",
                                        color: AppColors.mainColor,
                                        size: Dimensions.height30 * 0.8,
                                      ),
                                    ],
                                  )
                                ]),
                              )),
                            ],
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
