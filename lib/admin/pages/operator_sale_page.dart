import 'dart:math';

import 'package:borgiaflutterapp/controllers/search_controller.dart';
import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/product_list_controller.dart';
import '../../models/categories_shop_model.dart';
import '../../models/product_model.dart';
import '../../utils/dimensions.dart';
import '../../widget/pop_up_vente.dart';
import '../../widget/product_item_widget.dart';

class OpearatorSalePage extends StatefulWidget {
  final int shopId;
  const OpearatorSalePage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<OpearatorSalePage> createState() => _OpearatorSalePageState();
}

class _OpearatorSalePageState extends State<OpearatorSalePage> {
  final TextEditingController searchTextController = TextEditingController();
  bool searchWordIsEmpty = true;

  void _search(SearchController searchController) {
    var searchController = Get.find<SearchController>();
    String searchWord = searchTextController.text.trim();

    if (searchWord.isEmpty) {
      searchWordIsEmpty = true;
    } else {
      searchWordIsEmpty = false;
      searchController.getAdminUserSearchList(searchWord).then((status) {});
    }
  }

  bool searchBarIsFocused = false;

  bool userChoose = false;

  bool categoryChoose = false;

  bool productChoose = false;

  late UserModel userChosen;
  late CategoryModel categoryChosen;

  @override
  Widget build(BuildContext context) {
    Get.find<CategoryOfShopController>().getOperatorCategoryList(widget.shopId);
    return Scaffold(
        extendBody: true,
        body: SingleChildScrollView(
          child: GetBuilder<SearchController>(builder: (searchController) {
            return Column(children: [
              Container(
                height: Dimensions.height45 * 2.7,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
                ),
                margin: EdgeInsets.only(bottom: Dimensions.height10),
                padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (searchBarIsFocused && searchWordIsEmpty == false)
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              if (categoryChoose == true) {
                                setState(() {
                                  categoryChoose = false;
                                  userChoose = true;
                                });
                              } else if (userChoose == true && categoryChoose == false) {
                                setState(() {
                                  categoryChoose = false;
                                  userChoose = false;
                                });
                              } else {
                                Get.back();
                              }
                            },
                            child: SizedBox(
                              //height: Dimensions.height20,
                              width: Dimensions.width30,
                              child: Icon(Icons.arrow_back_ios, size: Dimensions.height10 * 3, color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                    SizedBox(
                      //height: Dimensions.height45 * 2,
                      width: Dimensions.screenWidth - Dimensions.width20 * 3.5,
                      child: TextFormField(
                        onChanged: (value) {
                          searchBarIsFocused = true;
                          _search(searchController);
                          setState(() {
                            userChoose = false;
                            categoryChoose = false;
                            productChoose = false;
                          });
                        },
                        controller: searchTextController,
                        style: Theme.of(context).textTheme.headlineMedium,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          prefixIcon: Icon(Icons.search, size: Dimensions.height10 * 3, color: Theme.of(context).colorScheme.onPrimary),
                          hintText: "Nom/bucque acheteur...",
                          hintStyle: Theme.of(context).textTheme.titleMedium,
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.05),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              (userChoose == false)
                  ? (searchController.isLoaded && searchWordIsEmpty == false)
                      ? ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: searchController.adminSearchList.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.only(left: Dimensions.width20, bottom: Dimensions.height20),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    userChoose = true;
                                    userChosen = searchController.adminSearchList[index];
                                    FocusScope.of(context).unfocus();
                                    searchTextController.clear();
                                    searchBarIsFocused = false;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //! image section

                                    Container(
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
                                          child: ColorFiltered(
                                            colorFilter:
                                                ColorFilter.mode(Color((((Random().nextDouble())) * 0xFFFFFF).toInt()).withOpacity(1.0), BlendMode.srcATop),
                                            child: Image.asset("assets/image/defaultuserimage.png"),
                                          )),
                                    ),

                                    SizedBox(
                                      width: Dimensions.width20 * 3,
                                    ),

                                    //! text section

                                    (searchController.adminSearchList[index].runtimeType == UserModel)
                                        ? Text(
                                            "${(searchController.adminSearchList[index].firstName.toString()).capitalize!} ${(searchController.adminSearchList[index].lastName.toString()).capitalize!}",
                                            style: Theme.of(context).textTheme.bodySmall,
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                            );
                          }))
                      : Center(
                          child: Container(),
                        )
                  : Column(
                      children: [
                        Container(
                            height: Dimensions.height100 * 2,
                            width: double.maxFinite,
                            margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height20),
                            decoration: BoxDecoration(
                                //color: Colors.white.withOpacity(0.2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    blurStyle: BlurStyle.normal,
                                    offset: const Offset(0, 0), // changes position of shadow
                                  ),
                                ], borderRadius: BorderRadius.all(Radius.circular(Dimensions.height20))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
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
                                          child: ColorFiltered(
                                            colorFilter:
                                                ColorFilter.mode(Color((((Random().nextDouble())) * 0xFFFFFF).toInt()).withOpacity(1.0), BlendMode.srcATop),
                                            child: Image.asset("assets/image/defaultuserimage.png"),
                                          )),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${userChosen.firstName!.capitalize!} ${userChosen.lastName!.capitalize!}",
                                              style: Theme.of(context).textTheme.titleMedium,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10 / 2,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${userChosen.surname!.capitalize!} ${userChosen.family!} ${(userChosen.campus!).toLowerCase().capitalize!}${userChosen.year! - 1800}",
                                              style: Theme.of(context).textTheme.titleMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Center(
                                  child: Text(
                                    "${userChosen.balance!} €",
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.greenEmerald, fontSize: 30),
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),
                              ],
                            )),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        (categoryChoose == false)
                            ? GetBuilder<CategoryOfShopController>(builder: (categoryOfShopController) {
                                return categoryOfShopController.operatorListIsLoaded
                                    ? Container(
                                        width: double.maxFinite,
                                        margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: categoryOfShopController.operatorList.length,
                                            itemBuilder: (context, index) {
                                              CategoryModel categoryModel = categoryOfShopController.operatorList[index];

                                              return GestureDetector(
                                                onTap: () {
                                                  Get.find<ProductListController>().getProduct(categoryModel.id!);

                                                  setState(() {
                                                    categoryChoose = true;
                                                    categoryChosen = categoryModel;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(right: Dimensions.width20, bottom: Dimensions.height15),
                                                  child: Row(children: [
                                                    //! image

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
                                                          errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.black),
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
                              })
                            : GetBuilder<ProductListController>(builder: (productListController) {
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
                                                          buyer: userChosen,
                                                          productModel: productModel,
                                                          productListController: productListController,
                                                        );
                                                      });

                                                  //! not working
                                                  /*  Get.find<SearchController>();
                                                  setState(() {}); */
                                                },
                                                child: (productModel.isActive == true)
                                                    ? ProductItemWidget(
                                                        titleText: (productModel.name)!.capitalize!,
                                                        illustImage: CachedNetworkImage(
                                                          imageUrl: productModel.image!,
                                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                              CircularProgressIndicator(value: downloadProgress.progress),
                                                          errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.black),
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
                              })
                      ],
                    ),
              Container(
                color: Colors.transparent,
                height: Dimensions.height10 * 3,
              )
            ]);
          }),
        ));
  }
}
