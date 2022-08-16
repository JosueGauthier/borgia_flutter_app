import 'package:borgiaflutterapp/admin/controller/salemodule_controller.dart';
import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/shop_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/shop_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';
import '../../widget/custom_header.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List isChiefIn = [];

  @override
  void initState() {
    super.initState();

    Get.find<SaleModuleController>().getOperatorsaleModuleList();
    Get.find<SaleModuleController>().getSelfsaleModuleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Column(children: [
          const CustomHeader(text: "Admin"),
          Container(
            height: Dimensions.height100 * 1,
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(AppColors.mainColor, BlendMode.srcATop),
              child: Image.asset("assets/image/adminpanel.png"),
            ),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: Dimensions.width20 * 1.5),
                  child: Text(
                    "Actions",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                SingleChildScrollView(
                  child: GetBuilder<UserController>(builder: (userController) {
                    UserModel userModel = userController.userModelController;

                    return (userController.isLoaded)
                        ? Column(
                            children: [
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20 * 1.5, top: Dimensions.height10),
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: userModel.groups!.length,
                                    itemBuilder: (context, index) {
                                      if (userModel.groups![index].name!.contains("chiefs") || userModel.groups![index].name!.contains("associates")) {
                                        String? nameString = userModel.groups![index].name;

                                        List nameStringSplit = nameString!.split("-");

                                        if (isChiefIn.contains(nameStringSplit[1])) {
                                        } else {
                                          isChiefIn.add(nameStringSplit[1]);
                                        }

                                        return GetBuilder<ShopController>(builder: (shopController) {
                                          ShopModel shopModel =
                                              shopController.shopList.firstWhere((element) => (element.name == isChiefIn[isChiefIn.length - 1]));

                                          return GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              margin: EdgeInsets.only(bottom: Dimensions.height15),
                                              decoration: BoxDecoration(
                                                  //color: AppColors.mainColor.withOpacity(1),
                                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.width20)),
                                                  border: Border.all(color: AppColors.borderDarkColor)),
                                              padding: EdgeInsets.all(Dimensions.height10),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    //! image section

                                                    (userModel.groups![index].name!.contains("chiefs"))
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              Get.toNamed(RouteHelper.getEditShopPage(shopModel.id!));
                                                            },
                                                            child: Stack(children: [
                                                              Container(
                                                                //margin: EdgeInsets.only(bottom: Dimensions.height10 * 2),
                                                                height: Dimensions.height100 * 1.5,
                                                                width: Dimensions.height100 * 1,
                                                                decoration: const BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: Colors.white,
                                                                ),
                                                                alignment: Alignment.center,
                                                                child: SizedBox(
                                                                  height: Dimensions.height100 * 0.6,
                                                                  width: Dimensions.height100 * 0.6,
                                                                  child: CachedNetworkImage(
                                                                    imageUrl: shopModel.image!,
                                                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                                        CircularProgressIndicator(value: downloadProgress.progress),
                                                                    errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.black),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                bottom: Dimensions.height20 * 1.2,
                                                                right: 0,
                                                                child: Container(
                                                                  height: Dimensions.height30 * 1,
                                                                  width: Dimensions.height30 * 1,
                                                                  decoration: const BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: Colors.white,
                                                                  ),
                                                                  child: const Icon(
                                                                    Icons.settings,
                                                                    color: AppColors.mainColor,
                                                                  ),
                                                                ),
                                                              )
                                                            ]),
                                                          )
                                                        : Container(
                                                            //margin: EdgeInsets.only(bottom: Dimensions.height10 * 2),
                                                            height: Dimensions.height100 * 1.5,
                                                            width: Dimensions.height100 * 1,
                                                            decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Colors.white,
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: SizedBox(
                                                              height: Dimensions.height100 * 0.6,
                                                              width: Dimensions.height100 * 0.6,
                                                              child: CachedNetworkImage(
                                                                imageUrl: shopModel.image!,
                                                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                                    CircularProgressIndicator(value: downloadProgress.progress),
                                                                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.black),
                                                              ),
                                                            ),
                                                          ),
                                                    //! text section

                                                    Container(
                                                      //decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(Dimensions.width20))),
                                                      //color: Colors.blueAccent,
                                                      height: Dimensions.height100 * 1.3,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          TextButton(
                                                            style: ButtonStyle(
                                                              backgroundColor: MaterialStateProperty.all<Color>(AppColors.greenEmerald),

                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(Dimensions.width20),
                                                                //side: BorderSide(color: Colors.red)
                                                              )),
                                                              //foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                            ),
                                                            onPressed: () {
                                                              Get.toNamed(RouteHelper.getAdminSearchPage(shopModel.id!));
                                                            },
                                                            child: Container(
                                                              margin:
                                                                  EdgeInsets.symmetric(horizontal: Dimensions.width10 / 2, vertical: Dimensions.height10 / 2),
                                                              child: Text(
                                                                "Vente opérateur ${(shopModel.name)!}",
                                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                                                              ),
                                                            ),
                                                          ),
                                                          (userModel.groups![index].name!.contains("chiefs"))
                                                              ? TextButton(
                                                                  style: ButtonStyle(
                                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(Dimensions.width20),
                                                                      //side: BorderSide(color: Colors.red)
                                                                    )),
                                                                    backgroundColor: MaterialStateProperty.all<Color>(AppColors.secondColor),
                                                                    //foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                                  ),
                                                                  onPressed: () {
                                                                    Get.toNamed(RouteHelper.getManagementShopPage(shopModel.id!));
                                                                  },
                                                                  child: Container(
                                                                    margin: EdgeInsets.symmetric(
                                                                        horizontal: Dimensions.width10 / 2, vertical: Dimensions.height10 / 2),
                                                                    child: Text(
                                                                      "Gestion magasin ${(shopModel.name)!}",
                                                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                                                                    ),
                                                                  ),
                                                                )
                                                              : Container(),
                                                        ],
                                                      ),
                                                    )
                                                  ]),
                                            ),
                                          );

                                          //ShopModel shopModel = shopController.shopList[];
                                        });
                                      } else {
                                        return Container();
                                      }
                                    }),
                              ),
                            ],
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 4,
                              color: AppColors.mainColor,
                            ),
                          );
                  }),
                ),
              ],
            ),
          )
        ]));
  }
}
