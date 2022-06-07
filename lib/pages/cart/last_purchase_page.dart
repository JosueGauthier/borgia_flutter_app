import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/cart_controller.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/product_item_widget.dart';

class LastPurchases extends StatelessWidget {
  const LastPurchases({
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
      size: Dimensions.height30 * 0.6,
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
            List cartList = cartController.getItems;

            cartList.sort((b, a) => (a.time).compareTo(b.time));

            return Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: cartList.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getProductList(cartList[index].aProduct.categoryWhereProductIs!,
                              cartList[index].aProduct.moduleIdWhereProductIs!, cartList[index].aProduct.shop!, "favPage"));
                        },
                        child: Container(
                          width: double.maxFinite,
                          //color: Colors.green,
                          margin: EdgeInsets.only(left: Dimensions.width20),
                          child: ProductItemWidget(
                            illustImage: NetworkImage(cartList[index].aProduct.image!),
                            titleText: cartList[index].name!,
                            priceProduct: cartList[index].aProduct.manualPrice.toString(),
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
