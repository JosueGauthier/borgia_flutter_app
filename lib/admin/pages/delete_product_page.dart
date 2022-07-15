import 'dart:developer';

import 'package:borgiaflutterapp/admin/controller/update_product_controller.dart';
import 'package:borgiaflutterapp/admin/models/delete_product_model.dart';
import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_list_controller.dart';
import '../../models/product_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import '../../widget/custom_header.dart';
import '../../widget/product_item_widget.dart';
import '../../widget/profile_box.dart';
import '../controller/delete_product_controller.dart';

class DeleteProductPage extends StatefulWidget {
  final int shopId;
  const DeleteProductPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<DeleteProductPage> createState() => _DeleteProductPageState();
}

class _DeleteProductPageState extends State<DeleteProductPage> {
  bool productIsChoose = false;
  late ProductModel productModelChosen;

  void _deleteProduct(
    DeleteProductController deleteProductController,
  ) {
    String username = AppConstants.USERNAME;
    String password = AppConstants.PASSWORD;

    DeleteProductModel productModel = DeleteProductModel(
      username: username,
      password: password,
      productId: productModelChosen.id!,
    );

    deleteProductController.deleteProduct(productModel).then((status) {
      if (status.isSuccess) {
        //! changer below
        Get.back();
      } else {
        Get.snackbar("Erreur", "Produit non supprimé. Verifier les informations saisies", backgroundColor: Colors.redAccent);
      }
    });
  }

  showAlertDialog(BuildContext context, DeleteProductController deleteProductController) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        _deleteProduct(deleteProductController);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Etes vous sur de vouloir ce produit cette action est irréversible ? "),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.find<ProductListController>().getShopProduct(widget.shopId);

    return GetBuilder<ProductListController>(builder: (productListController) {
      return GetBuilder<DeleteProductController>(builder: (deleteProductController) {
        return Scaffold(
            extendBody: true,
            body: Column(
              children: [
                const CustomHeader(text: "Modification de produit"),
                Expanded(
                  child: SingleChildScrollView(
                    child: (productIsChoose)
                        ? Column(
                            children: [
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showAlertDialog(context, deleteProductController);
                                },
                                child: SizedBox(
                                  width: Dimensions.width45 * 5,
                                  child: ProfileBox(
                                    textColor: Theme.of(context).colorScheme.onPrimary,
                                    backgroundcolor: Colors.redAccent,
                                    icon: Icons.check,
                                    text: "Supprimer",
                                    iconcolor: Theme.of(context).colorScheme.onPrimary,
                                    radius: Dimensions.width45,
                                    isEditable: false,
                                  ),
                                ),
                              )
                            ],
                          )
                        : (productListController.shopProductListIsLoaded)
                            ? Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: productListController.shopProductList.length,
                                    itemBuilder: (context, index) {
                                      ProductModel productModel = productListController.shopProductList[index];
                                      return GestureDetector(
                                          onTap: () {
                                            productModelChosen = productModel;

                                            setState(() {
                                              productIsChoose = true;
                                            });
                                          },
                                          child: ProductItemWidget(
                                            titleText: (productModel.name)!.capitalize!,
                                            illustImage: CachedNetworkImage(
                                              imageUrl: productModel.image!,
                                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                  CircularProgressIndicator(value: downloadProgress.progress),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                            ),
                                            priceProduct: productModel.manualPrice.toString(),
                                          ));
                                    }),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 4,
                                  color: AppColors.mainColor,
                                ),
                              ),
                  ),
                ),
              ],
            ));
      });
    });
  }
}
