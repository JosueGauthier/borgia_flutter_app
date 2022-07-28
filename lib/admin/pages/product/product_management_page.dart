import 'package:flutter/material.dart';

import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import '../../../controllers/product_list_controller.dart';
import '../../../models/product_model.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/dimensions.dart';
import '../../../widget/product_item_widget.dart';
import '../../controller/delete_product_controller.dart';
import '../../models/delete_product_model.dart';

late ProductModel productModelChoose;

class ProductManagementPage extends StatefulWidget {
  final int shopId;
  const ProductManagementPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<ProductManagementPage> createState() => _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  void _deleteProduct(
    DeleteProductController deleteProductController,
  ) {
    String username = AppConstants.USERNAME;
    String password = AppConstants.PASSWORD;

    DeleteProductModel productModel = DeleteProductModel(
      username: username,
      password: password,
      productId: productModelChoose.id!,
    );

    deleteProductController.deleteProduct(productModel).then((status) {
      if (status.isSuccess) {
        //! changer below
        Get.back();
        Get.back();
      } else {
        Get.snackbar("Erreur", "Produit non supprimé. Vérifier les informations saisies", backgroundColor: Colors.redAccent);
      }
    });
  }

  showAlertDialog(BuildContext context, DeleteProductController deleteProductController) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: Theme.of(context).textTheme.labelLarge,
      ),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Continue",
        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.redAccent),
      ),
      onPressed: () {
        _deleteProduct(deleteProductController);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        productModelChoose.name!.capitalize!,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      content: Text(
        "Etes vous sur de vouloir supprimer ce produit ?\n\nCette action est irréversible ! ",
        style: Theme.of(context).textTheme.titleSmall,
      ),
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

    return GetBuilder<DeleteProductController>(builder: (deleteProductController) {
      return GetBuilder<ProductListController>(builder: (productListController) {
        return Scaffold(
            extendBody: true,
            floatingActionButton: FloatingActionButton(
                backgroundColor: AppColors.secondColor,
                onPressed: () {
                  setState(() {
                    Get.toNamed(RouteHelper.getCreateProductPage(widget.shopId));
                  });
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
            body: Column(
              children: [
                Container(
                  height: Dimensions.height20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: (productListController.shopProductListIsLoaded)
                        ? Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20, bottom: Dimensions.height20 * 3),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: productListController.shopProductList.length,
                                itemBuilder: (context, index) {
                                  ProductModel productModel = productListController.shopProductList[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: GestureDetector(
                                                onTap: () {
                                                  productModelChoose = productModel;
                                                  Get.toNamed(RouteHelper.getUpdateProductPage(widget.shopId));
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
                                                )),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                productModelChoose = productModel;
                                                Get.toNamed(RouteHelper.getUpdateProductPage(widget.shopId));
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                color: AppColors.greenEmerald,
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimensions.width20,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                productModelChoose = productModel;
                                                showAlertDialog(context, deleteProductController);
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.redAccent,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
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
