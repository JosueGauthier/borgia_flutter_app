import 'package:borgiaflutterapp/controllers/category_controller.dart';
import 'package:borgiaflutterapp/models/categories_shop_model.dart';
import 'package:borgiaflutterapp/widget/custom_header.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../routes/route_helper.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class CategoryShopPage extends StatefulWidget {
  final String pagefrom;
  final int shopId;
  const CategoryShopPage({
    Key? key,
    required this.shopId,
    required this.pagefrom,
  }) : super(key: key);

  @override
  State<CategoryShopPage> createState() => _CategoryShopPageState();
}

class _CategoryShopPageState extends State<CategoryShopPage> {
  @override
  Widget build(BuildContext context) {
    Get.find<CategoryOfShopController>().getCategoryList(widget.shopId);

    return Scaffold(
      body: Column(
        children: [
          //! header

          const CustomHeader(text: "Catégories"),

          Expanded(child: SingleChildScrollView(child: GetBuilder<CategoryOfShopController>(builder: (categoryOfShopController) {
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
                              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width20, bottom: Dimensions.height15),
                              child: Row(children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                                  height: Dimensions.height100 * 0.6,
                                  width: Dimensions.height100 * 0.6,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(categoryModel.image!),
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
          }))),
        ],
      ),
    );
  }
}
