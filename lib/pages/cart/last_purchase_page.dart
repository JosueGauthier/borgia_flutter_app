import 'package:borgiaflutterapp/widget/custom_header.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      body: Column(children: [
        const CustomHeader(text: "Historique"),
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
                          Get.toNamed(RouteHelper.getProductList(
                            cartList[index].aProduct.idParentCategory!,
                            cartList[index].aProduct.contentTypeParentCategory!,
                          ));
                        },
                        child: Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(left: Dimensions.width20, bottom: Dimensions.height10),
                          child: ProductItemWidget(
                            illustImage: CachedNetworkImage(
                              imageUrl: cartList[index].aProduct.image!,
                              progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.black),
                            ),
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
