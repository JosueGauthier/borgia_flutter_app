import 'package:borgiaflutterapp/controllers/category_controller.dart';
import 'package:borgiaflutterapp/models/categories_shop_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../bottom/exhibition_bottom_sheet.dart';
import '../../widget/app_icon.dart';

import '../../routes/route_helper.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';

class CategoryShop extends StatefulWidget {
  final String pagefrom;
  final int shopId;
  const CategoryShop({
    Key? key,
    required this.shopId,
    required this.pagefrom,
  }) : super(key: key);

  @override
  State<CategoryShop> createState() => _CategoryShopState();
}

class _CategoryShopState extends State<CategoryShop> {
  @override
  Widget build(BuildContext context) {
    Get.find<CategoryOfShopController>().getCategoryList(widget.shopId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //! header
          Container(
            height: Dimensions.height45 * 2.7,
            decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.height20),
                  bottomRight: Radius.circular(Dimensions.height20),
                )),
            margin: EdgeInsets.only(bottom: Dimensions.height10),
            padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Catégorie", //todo add name of the shop
                  size: Dimensions.height30,
                  color: Colors.white,
                ),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: const AppIcon(iconData: CupertinoIcons.house_alt, iconColor: AppColors.mainColor, backgroundColor: Colors.white)),
              ],
            ),
          ),
          Expanded(child: SingleChildScrollView(child: GetBuilder<CategoryOfShopController>(builder: (categoryOfShopController) {
            return categoryOfShopController.isLoaded
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categoryOfShopController.categoryOfShopList.length,
                        itemBuilder: (context, index) {
                          CategoryOfShopModel categoryModel = categoryOfShopController.categoryOfShopList[index];

                          return GestureDetector(
                            onTap: () {
                              //print(categoryModel.id);

                              Get.toNamed(RouteHelper.getProductList(categoryModel.id!, categoryModel.moduleId!, widget.shopId, "home"));
                            },
                            child: Card(
                              //borderOnForeground: true,
                              elevation: 2,
                              shadowColor: AppColors.secondColor,
                              color: Colors.white,
                              //shape: ShapeBorder.lerp(, b, t),

                              child: Container(
                                //color: Colors.redAccent,
                                margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width20, bottom: Dimensions.height15),
                                child: Row(
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      //! image section

                                      Stack(
                                        children: [
                                          Container(
                                            height: Dimensions.height100 * 1.3,
                                            width: Dimensions.height100 * 1.3,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.width20)),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.contain,
                                              imageUrl: categoryModel.categoryImage!,
                                              placeholder: (context, url) => Center(
                                                child: SizedBox(
                                                  height: Dimensions.height45,
                                                  width: Dimensions.height45,
                                                  child: const CircularProgressIndicator(
                                                    color: AppColors.secondColor,
                                                  ),
                                                ),
                                              ),
                                              errorWidget: (context, url, error) => const Image(image: AssetImage("assets/image/errorimage.png")),
                                            ),
                                          ),
                                        ],
                                      ),

                                      //! text section

                                      //? expanded widget force container to take all the available space

                                      Expanded(
                                        child: Container(
                                          height: Dimensions.listviewTextHeigth + 10,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(Dimensions.height20), bottomRight: Radius.circular(Dimensions.height20))),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: Dimensions.height10,
                                                ),
                                                BigText(
                                                  text: (categoryModel.name)!.capitalize!,
                                                  size: Dimensions.height25,
                                                ),
                                                SizedBox(
                                                  height: Dimensions.height10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          );
                        }),
                  )
                : const CircularProgressIndicator(
                    strokeWidth: 4,
                    color: AppColors.mainColor,
                  );
          }))),
        ],
      ),
    );
  }
}
