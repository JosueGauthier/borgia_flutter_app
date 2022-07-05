import 'dart:developer';

import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/shop_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/shop_model.dart';
import '../../pages/home/welcome_page.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Column(
          children: [
            CustomHeader(text: "Admin"),
            Expanded(
              child: Stack(
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
                          ? Container(
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

                                      print(isChiefIn);

                                      return GetBuilder<ShopController>(builder: (shopController) {
                                        inspect(shopController.shopList);
                                        print(isChiefIn[isChiefIn.length - 1]);

                                        ShopModel shopModel =
                                            shopController.shopList.firstWhere((element) => (element.name == isChiefIn[isChiefIn.length - 1]));

                                        inspect(shopModel);

                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(RouteHelper.getCategoryListPage(shopModel.id!, "home"));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: Dimensions.height15),
                                            child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                              //! image section

                                              Container(
                                                //margin: EdgeInsets.only(bottom: Dimensions.height10 * 2),
                                                height: Dimensions.height100 * 0.7,
                                                width: Dimensions.height100 * 0.7,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  height: Dimensions.height100 * 0.5,
                                                  width: Dimensions.height100 * 0.5,
                                                  child: CachedNetworkImage(
                                                    imageUrl: shopModel.image!,
                                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                        CircularProgressIndicator(value: downloadProgress.progress),
                                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width20 * 3,
                                              ),

                                              //! text section

                                              Container(
                                                //margin: EdgeInsets.only(bottom: Dimensions.height10 * 2),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Gestion " + nameStringSplit[0] + " " + (shopModel.name)!,
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                ),
                                              ),
                                            ]),
                                          ),
                                        );

                                        //ShopModel shopModel = shopController.shopList[];
                                      });
                                    } else {
                                      return Container();
                                    }
                                  }),
                            )
                          : Container();
                    }),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
