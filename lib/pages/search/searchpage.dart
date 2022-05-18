import 'dart:async';
import 'dart:developer';

import 'package:borgiaflutterapp/controllers/prod_cat_controller.dart';
import 'package:borgiaflutterapp/controllers/search_controller.dart';
import 'package:borgiaflutterapp/controllers/shop_controller.dart';
import 'package:borgiaflutterapp/data/repository/product_list_from_category_repo.dart';
import 'package:borgiaflutterapp/models/categories_shop_model.dart';
import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/other_users_controller.dart';
import '../../controllers/product_from_category_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/pop_up_vente.dart';

class SearchPage extends StatelessWidget {
  SearchPage({
    Key? key,
  }) : super(key: key);

  TextEditingController searchTextController = TextEditingController();

  void _search(SearchController searchController) {
    var searchController = Get.find<SearchController>();
    String searchWord = searchTextController.text.trim();

    if (searchWord.isEmpty) {
    } else {
      searchController.getSearchList(searchWord).then((status) {
        print(searchController.getSearchList(searchWord));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<SearchController>(builder: (searchController) {
          return Column(children: [
            Container(
              height: Dimensions.height45 * 2.7,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              margin: EdgeInsets.only(bottom: Dimensions.height10),
              padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: Dimensions.height45 * 2.7,
                    width: Dimensions.height100 * 3.5,
                    child: TextFormField(
                      onChanged: (value) {
                        _search(searchController);
                      },
                      controller: searchTextController,
                      style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        color: AppColors.titleColor,
                        fontSize: Dimensions.height10 * 3,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        prefixIcon: Icon(Icons.search, size: Dimensions.height10 * 3, color: AppColors.titleColor),
                        hintText: "Recherche...",
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat-Bold',
                          color: AppColors.titleColor,
                          fontSize: Dimensions.height10 * 3,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (searchController.isLoaded)
                ? Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: searchController.searchList.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            width: double.maxFinite,
                            height: Dimensions.width20 * 5,
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: Dimensions.height20),
                            child: Card(
                              elevation: 0,
                              shadowColor: AppColors.secondColor,
                              //color: Colors.blue,
                              child: GestureDetector(
                                onTap: () {
                                  if (searchController.searchList[index].runtimeType == UserModel) {
                                    Get.find<OtherUserController>().getUserList(searchController.searchList[index].name);
                                    Get.toNamed(RouteHelper.getUserPage(searchController.searchList[index].name, "searchPage"));
                                  }
                                  if (searchController.searchList[index].runtimeType == ShopModel) {
                                    Get.toNamed(RouteHelper.getCategoryListPage(searchController.searchList[index].id, "searchPage"));
                                  }
                                  if (searchController.searchList[index].runtimeType == CategoryOfShopModel) {
                                    //int categoryId, int categoryModuleId, int shopId, String pagefrom
                                    Get.toNamed(RouteHelper.getProductList(searchController.searchList[index].id, searchController.searchList[index].moduleId,
                                        searchController.searchList[index].shopId, "searchPage"));
                                  }
                                  if (searchController.searchList[index].runtimeType == ProductModel) {
                                    ProductModel productModel = searchController.searchList[index];

                                    Get.find<CategoryFromProductController>().getCat(searchController.searchList[index].id);

                                    List catList = AppConstants.CAT_LIST;

                                    Get.find<CategoryOfShopController>().getCategoryList(productModel.shop!);

                                    List catListModule = AppConstants.CAT_LIST_MODULE;

                                    Get.toNamed(RouteHelper.getProductList(catList[0].category, catListModule[0].moduleId, productModel.shop!, "search"));
                                  }
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Dimensions.width20,
                                    ),
                                    Container(
                                      width: Dimensions.width20 * 5,
                                      height: Dimensions.width20 * 5,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: (searchController.searchList[index].image == null)
                                                ? AssetImage("assets/image/dafaultuserimage.png") as ImageProvider
                                                : NetworkImage(searchController.searchList[index].image!),
                                          ),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(Dimensions.radius20)),
                                    ),
                                    SizedBox(
                                      width: Dimensions.width20,
                                    ),
                                    //? an expanded widget take all space of the parent
                                    Expanded(
                                        child: Container(
                                      //color: Colors.redAccent,
                                      height: Dimensions.width20 * 5,
                                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                        BigText(
                                          text: (searchController.searchList[index].name.toString()).capitalize!,
                                          color: AppColors.darkGreyColor,
                                          size: Dimensions.height30 * 0.8,
                                        ),
                                        (searchController.searchList[index].runtimeType == UserModel)
                                            ? BigText(
                                                text: (searchController.searchList[index].firstName.toString()).capitalize! +
                                                    " " +
                                                    (searchController.searchList[index].lastName.toString()).capitalize!,
                                                color: AppColors.darkGreyColor,
                                                size: Dimensions.height30 * 0.8,
                                              )
                                            : Container(),
                                      ]),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })))
                : Container(),
          ]);
        }));
  }
}
