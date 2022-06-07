import 'package:borgiaflutterapp/controllers/search_controller.dart';
import 'package:borgiaflutterapp/models/categories_shop_model.dart';
import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';

class SearchPage extends StatelessWidget {
  SearchPage({
    Key? key,
  }) : super(key: key);

  final TextEditingController searchTextController = TextEditingController();

  void _search(SearchController searchController) {
    var searchController = Get.find<SearchController>();
    String searchWord = searchTextController.text.trim();

    if (searchWord.isEmpty) {
    } else {
      searchController.getSearchList(searchWord).then((status) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/image/amtradsred.png",
                scale: 14,
                //color: Colors.white.withOpacity(0.5),
                //fit: BoxFit.fitWidth,
                repeat: ImageRepeat.repeat,
              ),
            ),
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: Colors.white.withOpacity(0.95),
            ),
            GetBuilder<SearchController>(builder: (searchController) {
              return Column(children: [
                Container(
                  height: Dimensions.height45 * 2.7,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                  ),
                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                  padding:
                      EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
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
                            fillColor: Colors.transparent,
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
                                //height: Dimensions.width20 * 5,
                                //color: Colors.green,
                                margin: EdgeInsets.only(left: Dimensions.width20, bottom: Dimensions.height20),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (searchController.searchList[index].runtimeType == UserModel) {
                                      //!ok
                                      Get.toNamed(RouteHelper.getUserPage(searchController.searchList[index].name, "searchPage"));
                                    }
                                    if (searchController.searchList[index].runtimeType == ShopModel) {
                                      //! ok
                                      Get.toNamed(RouteHelper.getCategoryListPage(searchController.searchList[index].id, "searchPage"));
                                    }
                                    if (searchController.searchList[index].runtimeType == CategoryOfShopModel) {
                                      //!ok

                                      print(searchController.searchList[index].id);
                                      print(searchController.searchList[index].moduleId);
                                      Get.toNamed(RouteHelper.getProductList(searchController.searchList[index].id, searchController.searchList[index].moduleId,
                                          searchController.searchList[index].shopId, "searchPage"));
                                    }
                                    if (searchController.searchList[index].runtimeType == ProductModel) {
                                      ProductModel productModel = searchController.searchList[index];
                                      print("aa");
                                      print(productModel.categoryWhereProductIs!);
                                      print(productModel.moduleIdWhereProductIs!);
                                      Get.toNamed(RouteHelper.getProductList(
                                          productModel.categoryWhereProductIs!, productModel.moduleIdWhereProductIs!, productModel.shop!, "searchPage"));
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                                        height: Dimensions.height100 * 0.6,
                                        width: Dimensions.height100 * 0.6,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: (searchController.searchList[index].image == null)
                                                ? const AssetImage("assets/image/dafaultuserimage.png") as ImageProvider
                                                : NetworkImage(searchController.searchList[index].image),
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        width: Dimensions.width20 * 3,
                                      ),

                                      //! text section

                                      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        BigText(
                                          fontTypo: 'Helvetica-Bold',
                                          size: Dimensions.height25 * 0.8,
                                          color: AppColors.titleColor,
                                          text: (searchController.searchList[index].name.toString()).capitalize!,
                                        ),
                                        (searchController.searchList[index].runtimeType == UserModel)
                                            ? BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                size: Dimensions.height25 * 0.8,
                                                color: AppColors.titleColor,
                                                text: (searchController.searchList[index].firstName.toString()).capitalize! +
                                                    " " +
                                                    (searchController.searchList[index].lastName.toString()).capitalize!,
                                              )
                                            : Container(),
                                      ]),
                                    ],
                                  ),
                                ),
                              );
                            })))
                    : Container(),
                Container(
                  color: Colors.transparent,
                  height: Dimensions.height10 * 3,
                )
              ]);
            }),
          ],
        ));
  }
}
