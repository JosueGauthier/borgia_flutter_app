import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/no_data_page.dart';
import '../../controllers/cart_controller.dart';
import '../../models/cart_product_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/app_icon.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartitemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartorderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartitemsPerOrderToList();

    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputData = DateTime.now().toString();

      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var output_format = DateFormat("dd/MM/yyyy hh:mm a");
        outputData = output_format.format(parseDate);
      }
      return BigText(
        text: outputData,
        size: Dimensions.height30 / 1.2,
      );
    }

    return Scaffold(
      body: Column(
        children: [
          //! header
          Container(
            height: Dimensions.height100 * 1,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height10),
            color: AppColors.mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History",
                  size: Dimensions.height30,
                  color: Colors.white,
                ),
                AppIcon(iconData: Icons.shopping_bag, iconColor: AppColors.mainColor, backgroundColor: Colors.white),
              ],
            ),
          ),
          //! list
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            for (var i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                  //color: Colors.amber,
                                  height: Dimensions.height20 * 8,
                                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      timeWidget(listCounter),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                              direction: Axis.horizontal,
                                              children: List.generate(itemsPerOrder[i], (index) {
                                                if (listCounter < getCartHistoryList.length) {
                                                  listCounter++;
                                                }
                                                return index <= 2
                                                    ? Container(
                                                        height: Dimensions.height20 * 5,
                                                        width: Dimensions.height20 * 5,
                                                        margin: EdgeInsets.only(
                                                          right: Dimensions.width10 / 2,
                                                        ),
                                                        decoration: BoxDecoration(
                                                            //color: Colors.redAccent,
                                                            borderRadius: BorderRadius.circular(Dimensions.height10 / 1.5),
                                                            image: DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: NetworkImage(AppConstants.BASE_URL +
                                                                    AppConstants.UPLOAD_URL +
                                                                    getCartHistoryList[listCounter - 1].img!))),
                                                      )
                                                    : Container();
                                              })),
                                          Container(
                                            color: Colors.green,
                                            height: Dimensions.height20 * 5,
                                            child:
                                                Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.end, children: [
                                              SmallText(text: "Total", color: AppColors.titleColor),
                                              BigText(
                                                text: itemsPerOrder[i].toString() + " items",
                                                size: Dimensions.height20,
                                                color: AppColors.titleColor,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  var orderTime = cartorderTimeToList();
                                                  Map<int, CartModel> moreOrder = {};
                                                  for (var j = 0; j < getCartHistoryList.length; j++) {
                                                    //print(j);
                                                    if (getCartHistoryList[j].time == orderTime[i]) {
                                                      //print("order time is" + orderTime[i]);
                                                      moreOrder.putIfAbsent(getCartHistoryList[j].id!, () {
                                                        return CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])));
                                                      });
                                                    }
                                                  }
                                                  Get.find<CartController>().setItems = moreOrder;

                                                  Get.find<CartController>().addToCartList();

                                                  Get.toNamed(RouteHelper.getCartPage(1, "cart-history"));
                                                },
                                                child: Container(
                                                  child: SmallText(
                                                    text: "One more",
                                                    size: Dimensions.height20,
                                                    color: AppColors.mainColor,
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height20 / 4),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(width: 1, color: AppColors.mainColor),
                                                      borderRadius: BorderRadius.circular(Dimensions.height10 / 1.5)),
                                                ),
                                              )
                                            ]),
                                          )
                                        ],
                                      )
                                    ],
                                  ))
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: NoDataPage(
                      text: "Your history is empty",
                      impgPath: "assets/image/empty_box.png",
                    ),
                  );
          })
        ],
      ),
    );
  }
}
