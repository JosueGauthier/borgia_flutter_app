/* import 'package:borgiaflutterapp/widget/custom_header.dart';
import 'package:borgiaflutterapp/widget/profile_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/product_list_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/categories_shop_model.dart';
import '../../models/product_model.dart';
import '../../models/user_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/pop_up_vente.dart';
import '../../widget/product_item_widget.dart';

class AdminSalePage extends StatefulWidget {
  final int shopId;

  const AdminSalePage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<AdminSalePage> createState() => _AdminSalePageState();
}

class _AdminSalePageState extends State<AdminSalePage> {
  bool isCategory = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<UserController>(builder: (userController) {
      UserModel userModel = userController.userList[0];
      if (userController.isLoaded) {
        return SingleChildScrollView(
            child: Column(children: [
          const CustomHeader(text: "Vente opérateur"),
          Container(
            height: Dimensions.height100 * 2,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                width: Dimensions.height100 * 2.5,
                height: Dimensions.height100 * 2.5,
                child: Column(children: [
                  ProfileBox(
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundcolor: Theme.of(context).colorScheme.onPrimaryContainer,
                    iconcolor: Theme.of(context).colorScheme.onPrimary,
                    icon: Icons.login,
                    text: "Identifiant : ${userController.welcomeUserModel.name}",
                    isEditable: false,
                  ),
                  ProfileBox(
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundcolor: AppColors.greenEmerald,
                    iconcolor: Theme.of(context).colorScheme.onPrimary,
                    icon: Icons.money,
                    text: "Solde : ${userModel.surname}",
                    isEditable: false,
                    radius: 0, //Dimensions.width20,
                  ),
                ]),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
            ]),
          ),
          (isCategory == true)
              ? Expanded(child: SingleChildScrollView(child: GetBuilder<CategoryOfShopController>(builder: (categoryOfShopController) {
                  return categoryOfShopController.isLoaded
                      ? Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: categoryOfShopController.categoryOfShopList.length,
                              itemBuilder: (context, index) {
                                CategoryOfShopModel categoryModel = categoryOfShopController.categoryOfShopList[index];

                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RouteHelper.getProductList(categoryModel.id!, categoryModel.moduleId!, widget.shopId, "home"));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: Dimensions.width20, bottom: Dimensions.height15),
                                    child: Row(children: [
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
                                            imageUrl: categoryModel.image!,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                CircularProgressIndicator(value: downloadProgress.progress),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        width: Dimensions.width20 * 3,
                                      ),

                                      //! text section

                                      Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                            child: Text((categoryModel.name)!.capitalize!, style: Theme.of(context).textTheme.bodySmall)),
                                      ),
                                    ]),
                                  ),
                                );
                              }),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            color: AppColors.mainColor,
                          ),
                        );
                })))
              : Expanded(child: SingleChildScrollView(child: GetBuilder<ProductListController>(builder: (productListController) {
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
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                CircularProgressIndicator(value: downloadProgress.progress),
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
        ]));
      } else {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 4,
            color: AppColors.mainColor,
          ),
        );
      }
    }));
  }
}
 */