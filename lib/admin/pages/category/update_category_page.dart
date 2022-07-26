import 'package:borgiaflutterapp/admin/controller/update_category_controller.dart';
import 'package:borgiaflutterapp/admin/models/update_category_model.dart';
import 'package:borgiaflutterapp/controllers/category_controller.dart';
import 'package:borgiaflutterapp/models/categories_shop_model.dart';
import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/product_list_controller.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/custom_header.dart';
import '../../../widget/profile_box.dart';

class UpdateCategoryPage extends StatefulWidget {
  final int shopId;
  const UpdateCategoryPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<UpdateCategoryPage> createState() => _UpdateCategoryPageState();
}

class _UpdateCategoryPageState extends State<UpdateCategoryPage> {
  TextEditingController nameController = TextEditingController();

  late CategoryModel categoryModelChosen;

  bool categoryIsChoose = false;

  bool productinit = false;

  var path = "";
  bool imageOk = false;

  List<DynamicWidget> dynamicList = [];
  int numberOfWidgets = 0;

  static Future<String> selectFile() async {
    late CloudinaryResponse response;

    var result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );

    if (result != null) {
      for (PlatformFile file in result.files) {
        if (file.path != null) {
          response = await uploadFileOnCloudinary(
            filePath: file.path!,
            resourceType: CloudinaryResourceType.Auto,
          );
        }
      }
    }

    return response.secureUrl;
  }

  static Future<CloudinaryResponse> uploadFileOnCloudinary({String filePath = "", CloudinaryResourceType resourceType = CloudinaryResourceType.Auto}) async {
    late CloudinaryResponse response;

    var cloudinary = CloudinaryPublic('dxsy9rszs', 'borgia', cache: false);
    response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(filePath, resourceType: resourceType),
    );
    return response;
  }

  void _updateCategory(
    UpdateCategoryController updateCategoryController,
  ) {
    String username = AppConstants.USERNAME;
    String password = AppConstants.PASSWORD;

    String categoryName = "";

    String categoryImage = path;

    List<ProductList> productList = [];

    for (var i = 0; i < dynamicList.length; i++) {
      if (dynamicList[i].productChoose != 0) {
        ProductList productItem = ProductList(quantity: 99999, productId: dynamicList[i].productChoose);
        productList.add(productItem);
      }
    }

    if (nameController.text.trim() == "") {
      categoryName = categoryModelChosen.name!;
    } else {
      categoryName = nameController.text.trim();
    }

    if (path == "") {
      categoryImage = categoryModelChosen.image!;
    } else {
      categoryImage = path;
    }

    UpdateCategoryModel updateCategoryModel = UpdateCategoryModel(
      username: username,
      password: password,
      categoryId: categoryModelChosen.id!,
      categoryImage: categoryImage,
      nameCategory: categoryName,
      productList: [],
    );

    if (categoryName == '' || categoryName.length >= 50) {
      Get.snackbar("Nom", "Nom de catégorie incorrect");
    } else {
      updateCategoryController.updateCategory(updateCategoryModel).then((status) {
        if (status.isSuccess) {
          //! changer below
          Get.back();
        } else {
          Get.snackbar("Erreur", "Catégorie non modifiée. Vérifier les informations saisies", backgroundColor: Colors.redAccent);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    Get.find<ProductListController>().getShopProduct(widget.shopId);

    //! check if no product !
  }

  @override
  Widget build(BuildContext context) {
    Get.find<CategoryOfShopController>().getAllCategoryList(widget.shopId);

    return GetBuilder<CategoryOfShopController>(builder: (categoryOfShopController) {
      return GetBuilder<UpdateCategoryController>(builder: (updateCategoryController) {
        return Scaffold(
            extendBody: true,
            body: Column(
              children: [
                const CustomHeader(text: "Modification d'une catégorie"),
                Expanded(
                  child: SingleChildScrollView(
                    child: (categoryIsChoose)
                        ? Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                                child: TextFormField(
                                  scrollPadding: EdgeInsets.only(bottom: Dimensions.height100),
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: AppColors.titleColor),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: AppColors.mainColor),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.bookmark,
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                    hintText: categoryModelChosen.name,
                                    labelText: categoryModelChosen.name,
                                    labelStyle: Theme.of(context).textTheme.bodySmall,
                                    hintStyle: Theme.of(context).textTheme.bodySmall,
                                    filled: true,
                                    fillColor: Colors.transparent,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  path = await selectFile();

                                  setState(() {
                                    imageOk = true;
                                  });
                                },
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(right: Dimensions.width10, left: Dimensions.width10 * 1.5),
                                        margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                                        height: Dimensions.height45 * 1.7,
                                        width: Dimensions.width45 * 6.2,
                                        decoration: BoxDecoration(
                                          color: AppColors.mainColor,
                                          borderRadius: BorderRadius.all(Radius.circular(Dimensions.width45)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.mainColor.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 5,
                                              blurStyle: BlurStyle.normal,
                                              offset: const Offset(0, 0), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.image,
                                                  color: Theme.of(context).colorScheme.onPrimary,
                                                ),
                                                SizedBox(
                                                  width: Dimensions.width10,
                                                ),
                                                BigText(
                                                  fontTypo: 'Helvetica-Bold',
                                                  text: "Image de la catégorie",
                                                  size: Dimensions.height25 * 0.8,
                                                  color: Theme.of(context).colorScheme.onPrimary,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
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
                                            imageUrl: categoryModelChosen.image!,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                CircularProgressIndicator(value: downloadProgress.progress),
                                            errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.black),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: Dimensions.width20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Modification de la liste des produits",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              GetBuilder<ProductListController>(builder: (productListController) {
                                List productList = productListController.productList;
                                return (productListController.isLoaded && productListController.shopProductListIsLoaded)
                                    ? ListItem(
                                        listOfOldProd: productList,
                                        shopId: widget.shopId,
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 4,
                                          color: Colors.blueAccent,
                                        ),
                                      );
                              }),
                              GestureDetector(
                                onTap: () {
                                  _updateCategory(updateCategoryController);
                                },
                                child: SizedBox(
                                  width: Dimensions.width45 * 5,
                                  child: ProfileBox(
                                    textColor: Theme.of(context).colorScheme.onPrimary,
                                    backgroundcolor: AppColors.greenEmerald,
                                    icon: Icons.check,
                                    text: "Valider",
                                    iconcolor: Theme.of(context).colorScheme.onPrimary,
                                    radius: Dimensions.width45,
                                    isEditable: false,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
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
                                      CategoryModel categoryOfShopModel = categoryOfShopController.allCategoriesList[index];
                                      return GestureDetector(
                                        onTap: () {
                                          categoryModelChosen = categoryOfShopModel;

                                          Get.find<ProductListController>().getProduct(categoryModelChosen.id!);

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
                                                    errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.black)),
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

// ignore: must_be_immutable
class ListItem extends StatefulWidget {
  List listOfOldProd;
  int shopId;

  ListItem({Key? key, required this.listOfOldProd, required this.shopId}) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  List<DynamicWidget> dynamicList = [];
  int numberOfWidgets = 0;

  addDynamic() {
    numberOfWidgets = numberOfWidgets + 1;
    dynamicList.add(DynamicWidget(
      shopId: widget.shopId,
      idWidget: numberOfWidgets,
      productChoose: 0,
    ));
    setState(() {});
    print("aa");
    print(numberOfWidgets);
  }

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.listOfOldProd.length; i++) {
      numberOfWidgets = numberOfWidgets + 1;
      dynamicList.add(DynamicWidget(
        shopId: widget.shopId,
        idWidget: numberOfWidgets,
        productChoose: widget.listOfOldProd[i].id,
      ));
    }

    //addDynamic();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dynamicList.length,
          itemBuilder: (_, index) => dynamicList[index],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: addDynamic(), child: const Icon(Icons.add)),
          ],
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

  @override
  void initState() {
    super.initState();

    productMap.addEntries(initItem.entries);

    //widget.productChoose = productMap.keys.toList().first;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductListController>(builder: (productListController) {
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
                    Container(
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                    )
                  ],
                )
              ],
            )
          : Container();
    });
  }
}
