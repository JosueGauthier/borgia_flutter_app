import 'package:borgiaflutterapp/controllers/search_controller.dart';
import 'package:borgiaflutterapp/models/categories_shop_model.dart';
import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';

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
        extendBody: true,
        body: GetBuilder<SearchController>(builder: (searchController) {
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
                  SizedBox(
                    height: Dimensions.height45 * 2.7,
                    width: Dimensions.height100 * 3.5,
                    child: TextFormField(
                      onChanged: (value) {
                        _search(searchController);
                      },
                      controller: searchTextController,
                      style: Theme.of(context).textTheme.headlineMedium,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        prefixIcon: Icon(Icons.search, size: Dimensions.height10 * 3, color: Theme.of(context).colorScheme.onPrimary),
                        hintText: "Recherche...",
                        hintStyle: Theme.of(context).textTheme.headlineMedium,
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

                                  Get.toNamed(RouteHelper.getProductList(searchController.searchList[index].id, searchController.searchList[index].moduleId,
                                      searchController.searchList[index].shopId, "searchPage"));
                                }
                                if (searchController.searchList[index].runtimeType == ProductModel) {
                                  //!ok
                                  ProductModel productModel = searchController.searchList[index];

                                  Get.toNamed(RouteHelper.getProductList(
                                      productModel.idParentCategory!, productModel.moduleIdParentCategory!, productModel.shop!, "searchPage"));
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //! image section

                                  (searchController.searchList[index].runtimeType == ProductModel && searchController.searchList[index].isActive == false)
                                      ? Container()
                                      : Container(
                                          height: Dimensions.height100 * 0.7,
                                          width: Dimensions.height100 * 0.7,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          alignment: Alignment.center,
                                          child: Container(
                                            height: Dimensions.height100 * 0.5,
                                            width: Dimensions.height100 * 0.5,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: (searchController.searchList[index].image == null)
                                                    ? const AssetImage("assets/image/defaultuserimage.png") as ImageProvider
                                                    : NetworkImage(searchController.searchList[index].image),
                                              ),
                                            ),
                                          ),
                                        ),

                                  SizedBox(
                                    width: Dimensions.width20 * 3,
                                  ),

                                  //! text section

                                  (searchController.searchList[index].runtimeType == ProductModel && searchController.searchList[index].isActive == false)
                                      ? Container()
                                      : Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Text(
                                            (searchController.searchList[index].name.toString()).capitalize!,
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                          (searchController.searchList[index].runtimeType == UserModel)
                                              ? Text(
                                                  "${(searchController.searchList[index].firstName.toString()).capitalize!} ${(searchController.searchList[index].lastName.toString()).capitalize!}",
                                                  style: Theme.of(context).textTheme.bodySmall,
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
        }));
  }
}
