import 'package:borgiaflutterapp/widget/product_item_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';

class FavPage extends StatelessWidget {
  const FavPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: Dimensions.height20 * 6,
          padding: EdgeInsets.only(top: Dimensions.height10 * 3, left: Dimensions.width20 * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Produits favoris", style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ),
        GetBuilder<CartController>(
          builder: (cartController) {
            List favList = cartController.getItems;
            favList.sort((b, a) => (a.quantity).compareTo(b.quantity));
            return Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: favList.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                              RouteHelper.getProductList(favList[index].aProduct.idParentCategory!, favList[index].aProduct.contentTypeParentCategory!));
                        },
                        child: Container(
                          width: double.maxFinite,
                          //color: Colors.green,
                          margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                          child: ProductItemWidget(
                            illustImage: CachedNetworkImage(
                              imageUrl: favList[index].aProduct.image,
                              progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.black),
                            ),
                            titleText: (favList[index].name)!,
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
