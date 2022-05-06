import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/cart_controller.dart';

import '../../routes/route_helper.dart';
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
      size: Dimensions.height30 * 0.8,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          height: Dimensions.height45 * 2.7,
          decoration: BoxDecoration(
              //color: Colors.green,
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimensions.height20),
            bottomRight: Radius.circular(Dimensions.height20),
          )),
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
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: Container(
                        width: Dimensions.width15 * 4,
                        height: Dimensions.width15 * 4,
                        child: Icon(
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
                  text: "Derniers achats",
                  size: Dimensions.height10 * 3,
                  color: AppColors.titleColor,
                ),
              ),
            ],
          ),
        ),
        GetBuilder<CartController>(
          builder: (cartController) {
            var _cartList = cartController.getItems;

            return Expanded(
                child: Container(
              //color: Colors.redAccent,
              width: double.maxFinite,
              margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
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
                                    //color: Colors.green,
                                    borderRadius: BorderRadius.circular(Dimensions.radius20)),
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width20,
                            ),
                            //? an expanded widget take all space of the parent
                            Expanded(
                                child: Container(
                              //color: Colors.redAccent,
                              height: Dimensions.width20 * 5,
                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                BigText(
                                  text: _cartList[index].name!,
                                  color: AppColors.darkGreyColor,
                                  size: Dimensions.height30 * 0.8,
                                ),
                                timeWidget(index, _cartList.length, _cartList[index].time!),
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
                  })),
            ));
          },
        )
      ]),
    );
  }
}
