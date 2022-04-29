import 'package:borgiaflutterapp/controllers/shop_controller.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sa3_liquid/sa3_liquid.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/slider_bottom_section.dart';
import '../../widget/small_text.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PageController pageController = PageController(viewportFraction: 0.9);

  var _currentPagevalue = 0.0;
  final int _nbItemSliderSection = 5;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  Map<String, dynamic> mapItemsSlider = {
    'Solde actuel': "current-balance.png",
    "Derniers achats": "last-purchase.png",
    'Rechargement Lydia': "lydia-logo.jpeg",
    'Rechargement Stripe': "Stripe-Logo.png",
    'Statistiques': "stat.jpg"
  };

  List<List<dynamic>> listItemsSlider = [
    ['Solde actuel', null],
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
    Get.find<UserController>().getUserList(AppConstants.USERNAME);
    return Column(
      children: [
        //! sliderSection

        GetBuilder<UserController>(builder: (userController) {
          return userController.isLoaded
              ? SizedBox(
                  //color: Colors.blue,
                  height: Dimensions.height100 * 2.5,

                  child: PageView.builder(
                      controller: pageController,
                      itemCount: _nbItemSliderSection, //popularProductsController.popularProductList.length,
                      itemBuilder: (context, position) {
                        UserModel userModel = userController.userList[0];
                        //print("userbalance is " + userModel.balance.toString());
                        //inspect(userModel);

                        //CategoryOfShopModel categoryModel = categoryOfShopController.categoryOfShopList[index];

                        return _buildPageItem(position, userModel);
                      }),
                )
              : Container();
        }),

        //!Dots section

        DotsIndicator(
          dotsCount: _nbItemSliderSection <= 0 ? 1 : _nbItemSliderSection,
          position: _currentPagevalue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            color: AppColors.lightGreyColor,
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
          //color: Colors.amber,
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            BigText(
              text: "Liste des magasins",
              size: Dimensions.height30,
            )
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
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: shopController.shopList.length,
                  itemBuilder: (context, index) {
                    ShopModel shopModel = shopController.shopList[index];
                    return GestureDetector(
                      onTap: () {
                        //print(shopModel.id);
                        AppConstants.SHOP_ID = shopModel.id!;
                        Get.toNamed(RouteHelper.getCategoryListPage(shopModel.id!, "home"));
                      },
                      child: Container(
                        //color: Colors.amber,
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
                                      borderRadius: BorderRadius.only(
                                          //topLeft: Radius.circular(Dimensions.height20),
                                          //bottomLeft: Radius.circular(Dimensions.height20),
                                          topRight: Radius.circular(Dimensions.height20),
                                          bottomRight: Radius.circular(Dimensions.height20))),
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
                                          color: AppColors.titleColor,
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
              : const CircularProgressIndicator(
                  strokeWidth: 4,
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildPageItem(int position, UserModel userModel) {
    Matrix4 matrix = Matrix4.identity();

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
            child: (listItemsSlider[position][1] == null)
                ? Stack(
                    children: [
                      /* Container(
                        height: _height,
                        margin: EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius30),
                            //color: position.isEven ? Colors.red : Colors.amber,
                            //color: AppColors.secondColor

                            gradient:
                                LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomRight, colors: [AppColors.mainColor, AppColors.secondColor])),

                        //NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + popularProduct.img!)
                      ),
                      
                       */

                      Container(
                        height: _height,
                        margin: EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            //borderRadius: BorderRadius.circular(Dimensions.radius30),
                            color: AppColors.secondColor,
                            backgroundBlendMode: BlendMode.srcOver,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: const PlasmaRenderer(
                              type: PlasmaType.infinity,
                              particles: 6,
                              color: AppColors.mainColor, //Color(0x64d31418),
                              blur: 0.9,
                              size: 0.9,
                              speed: 1,
                              offset: 0,
                              blendMode: BlendMode.srcOver,
                              particleType: ParticleType.atlas,
                              variation1: 0,
                              variation2: 0,
                              variation3: 0,
                              rotation: 0,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        heightFactor: 1.5,
                        child: BigText(
                          fontTypo: 'OpenSansExtraBold',
                          text: userModel.balance! + "€",
                          color: Colors.white,
                          size: Dimensions.height30 * 2.7,
                        ),
                      )
                    ],
                  )
                : Container(
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
              height: Dimensions.height45 * 1.5,
              margin: EdgeInsets.only(left: Dimensions.width25, right: Dimensions.width25, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius30), topRight: Radius.circular(Dimensions.radius30)),
                  color: AppColors.whiteGreyColor.withOpacity(0.9),
                  boxShadow: const [
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
