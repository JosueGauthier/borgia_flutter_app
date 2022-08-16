import 'package:flutter/material.dart';

import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import '../../../controllers/product_list_controller.dart';
import '../../../models/product_model.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/dimensions.dart';
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

    // set up the AlertDialog

    AlertDialog alert2 = AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.height45)),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //margin: EdgeInsets.only(bottom: Dimensions.height10 * 2),
              height: Dimensions.height100 * 0.9,
              width: Dimensions.height100 * 0.9,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: SizedBox(
                height: Dimensions.height100 * 0.6,
                width: Dimensions.height100 * 0.6,
                child: CachedNetworkImage(
                  imageUrl: productModelChoose.image!,
                  progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            Text(productModelChoose.name!.capitalize!.toString(), style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Dimensions.width45 * 6,
              child: Text(
                "Etes vous sur de vouloir supprimer ce produit ?\n\nCette action est irréversible ! ",
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 5,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _deleteProduct(deleteProductController);
                  });
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(Dimensions.height10 * 2)),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                      return AppColors.greenEmerald;
                    })),
                child: Text(
                  "Oui",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontFamily: 'Montserrat-Bold',
                      fontSize: 16,
                      letterSpacing: 1,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.cancel_rounded,
                  color: AppColors.mainColor,
                  size: Dimensions.height20 * 3,
                ),
              )
            ],
          )
        ]);

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert2;
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
                                    margin: EdgeInsets.only(bottom: Dimensions.height15),
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
                                              child: Stack(
                                                //alignment: Alignment.,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(right: Dimensions.height10),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).appBarTheme.surfaceTintColor,
                                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.width20)),
                                                      //border: Border.all(color: AppColors.borderDarkColor)
                                                    ),
                                                    margin: EdgeInsets.only(left: Dimensions.width20),
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          //! text section

                                                          Container(
                                                            height: Dimensions.height100 * 0.7,
                                                            margin: EdgeInsets.only(left: Dimensions.height10 * 7),
                                                            alignment: Alignment.center,
                                                            child: Text(
                                                              (productModel.name)!.capitalize!,
                                                              style: Theme.of(context).textTheme.bodySmall,
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
                                                        ]),
                                                  ),

                                                  //! image section

                                                  Container(
                                                    //margin: EdgeInsets.only(bottom: Dimensions.height10 * 2),
                                                    height: Dimensions.height100 * 0.7,
                                                    width: Dimensions.height100 * 0.7,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      height: Dimensions.height100 * 0.5,
                                                      width: Dimensions.height100 * 0.5,
                                                      child: CachedNetworkImage(
                                                        imageUrl: productModel.image!,
                                                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                            CircularProgressIndicator(value: downloadProgress.progress),
                                                        errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                  /*  SizedBox(
                                width: Dimensions.width20 * 3,
                              ),
                               */
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
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
