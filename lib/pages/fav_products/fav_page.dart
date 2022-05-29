import 'package:borgiaflutterapp/widget/productItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';

class FavPage extends StatelessWidget {
  const FavPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          height: Dimensions.height45 * 2.7,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Dimensions.height20),
                bottomRight: Radius.circular(Dimensions.height20),
              )),
          padding: EdgeInsets.only(top: Dimensions.height30 * 1.3, left: Dimensions.width20 * 2, right: Dimensions.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BigText(
                fontTypo: 'Montserrat-Bold',
                text: "Produits favoris",
                size: Dimensions.height10 * 3,
                color: AppColors.titleColor,
              ),
            ],
          ),
        ),
        GetBuilder<CartController>(
          builder: (cartController) {
            var _cartList = cartController.getItems;

            return Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _cartList.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          /* ProductModel productModel = searchController.searchList[index];
                          //Get.find<CategoryFromProductController>().getCat(productModel.id!);
                          //List catList = AppConstants.CAT_LIST;
                          CategoryFromProductController categoryFromProductController = Get.find();
                          await Get.find<CategoryFromProductController>().getCat(productModel.id!);
                          List catList = categoryFromProductController.catList;
                          print(catList);
                          Get.find<CategoryOfShopController>().getCategoryList(productModel.shop!);
                          List catListModule = AppConstants.CAT_LIST_MODULE; */

                          Get.toNamed(RouteHelper.getProductList(
                              _cartList[index].categoryId!, _cartList[index].categoryModuleId!, _cartList[index].shopId!, "favPage"));
                        },
                        child: Container(
                          width: double.maxFinite,
                          //color: Colors.green,
                          margin: EdgeInsets.only(left: Dimensions.width20),
                          child: ProductItemWidget(
                            illustImage: NetworkImage(_cartList[index].img!),
                            titleText: _cartList[index].name!,
                            priceProduct: _cartList[index].price.toString(),
                          ),
                        ),
                      );
                    })));
          },
        )
      ]),
    );
  }
}
