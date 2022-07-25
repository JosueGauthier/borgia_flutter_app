import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/route_helper.dart';
import '../../../utils/dimensions.dart';
import '../../../widget/custom_header.dart';
import '../../../widget/profile_box.dart';
import '../../controller/salemodule_controller.dart';

class ManagementShopPage extends StatefulWidget {
  final int shopId;
  const ManagementShopPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<ManagementShopPage> createState() => _ManagementShopPageState();
}

class _ManagementShopPageState extends State<ManagementShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Column(
          children: [
            const CustomHeader(text: "Management"),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: Dimensions.width20 * 1.5),
                    child: Text(
                      "Produit",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getCreateProductPage(widget.shopId));
                    },
                    child: SizedBox(
                      width: Dimensions.screenWidth,
                      child: ProfileBox(
                        textColor: Theme.of(context).colorScheme.surface,
                        backgroundcolor: AppColors.greenEmerald,
                        icon: Icons.create,
                        text: "Création d'un produit",
                        iconcolor: Theme.of(context).colorScheme.surface,
                        radius: Dimensions.width45,
                        isEditable: false,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getUpdateProductPage(widget.shopId));
                    },
                    child: SizedBox(
                      width: Dimensions.screenWidth,
                      child: ProfileBox(
                        textColor: Theme.of(context).colorScheme.surface,
                        backgroundcolor: AppColors.secondColor,
                        icon: Icons.edit_note,
                        text: "Modification d'un produit",
                        iconcolor: Theme.of(context).colorScheme.surface,
                        radius: Dimensions.width45,
                        isEditable: false,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getDeleteProductPage(widget.shopId));
                    },
                    child: SizedBox(
                      width: Dimensions.screenWidth,
                      child: ProfileBox(
                        textColor: Theme.of(context).colorScheme.surface,
                        backgroundcolor: AppColors.mainColor,
                        icon: Icons.delete,
                        text: "Suppression d'un produit",
                        iconcolor: Theme.of(context).colorScheme.surface,
                        radius: Dimensions.width45,
                        isEditable: false,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: Dimensions.width20 * 1.5),
                    child: Text(
                      "Catégories",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getCreateCategoryPage(widget.shopId));
                    },
                    child: SizedBox(
                      width: Dimensions.screenWidth,
                      child: ProfileBox(
                        textColor: Theme.of(context).colorScheme.surface,
                        backgroundcolor: AppColors.greenEmerald,
                        icon: Icons.create,
                        text: "Création d'une catégorie",
                        iconcolor: Theme.of(context).colorScheme.surface,
                        radius: Dimensions.width45,
                        isEditable: false,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  GestureDetector(
                    onTap: () {
                      //Get.toNamed(RouteHelper.getGenPage());
                    },
                    child: SizedBox(
                      width: Dimensions.screenWidth,
                      child: ProfileBox(
                        textColor: Theme.of(context).colorScheme.surface,
                        backgroundcolor: AppColors.secondColor,
                        icon: Icons.edit_note,
                        text: "Modification d'une catégorie",
                        iconcolor: Theme.of(context).colorScheme.surface,
                        radius: Dimensions.width45,
                        isEditable: false,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getDeleteCategoryPage(widget.shopId));
                    },
                    child: SizedBox(
                      width: Dimensions.screenWidth,
                      child: ProfileBox(
                        textColor: Theme.of(context).colorScheme.surface,
                        backgroundcolor: AppColors.mainColor,
                        icon: Icons.delete,
                        text: "Suppression d'une catégorie",
                        iconcolor: Theme.of(context).colorScheme.surface,
                        radius: Dimensions.width45,
                        isEditable: false,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                ],
              )),
            ),
          ],
        ));
  }
}
