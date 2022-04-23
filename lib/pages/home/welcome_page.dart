import 'package:borgiaflutterapp/controllers/shop_controller.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import "string_extension.dart";

import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../models/Popular_product_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/app_column.dart';
import '../../widget/big_text.dart';
import '../../widget/slider_bottom_section.dart';
import '../../widget/small_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController pageController = PageController(viewportFraction: 0.9);

  var _currentPagevalue = 0.0;
  int _nb_item_slider_section = 5;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  Map<String, dynamic> mapItemsSlider = {
    'Solde actuel': "current-balance.png",
    "Derniers achats": "last-purchase.png",
    'Rechargement Lydia': "lydia-logo.jpeg",
    'Rechargement stripe.com': "Stripe-Logo.png",
    'Statistiques': "stat.jpg"
  };

  List<List<dynamic>> listItemsSlider = [
    ['Solde actuel', "current-balance.png"],
    ["Derniers achats", "last-purchase.png"],
    ['Rechargement Lydia', "lydia-logo.jpeg"],
    ['Rechargement stripe.com', "Stripe-Logo.png"],
    ['Statistiques', "stat.jpg"]
  ];

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

        Container(
          //color: Colors.blue,
          height: Dimensions.height100 * 2.7,

          child: PageView.builder(
              controller: pageController,
              itemCount: _nb_item_slider_section, //popularProductsController.popularProductList.length,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),

        //!Dots section

        DotsIndicator(
          dotsCount: _nb_item_slider_section <= 0 ? 1 : _nb_item_slider_section,
          position: _currentPagevalue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            color: Colors.grey,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),

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
                        //print(shopModel.id);
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
                                          text: (shopModel.name)!.capitalize!,
                                          size: Dimensions.height25,
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        SmallText(allowOverFlow: true, maxLines: 2, text: (shopModel.description)!.capitalize!),
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

  Widget _buildPageItemOld(int position, oldProductModel popularProduct) {
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

  Widget _buildPageItem(int position) {
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
          //! Partie image
          GestureDetector(
            onTap: () {
              //Get.toNamed(RouteHelper.getPopularFood(position, "home"));
            },
            child: Container(
              height: _height,
              margin: EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  //color: position.isEven ? Colors.red : Colors.amber,
                  image: DecorationImage(image: AssetImage("assets/image/" + listItemsSlider[position][1].toString()), fit: BoxFit.cover)),
              //NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + popularProduct.img!)
            ),
          ),

          //! Partie text
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: Dimensions.height45 * 2,
              margin: EdgeInsets.only(left: Dimensions.width25, right: Dimensions.width25, bottom: Dimensions.height20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius30), color: AppColors.greyColor.withOpacity(0.9), boxShadow: [
                //BoxShadow(color: Color.fromARGB(255, 221, 216, 216), blurRadius: 10, offset: Offset(2, 5)),
                //BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                //BoxShadow(color: Colors.white, offset: Offset(5, 0)),
              ]),
              child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height45 / 2, left: Dimensions.width25, right: Dimensions.width15),
                  child: SliderBottomSectionWidget(titletext: listItemsSlider[position][0])),
            ),
          ),
        ],
      ),
    );
  }
}
