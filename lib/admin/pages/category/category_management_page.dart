import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/category_controller.dart';
import '../../../controllers/product_list_controller.dart';
import '../../../models/categories_shop_model.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../controller/delete_category_controller.dart';
import '../../models/delete_category_model.dart';

late CategoryModel categoryModelChoose;

class CategoryManagementPage extends StatefulWidget {
  final int shopId;
  const CategoryManagementPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<CategoryManagementPage> createState() => _CategoryManagementPageState();
}

class _CategoryManagementPageState extends State<CategoryManagementPage> {
  void _deleteCategory(
    DeleteCategoryController deleteCategoryController,
  ) {
    String username = AppConstants.USERNAME;
    String password = AppConstants.PASSWORD;

    DeleteCategoryModel categoryModel = DeleteCategoryModel(
      username: username,
      password: password,
      categoryId: categoryModelChoose.id!,
    );

    deleteCategoryController.deleteCategory(categoryModel).then((status) {
      if (status.isSuccess) {
        //! changer below
        Get.back();
        Get.back();
      } else {
        Get.snackbar("Erreur", "Catégorie non supprimée. Vérifier les informations saisies", backgroundColor: Colors.redAccent);
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
        categoryModelChoose.name!.capitalize!,
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
  void initState() {
    super.initState();

    Get.find<ProductListController>().getShopProduct(widget.shopId);
  }

  @override
  Widget build(BuildContext context) {
    Get.find<CategoryOfShopController>().getAllCategoryList(widget.shopId);

    return GetBuilder<CategoryOfShopController>(builder: (categoryOfShopController) {
      return GetBuilder<DeleteCategoryController>(builder: (deleteCategoryController) {
        return Scaffold(
            extendBody: true,
            floatingActionButton: FloatingActionButton(
                backgroundColor: AppColors.secondColor,
                onPressed: () {
                  Get.toNamed(RouteHelper.getCreateCategoryPage(widget.shopId));
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
            body: Column(
              children: [
                Container(
                  height: Dimensions.height20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: (categoryOfShopController.allCategoriesListIsLoaded)
                        ? Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20, bottom: Dimensions.height20 * 3),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: categoryOfShopController.allCategoriesList.length,
                                itemBuilder: (context, index) {
                                  CategoryModel categoryOfShopModel = categoryOfShopController.allCategoriesList[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom: Dimensions.height15),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      //! image

                                      GestureDetector(
                                        onTap: () {
                                          categoryModelChoose = categoryOfShopModel;

                                          Get.find<ProductListController>().getProduct(categoryModelChoose.id!);
                                          Get.toNamed(RouteHelper.getUpdateCategoryPage(widget.shopId));
                                        },
                                        child: Container(
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
                                                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.black)),
                                          ),
                                        ),
                                      ),

                                      //! text section
                                      GestureDetector(
                                        onTap: () {
                                          categoryModelChoose = categoryOfShopModel;

                                          Get.find<ProductListController>().getProduct(categoryModelChoose.id!);
                                        },
                                        child: SizedBox(
                                            height: Dimensions.height100 * 0.7,
                                            child: Center(child: Text((categoryOfShopModel.name)!.capitalize!, style: Theme.of(context).textTheme.bodySmall))),
                                      ),

                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              categoryModelChoose = categoryOfShopModel;

                                              Get.find<ProductListController>().getProduct(categoryModelChoose.id!);
                                            },
                                            child: const Icon(
                                              Icons.edit,
                                              color: AppColors.greenEmerald,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimensions.width20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showAlertDialog(context, deleteCategoryController);
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                            ),
                                          )
                                        ],
                                      )
                                    ]),
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

// ignore: must_be_immutable
class ListItem extends StatefulWidget {
  List listOfOldProd;
  int shopId;
  List<DynamicWidget> dynamicList;

  ListItem({Key? key, required this.listOfOldProd, required this.shopId, required this.dynamicList}) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  int numberOfWidgets = 0;

  addDynamic() {
    numberOfWidgets = numberOfWidgets + 1;
    widget.dynamicList.add(DynamicWidget(
      shopId: widget.shopId,
      idWidget: numberOfWidgets,
      productChoose: 0,
    ));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.listOfOldProd.length; i++) {
      numberOfWidgets = numberOfWidgets + 1;
      widget.dynamicList.add(DynamicWidget(
        shopId: widget.shopId,
        idWidget: numberOfWidgets,
        productChoose: widget.listOfOldProd[i].id,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: Dimensions.width20),
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.dynamicList.length,
            itemBuilder: (_, index) => widget.dynamicList[index],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: Dimensions.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {},
                  child: FloatingActionButton(
                      onPressed: () {
                        addDynamic();
                        setState(() {});
                      },
                      child: const Icon(Icons.add))),
            ],
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class DynamicWidget extends StatefulWidget {
  final int shopId;
  final int idWidget;
  int productChoose;
  DynamicWidget({Key? key, required this.shopId, required this.idWidget, required this.productChoose}) : super(key: key);

  @override
  State<DynamicWidget> createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  Map<int, List> productMap = {};

  var initItem = <int, List>{
    0: [
      "Choose item",
      "https://media.istockphoto.com/vectors/typing-text-chat-isolated-vector-icon-modern-geometric-illustration-vector-id1186972006?k=20&m=1186972006&s=612x612&w=0&h=vFGrVHgdRGWyUlDcW5KPfAXy5sfcjLg5Cl231ZF78hM="
    ]
  };

  bool isDeleted = false;

  @override
  void initState() {
    super.initState();

    productMap.addEntries(initItem.entries);

    //widget.productChoose = productMap.keys.toList().first;
  }

  @override
  Widget build(BuildContext context) {
    return (isDeleted == false)
        ? GetBuilder<ProductListController>(builder: (productListController) {
            for (var i = 0; i < productListController.shopProductList.length; i++) {
              int id = productListController.shopProductList[i].id;
              String nom = productListController.shopProductList[i].name;
              String image = productListController.shopProductList[i].image;

              var produit = <int, List>{
                id: [nom, image]
              };

              productMap.addEntries(produit.entries);
            }

            return productListController.shopProductListIsLoaded
                ? ListBody(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            //color: Colors.redAccent,
                            width: Dimensions.screenWidth - Dimensions.width20 * 5,
                            height: Dimensions.height10 * 7,
                            child: ClipRRect(
                              child: DropdownButton<int>(
                                value: widget.productChoose,
                                dropdownColor: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(Dimensions.height10 * 2),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    widget.productChoose = newValue!;
                                  });
                                },

                                // Hide the default underline
                                underline: Container(),

                                icon: Center(
                                  child: Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    size: Dimensions.height10 * 5,
                                  ),
                                ),
                                isExpanded: true,

                                // The list of options
                                items: productMap
                                    .map((id, list) {
                                      return MapEntry(
                                          id,
                                          DropdownMenuItem<int>(
                                              value: id,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: Dimensions.height100 * 0.5,
                                                    width: Dimensions.height100 * 0.5,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      height: Dimensions.height100 * 0.3,
                                                      width: Dimensions.height100 * 0.3,
                                                      child: Image.network(list[1]),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Dimensions.height10,
                                                  ),
                                                  Text(
                                                    list[0],
                                                    style: Theme.of(context).textTheme.bodySmall,
                                                  ),
                                                ],
                                              )));
                                    })
                                    .values
                                    .toList(),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.productChoose = 0;

                              isDeleted = true;

                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                : Container();
          })
        : Container();
  }
}
