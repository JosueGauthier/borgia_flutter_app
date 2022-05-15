import 'package:borgiaflutterapp/controllers/shop_controller.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sa3_liquid/sa3_liquid.dart';

import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
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

  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  List<List<dynamic>> listItemsSlider = [
    ['Solde actuel', null],
    ['Rechargement', "lydia-logo.jpeg"],
    ['Statistiques', "auto_label_full.png"]
  ];

  final int _nbItemSliderSection = 3;

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

        //!Liste de magasins items
        SizedBox(
          height: Dimensions.height10,
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

        //! List of shops scroll view

        GetBuilder<ShopController>(builder: (shopController) {
          return shopController.isLoaded
              ? Container(
                  //color: Colors.greenAccent,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20, top: 0),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: shopController.shopList.length,
                      itemBuilder: (context, index) {
                        ShopModel shopModel = shopController.shopList[index];
                        return GestureDetector(
                          onTap: () {
                            AppConstants.SHOP_ID = shopModel.id!;
                            Get.toNamed(RouteHelper.getCategoryListPage(shopModel.id!, "home"));
                          },
                          child: Card(
                            elevation: 0,
                            shadowColor: AppColors.secondColor,
                            color: Colors.white,
                            child: Row(children: [
                              //! image section

                              SizedBox(
                                width: Dimensions.width20,
                              ),

                              Center(
                                heightFactor: 1.5,
                                child: Container(
                                  height: Dimensions.height100 * 0.7,
                                  width: Dimensions.listviewimgSize,
                                  decoration: BoxDecoration(
                                      //color: Colors.amber,
                                      image: DecorationImage(
                                        fit: BoxFit.scaleDown,
                                        image: NetworkImage(shopModel.image!),
                                      ),
                                      borderRadius: BorderRadius.circular(Dimensions.width20)),
                                ),
                              ),

                              //! text section

                              //? expanded widget force container to take all the available space
                              Expanded(
                                child: Center(
                                  child: Container(
                                    height: Dimensions.listviewTextHeigth * 0.8,
                                    decoration: const BoxDecoration(
                                        //color: Colors.greenAccent,
                                        ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          BigText(
                                            text: (shopModel.name)!.capitalize!,
                                            size: Dimensions.height25,
                                            color: AppColors.titleColor,
                                          ),

                                          //SmallText(allowOverFlow: true, maxLines: 2, text: (shopModel.description)!.capitalize!),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ),
                        );
                      }),
                )
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
                  ? GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getLydiaPage());
                      },
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getLydiaPage());
                        },
                        child: Stack(
                          children: [
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
                            ),
                            (double.parse(userModel.balance!) < 5)
                                ? Positioned(
                                    bottom: Dimensions.width10,
                                    right: Dimensions.width10 * 3,
                                    child: SmallText(
                                      //fontTypo: 'OpenSansExtraBold',
                                      text: "* Tap pour \n recharger",
                                      color: Colors.white,
                                      size: Dimensions.height30 / 2,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      child: (listItemsSlider[position][1] == "last")
                          ? Container(
                              height: _height,
                              margin: EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius30),
                                //color: position.isEven ? Colors.red : Colors.amber,
                                color: AppColors.mainColor,

                                //image: DecorationImage(image: AssetImage("assets/image/" + listItemsSlider[position][1].toString()), fit: BoxFit.cover)),

                                //NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + popularProduct.img!)
                              ),
                              child: GetBuilder<CartController>(builder: (cartController) {
                                var _cartList = cartController.getItems;

                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _cartList.length,
                                    itemBuilder: ((context, index) {
                                      return ClipRRect(
                                        child: Align(
                                          child: SizedBox(
                                            height: Dimensions.height45 * 4,
                                            child: Card(
                                              elevation: 2,
                                              shadowColor: AppColors.secondColor,
                                              color: Colors.white,
                                              child: GestureDetector(
                                                onTap: () {
                                                  //Get.toNamed(RouteHelper.getProductList(categoryModel.id!, categoryModel.moduleId!, widget.shopId, "home"));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                                  margin: EdgeInsets.only(
                                                      top: Dimensions.height20,
                                                      bottom: Dimensions.height20,
                                                      left: Dimensions.width10,
                                                      right: Dimensions.width10),
                                                  width: Dimensions.width20 * 5,
                                                  height: Dimensions.width20 * 2,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(fit: BoxFit.contain, image: NetworkImage(_cartList[index].img!)),
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(Dimensions.radius20)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }));
                              }),
                            )
                          : Container(
                              child: (listItemsSlider[position][1] == "lydia-logo.jpeg")
                                  ? GestureDetector(
                                      onTap: () {
                                        Get.toNamed(RouteHelper.getLydiaPage());
                                      },
                                      child: Container(
                                        height: _height,
                                        margin: EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius30),
                                            //color: position.isEven ? Colors.red : Colors.amber,

                                            image: DecorationImage(
                                                image: AssetImage("assets/image/" + listItemsSlider[position][1].toString()), fit: BoxFit.cover)),

                                        //NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + popularProduct.img!)
                                      ),
                                    )
                                  : Container(
                                      height: _height,
                                      margin: EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius30),
                                          //color: position.isEven ? Colors.red : Colors.amber,

                                          image:
                                              DecorationImage(image: AssetImage("assets/image/" + listItemsSlider[position][1].toString()), fit: BoxFit.cover)),

                                      //NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + popularProduct.img!)
                                    ),
                            ))),

          //! Partie text
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: Dimensions.height45 * 1.5,
              margin: EdgeInsets.only(left: Dimensions.width30 * 1.1, right: Dimensions.width25, bottom: Dimensions.height30),
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
