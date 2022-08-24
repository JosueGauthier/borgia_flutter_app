import 'package:borgiaflutterapp/admin/controller/create_category_controller.dart';
import 'package:borgiaflutterapp/admin/models/create_category_model.dart';
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
import '../../controller/salemodule_controller.dart';

class CreateCategoryPage extends StatefulWidget {
  final int shopId;
  const CreateCategoryPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<CreateCategoryPage> createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState extends State<CreateCategoryPage> {
  TextEditingController nameController = TextEditingController();
  var path = "";
  bool imageOk = false;
  String selectedModule = "Categorie opérateur";
  Map<String, IconData> mapModule = {
    "Categorie opérateur": Icons.manage_accounts_rounded,
    "Categorie selfsale": Icons.man,
  };
  List<DynamicWidget> dynamicList = [];
  int numberOfWidgets = 0;

  int selfModuleId = 0;
  int operatorModuleId = 0;

  //! use to select image
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

  //! use to select image
  static Future<CloudinaryResponse> uploadFileOnCloudinary({String filePath = "", CloudinaryResourceType resourceType = CloudinaryResourceType.Auto}) async {
    late CloudinaryResponse response;
    var cloudinary = AppConstants.CLOUDINARY_PUBLIC_VAR;
    response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(filePath, resourceType: resourceType),
    );

    return response;
  }

  //! to add products
  addDynamic() {
    setState(() {});
    if (dynamicList.length >= 50) {
      return;
    }
    numberOfWidgets = numberOfWidgets + 1;
    dynamicList.add(DynamicWidget(
      shopId: widget.shopId,
      idWidget: numberOfWidgets,
      productChoose: 0,
    ));
  }

  void _createCategory(
    CreateCategoryController createCategoryController,
  ) {
    String username = AppConstants.USERNAME;
    String password = AppConstants.PASSWORD;

    String categoryName = nameController.text.trim();
    int shopId = widget.shopId;
    String categoryImage = path;

    int moduleId;

    int contentTypeId;

    List<ProductList> productList = [];

    for (var i = 0; i < dynamicList.length; i++) {
      if (dynamicList[i].productChoose != 0) {
        ProductList productItem = ProductList(quantity: 99999, productId: dynamicList[i].productChoose);
        productList.add(productItem);
      }
    }

    if (selectedModule == "Categorie opérateur") {
      moduleId = operatorModuleId;

      //! if operatorModule => contentTypeId => 20
      contentTypeId = 20;
    } else {
      moduleId = selfModuleId;

      //! if selfModule => contentTypeId => 21
      contentTypeId = 21;
    }

    CreateCategoryModel categoryModel = CreateCategoryModel(
      username: username,
      password: password,
      shopId: shopId,
      productList: productList,
      categoryImage: categoryImage,
      contentTypeId: contentTypeId,
      moduleId: moduleId,
      nameCategory: categoryName,
    );

    if (categoryName == '' || categoryName.length >= 50) {
      Get.snackbar("Nom", "Nom de produit incorrect");
    } else {
      createCategoryController.createCategory(categoryModel).then((status) {
        if (status.isSuccess) {
          //! changer below
          Get.back();
          Get.back();
        } else {
          Get.snackbar("Erreur", "Catégorie non créée. Vérifier les informations saisies", backgroundColor: Colors.redAccent);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    Get.find<ProductListController>().getShopProduct(widget.shopId);
    addDynamic();
  }

  @override
  Widget build(BuildContext context) {
    //! To build multiple DropDownMenu
    Widget dynamicTextFieldWidget = ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dynamicList.length,
      itemBuilder: (_, index) => dynamicList[index],
    );

    return GetBuilder<CreateCategoryController>(builder: (createCategoryController) {
      return GetBuilder<ProductListController>(builder: (productListController) {
        return productListController.shopProductListIsLoaded
            ? Scaffold(
                extendBody: true,
                body: GetBuilder<SaleModuleController>(builder: (saleModuleController) {
                  for (var i = 0; i < saleModuleController.selfList.length; i++) {
                    if (saleModuleController.selfList[i].shop == widget.shopId) {
                      selfModuleId = saleModuleController.selfList[i].id;
                    }
                  }

                  for (var i = 0; i < saleModuleController.operatorList.length; i++) {
                    if (saleModuleController.operatorList[i].shop == widget.shopId) {
                      operatorModuleId = saleModuleController.operatorList[i].id;
                    }
                  }

                  return (saleModuleController.operatorListisLoaded && saleModuleController.selfListisLoaded)
                      ? Column(
                          children: [
                            const CustomHeader(text: "Création de la catégorie"),
                            Expanded(
                              child: SingleChildScrollView(
                                  child: Column(
                                children: [
                                  SizedBox(
                                    width: Dimensions.screenWidth - Dimensions.width20 * 3.4,
                                    child: ClipRRect(
                                      child: DropdownButton<String>(
                                        value: selectedModule,
                                        dropdownColor: AppColors.mainColor,
                                        borderRadius: BorderRadius.circular(Dimensions.height10 * 2),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedModule = newValue!;
                                          });
                                        },

                                        // Hide the default underline
                                        underline: Container(),

                                        icon: Icon(
                                          Icons.arrow_drop_down_rounded,
                                          color: Theme.of(context).colorScheme.onPrimary,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        isExpanded: true,

                                        // The list of options
                                        items: mapModule
                                            .map((text, value) {
                                              return MapEntry(
                                                  text,
                                                  DropdownMenuItem<String>(
                                                      value: text,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Icon(
                                                            value,
                                                            color: Theme.of(context).colorScheme.onPrimary,
                                                          ),
                                                          SizedBox(
                                                            width: Dimensions.height10,
                                                          ),
                                                          Text(
                                                            text,
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
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
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
                                        hintText: "Nom de la catégorie",
                                        labelText: "Nom de la catégorie",
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
                                      //_getFromGallery();

                                      path = await selectFile();

                                      setState(() {
                                        imageOk = true;
                                      });
                                    },
                                    child: SizedBox(
                                      width: double.maxFinite,

                                      //color: Colors.blueAccent,
                                      child: Row(
                                        children: [
                                          imageOk
                                              ? Container(
                                                  padding: EdgeInsets.only(right: Dimensions.width10, left: Dimensions.width10 * 1.5),
                                                  margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                                                  height: Dimensions.height45 * 1.7,
                                                  width: Dimensions.width45 * 6.2,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.mainColor,
                                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.width45)),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.image,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: Dimensions.width10,
                                                          ),
                                                          BigText(
                                                            fontTypo: 'Helvetica-Bold',
                                                            text: "Image de la catégorie",
                                                            size: Dimensions.height25 * 0.8,
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  padding: EdgeInsets.only(right: Dimensions.width10, left: Dimensions.width10 * 1.5),
                                                  margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                                                  height: Dimensions.height45 * 1.7,
                                                  width: Dimensions.screenWidth - Dimensions.width20 * 2,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.mainColor,
                                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.width45)),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.image,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: Dimensions.width10,
                                                          ),
                                                          BigText(
                                                            fontTypo: 'Helvetica-Bold',
                                                            text: "Image de la catégorie",
                                                            size: Dimensions.height25 * 0.8,
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          imageOk
                                              ? Container(
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
                                                      imageUrl: path,
                                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                          CircularProgressIndicator(value: downloadProgress.progress),
                                                      errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.black),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
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
                                      "Ajout de produit",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: Dimensions.width20),
                                    height: Dimensions.height100 / 2 + (Dimensions.height100 / 2) * dynamicList.length,
                                    //color: Colors.greenAccent,
                                    child: Center(child: dynamicTextFieldWidget),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _createCategory(createCategoryController);
                                    },
                                    child: SizedBox(
                                      width: Dimensions.width45 * 5,
                                      child: ProfileBox(
                                        textColor: Colors.white,
                                        backgroundcolor: AppColors.greenEmerald,
                                        icon: Icons.check,
                                        text: "Valider",
                                        iconcolor: Colors.white,
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
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            color: AppColors.mainColor,
                          ),
                        );
                }),
                floatingActionButton: FloatingActionButton(onPressed: addDynamic, child: const Icon(Icons.add, color: Colors.white)),
              )
            : const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: AppColors.mainColor,
                ),
              );
      });
    });
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
      "Choisir un item",
      "https://media.istockphoto.com/vectors/typing-text-chat-isolated-vector-icon-modern-geometric-illustration-vector-id1186972006?k=20&m=1186972006&s=612x612&w=0&h=vFGrVHgdRGWyUlDcW5KPfAXy5sfcjLg5Cl231ZF78hM="
    ]
  };

  @override
  void initState() {
    super.initState();

    Get.find<ProductListController>().getShopProduct(widget.shopId);

    productMap.addEntries(initItem.entries);

    widget.productChoose = productMap.keys.toList().first;
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
                  children: [
                    SizedBox(
                      width: Dimensions.screenWidth - Dimensions.width20 * 3.4,
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
    });
  }
}
