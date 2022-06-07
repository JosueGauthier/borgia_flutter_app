import 'package:borgiaflutterapp/controllers/category_controller.dart';
import 'package:borgiaflutterapp/models/categories_shop_model.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../routes/route_helper.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';

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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //! header
          Container(
            height: Dimensions.height45 * 2.7,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.height20),
                  bottomRight: Radius.circular(Dimensions.height20),
                )),
            margin: EdgeInsets.only(bottom: Dimensions.height10),
            padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getInitial());
                        },
                        child: SizedBox(
                          width: Dimensions.width15 * 4,
                          height: Dimensions.width15 * 4,
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.titleColor,
                          ),
                        )),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(right: Dimensions.width20),
                  child: BigText(
                    fontTypo: 'Montserrat-Bold',
                    text: "Catégories",
                    size: Dimensions.height10 * 3,
                    color: AppColors.titleColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: SingleChildScrollView(child: GetBuilder<CategoryOfShopController>(builder: (categoryOfShopController) {
            return categoryOfShopController.isLoaded
                ? Container(
                    //color: Colors.redAccent,
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
                              //color: Colors.redAccent,
                              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width20, bottom: Dimensions.height15),
                              child: Row(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                                      height: Dimensions.height100 * 0.6,
                                      width: Dimensions.height100 * 0.6,
                                      decoration: BoxDecoration(
                                        //color: Colors.amber,
                                        image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: NetworkImage(categoryModel.image!),
                                        ),
                                        //borderRadius: BorderRadius.circular(Dimensions.width20)
                                      ),
                                    ),

                                    SizedBox(
                                      width: Dimensions.width20 * 3,
                                    ),

                                    //! text section

                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                        child: BigText(
                                          fontTypo: 'Helvetica-Bold',
                                          text: (categoryModel.name)!.capitalize!,
                                          size: Dimensions.height25 * 0.8,
                                          color: AppColors.titleColor,
                                        ),
                                      ),
                                    ),
                                    //! image section

                                    /* Stack(
                                      children: [
                                        Container(
                                          height: Dimensions.height100 * 0.6,
                                          width: Dimensions.height100 * 0.6,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.width20)),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.contain,
                                            imageUrl: categoryModel.image!,
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
                                    ), */

                                    //! text section

                                    //? expanded widget force container to take all the available space

                                    /* Expanded(
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
                                    ) */
                                  ]),
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
