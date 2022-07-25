import 'package:borgiaflutterapp/admin/controller/delete_category_controller.dart';
import 'package:borgiaflutterapp/admin/models/delete_category_model.dart';
import 'package:borgiaflutterapp/controllers/category_controller.dart';
import 'package:borgiaflutterapp/models/categories_shop_model.dart';
import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/dimensions.dart';
import '../../../widget/custom_header.dart';
import '../../../widget/profile_box.dart';

class DeleteCategoryPage extends StatefulWidget {
  final int shopId;
  const DeleteCategoryPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<DeleteCategoryPage> createState() => _DeleteCategoryPageState();
}

class _DeleteCategoryPageState extends State<DeleteCategoryPage> {
  bool categoryIsChoose = false;
  late CategoryOfShopModel categoryModelChosen;

  void _deleteCategory(
    DeleteCategoryController deleteCategoryController,
  ) {
    String username = AppConstants.USERNAME;
    String password = AppConstants.PASSWORD;

    DeleteCategoryModel categoryModel = DeleteCategoryModel(
      username: username,
      password: password,
      categoryId: categoryModelChosen.id!,
    );

    deleteCategoryController.deleteCategory(categoryModel).then((status) {
      if (status.isSuccess) {
        //! changer below
        Get.back();
        Get.back();
      } else {
        Get.snackbar("Erreur", "Produit non supprimé. Verifier les informations saisies", backgroundColor: Colors.redAccent);
      }
    });
  }

  showAlertDialog(BuildContext context, DeleteCategoryController deleteCategoryController) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: Theme.of(context).textTheme.labelLarge,
      ),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Continue",
        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.redAccent),
      ),
      onPressed: () {
        _deleteCategory(deleteCategoryController);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        categoryModelChosen.name!.capitalize!,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      content: Text(
        "Etes vous sur de vouloir supprimer cette catégorie ?\n\nCette action est irréversible ! ",
        style: Theme.of(context).textTheme.titleSmall,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.find<CategoryOfShopController>().getAllCategoryList(widget.shopId);

    return GetBuilder<CategoryOfShopController>(builder: (categoryOfShopController) {
      return GetBuilder<DeleteCategoryController>(builder: (deleteCategoryController) {
        return Scaffold(
            extendBody: true,
            body: Column(
              children: [
                const CustomHeader(text: "Suppression d'une catégorie"),
                Expanded(
                  child: SingleChildScrollView(
                    child: (categoryIsChoose)
                        ? Column(
                            children: [
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showAlertDialog(context, deleteCategoryController);
                                },
                                child: SizedBox(
                                  width: Dimensions.width45 * 6,
                                  child: ProfileBox(
                                    textColor: Theme.of(context).colorScheme.onPrimary,
                                    backgroundcolor: Colors.redAccent,
                                    icon: Icons.delete,
                                    text: "Supprimer",
                                    iconcolor: Theme.of(context).colorScheme.onPrimary,
                                    radius: Dimensions.width45,
                                    isEditable: false,
                                  ),
                                ),
                              )
                            ],
                          )
                        : (categoryOfShopController.allCategoriesListIsLoaded)
                            ? Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: categoryOfShopController.allCategoriesList.length,
                                    itemBuilder: (context, index) {
                                      CategoryOfShopModel categoryOfShopModel = categoryOfShopController.allCategoriesList[index];
                                      print(categoryOfShopModel.image);
                                      return GestureDetector(
                                        onTap: () {
                                          categoryModelChosen = categoryOfShopModel;

                                          setState(() {
                                            categoryIsChoose = true;
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: Dimensions.width20, bottom: Dimensions.height15),
                                          child: Row(children: [
                                            //! image

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
                                                  imageUrl: categoryOfShopModel.image!,
                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                      CircularProgressIndicator(value: downloadProgress.progress),
                                                  errorWidget: (context, url, error) => Icon(
                                                    Icons.error,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: Dimensions.width20 * 3,
                                            ),

                                            //! text section

                                            Expanded(
                                              child: Padding(
                                                  padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                                  child: Text((categoryOfShopModel.name)!.capitalize!, style: Theme.of(context).textTheme.bodySmall)),
                                            ),
                                          ]),
                                        ),
                                      );
                                    }),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 4,
                                  color: AppColors.mainColor,
                                ),
                              ),
                  ),
                ),
              ],
            ));
      });
    });
  }
}
