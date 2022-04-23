import 'package:borgiaflutterapp/controllers/shop_controller.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../models/Popular_product_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/app_column.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController pageController = PageController(viewportFraction: 0.9);

  var _currentPagevalue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPagevalue = pageController.page!;
        //print(_currentPagevalue.toString());
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! sliderSection

        /* GetBuilder<PopularProductController>(builder: (popularProductsController) {
          return popularProductsController.isLoaded
              ? Container(
                  //color: Colors.blue,
                  height: Dimensions.pageViewheight,

                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProductsController.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position, popularProductsController.popularProductList[position]);
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
 */
        //!Dots section
        GetBuilder<PopularProductController>(builder: (popularProductsController) {
          int dotsnumber = popularProductsController.popularProductList.length;

          //print(popularProductsController.popularProductList.length);
          return DotsIndicator(
            dotsCount: dotsnumber <= 0 ? 1 : dotsnumber,
            position: _currentPagevalue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              color: AppColors.textColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          );
        }),

        //!Recommended items
        SizedBox(
          height: Dimensions.height20,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            BigText(text: "List of shops"),
          ]),
        ),
        SizedBox(
          height: Dimensions.height10,
        ),

        //! List of shops scroll view

        GetBuilder<ShopController>(builder: (shopController) {
          return shopController.isLoaded
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: shopController.shopList.length,
                  itemBuilder: (context, index) {
                    ShopModel shopModel = shopController.shopList[index];
                    return GestureDetector(
                      onTap: () {
                        print(shopModel.id);
                        Get.toNamed(RouteHelper.getCategoryListPage(shopModel.id!, "home"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height15),
                        child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //! image section

                              Container(
                                height: Dimensions.height100,
                                width: Dimensions.listviewimgSize,
                                decoration: BoxDecoration(
                                    //color: Colors.amber,
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(shopModel.image!),
                                    ),
                                    borderRadius: BorderRadius.circular(Dimensions.width20)),
                              ),

                              //! text section

                              //? expanded widget force container to take all the available space
                              Expanded(
                                child: Container(
                                  height: Dimensions.listviewTextHeigth + 10,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.only(topRight: Radius.circular(Dimensions.height20), bottomRight: Radius.circular(Dimensions.height20))),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        BigText(
                                          text: shopModel.name!,
                                          size: Dimensions.height25,
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        SmallText(allowOverFlow: true, maxLines: 2, text: shopModel.description!),
                                        /* SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndTextWidget(icon: Icons.circle, text: "Normal", iconcolor: Colors.amber),
                                            SizedBox(
                                              width: 0,
                                            ),
                                            IconAndTextWidget(icon: Icons.location_pin, text: "1.7 km", iconcolor: AppColors.mainColor),
                                            SizedBox(
                                              width: 0,
                                            ),
                                            IconAndTextWidget(icon: Icons.lock_clock, text: "16 min", iconcolor: Colors.pink),
                                          ],
                                        ) */
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  strokeWidth: 4,
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildPageItem(int position, oldProductModel popularProduct) {
    Matrix4 matrix = new Matrix4.identity();

    if (position == _currentPagevalue.floor()) {
      var currScale = 1 - (_currentPagevalue - position) * (1 - _scaleFactor);
      var currTranslation = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTranslation, 0);
    } else if (position == _currentPagevalue.floor() + 1) {
      var currScale = _scaleFactor + (_currentPagevalue - position + 1) * (1 - _scaleFactor);
      var currTranslation = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTranslation, 0);
    } else if (position == _currentPagevalue.floor() - 1) {
      var currScale = 1 - (_currentPagevalue - position) * (1 - _scaleFactor);
      var currTranslation = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTranslation, 0);
    } else {
      var currScale = 0.8;
      var currTranslation = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTranslation, 0);
    }

    //? mise en place d'un stack container pour que la hauteur désiree soit 220 et non 320.
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(position, "home"));
            },
            child: Container(
              height: _height,
              margin: EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  //color: position.isEven ? Colors.red : Colors.amber,
                  image: DecorationImage(image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + popularProduct.img!), fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewText,
              margin: EdgeInsets.only(left: Dimensions.width25, right: Dimensions.width25, bottom: Dimensions.height20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius30), color: Colors.white, boxShadow: [
                BoxShadow(color: Color.fromARGB(255, 221, 216, 216), blurRadius: 10, offset: Offset(2, 5)),
                BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                BoxShadow(color: Colors.white, offset: Offset(5, 0)),
              ]),
              child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height10, left: Dimensions.width15, right: Dimensions.width15),
                  child: AppColumn(titletext: popularProduct.name!)),
            ),
          ),
        ],
      ),
    );
  }
}
