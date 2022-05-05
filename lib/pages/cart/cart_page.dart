import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/cart_controller.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  Widget timeWidget(int index, int listlength, var indexTime) {
    var outputData = DateTime.now().toString();

    if (index < listlength) {
      DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(indexTime!);
      var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");
      outputData = outputFormat.format(parseDate);
    }
    return BigText(
      text: outputData,
      color: AppColors.greyColor,
      size: Dimensions.height30 / 1.3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: Dimensions.height45 * 2.7,
          decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Dimensions.height20),
                bottomRight: Radius.circular(Dimensions.height20),
              )),
          margin: EdgeInsets.only(bottom: Dimensions.height10),
          padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BigText(
                text: "Derniers achats",
                size: Dimensions.height10 * 3,
                color: Colors.white,
              ),
            ],
          ),
        ),
        GetBuilder<CartController>(
          builder: (cartController) {
            var _cartList = cartController.getItems;

            return Expanded(
                child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
              child: ListView.builder(
                  itemCount: _cartList.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      width: double.maxFinite,
                      height: Dimensions.height20 * 8,
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: Dimensions.height20),
                      child: Card(
                        elevation: 2,
                        shadowColor: AppColors.secondColor,
                        color: Colors.white,
                        child: Row(
                          children: [
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
                              width: Dimensions.width10,
                            ),
                            //? an expanded widget take all space of the parent
                            Expanded(
                                child: SizedBox(
                              //color: Colors.redAccent,
                              height: double.maxFinite,
                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                BigText(
                                  text: _cartList[index].name!,
                                  color: AppColors.darkGreyColor,
                                  size: Dimensions.height30,
                                ),
                                timeWidget(index, _cartList.length, _cartList[index].time!),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                      text: _cartList[index].price.toString() + " €",
                                      color: AppColors.mainColor,
                                      size: Dimensions.height30,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.radius20)),
                                    ),
                                  ],
                                )
                              ]),
                            )),
                          ],
                        ),
                      ),
                    );
                  })),
            ));
          },
        )
      ]),
    );
  }
}
