/*

  - page avec 

  


 */

import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../pages/home/welcome_page.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    Get.find<UserController>().getUserList(AppConstants.USERNAME);
    return Scaffold(
        extendBody: true,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: GetBuilder<UserController>(builder: (userController) {
                      if (Theme.of(context).scaffoldBackgroundColor == Theme.of(context).colorScheme.surface) {}
                      return (userController.isLoaded)
                          ? Stack(
                              children: [
                                //! Showing the header
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: Dimensions.height45 * 2.7,
                                      width: double.maxFinite,
                                      decoration: const BoxDecoration(),
                                      padding: EdgeInsets.only(top: Dimensions.height30 * 1.3, left: Dimensions.width20 * 1.5, right: Dimensions.width20),
                                      child: Center(
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(RouteHelper.getCartPage());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(top: Dimensions.height10),
                                                  width: Dimensions.height45 * 1.2,
                                                  height: Dimensions.height45 * 1.2,
                                                  child: Icon(
                                                    Icons.history_rounded,
                                                    color: Theme.of(context).colorScheme.surface,
                                                    size: Dimensions.height20 * 1.5,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(RouteHelper.getProfilepage());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(top: Dimensions.height10),
                                                  width: Dimensions.height45 * 1.2,
                                                  height: Dimensions.height45 * 1.2,
                                                  child: Icon(
                                                    Icons.settings_sharp,
                                                    color: Theme.of(context).colorScheme.surface,
                                                    size: Dimensions.height20 * 1.5,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height10 * 17,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: Dimensions.height20 * 10,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              borderRadius: const BorderRadius.only(topRight: Radius.circular(50))),
                                        ),
                                        Positioned(
                                          top: Dimensions.height10 * 2,
                                          left: Dimensions.height10 * 2 * 1.5,
                                          child: Text(
                                            "Solde:",
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                        ),
                                        Center(
                                          child: Column(
                                            children: [
                                              SizedBox(height: Dimensions.height20 * 1.8),
                                              Text(
                                                userController.userList[0].balance + "€",
                                                style: Theme.of(context).textTheme.titleLarge,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                Column(
                                  children: [
                                    SizedBox(
                                      height: Dimensions.height100 * 4.2,
                                    ),
                                    //! Showing the body
                                    const WelcomePage(),
                                    SizedBox(
                                      height: Dimensions.height100 * 0.5,
                                    ),
                                  ],
                                )
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
            ),
          ],
        ));
  }
}
