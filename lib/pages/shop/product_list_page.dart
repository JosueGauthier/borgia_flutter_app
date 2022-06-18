import 'package:borgiaflutterapp/controllers/product_list_controller.dart';
import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:borgiaflutterapp/widget/custom_header.dart';
import 'package:borgiaflutterapp/widget/product_item_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/pop_up_vente.dart';

class ProductListPage extends StatefulWidget {
  final String pagefrom;
  final int categoryId;
  final int categoryModuleId;
  final int shopId;
  const ProductListPage({Key? key, required this.categoryId, required this.pagefrom, required this.shopId, required this.categoryModuleId}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    Get.find<ProductListController>().getProduct(widget.categoryId);

    return Scaffold(
      body: Column(
        children: [
          //! header Text  + cart

          const CustomHeader(text: "Produits"),

          //! Scroll list des produits de la categorie asociée
          Expanded(child: SingleChildScrollView(child: GetBuilder<ProductListController>(builder: (productListController) {
            return productListController.isLoaded
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: productListController.productList.length,
                        itemBuilder: (context, index) {
                          ProductModel productModel = productListController.productList[index];
                          return GestureDetector(
                            onTap: () {
                              Get.find<ProductListController>().initProduct(productModel, Get.find<CartController>());

                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return DialogSalePage(
                                      productModel: productModel,
                                      productListController: productListController,
                                    );
                                  });
                            },
                            child: (productModel.isActive == true)
                                ? ProductItemWidget(
                                    titleText: (productModel.name)!.capitalize!,
                                    illustImage: CachedNetworkImage(
                                      imageUrl: productModel.image!,
                                      progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                    priceProduct: productModel.manualPrice.toString(),
                                  )
                                : Container(),
                          );
                        }),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      color: AppColors.mainColor,
                    ),
                  );
          }))),
        ],
      ),
    );
  }
}
