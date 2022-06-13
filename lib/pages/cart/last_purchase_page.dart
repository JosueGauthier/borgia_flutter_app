import 'package:borgiaflutterapp/widget/custom_header.dart';
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
        const CustomHeader(text: "Derniers achats"),
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
                          Get.toNamed(RouteHelper.getProductList(cartList[index].aProduct.idParentCategory!, cartList[index].aProduct.moduleIdParentCategory!,
                              cartList[index].aProduct.shop!, "favPage"));
                        },
                        child: Container(
                          width: double.maxFinite,
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
