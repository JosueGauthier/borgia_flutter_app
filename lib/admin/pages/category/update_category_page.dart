import 'dart:developer';

import 'package:borgiaflutterapp/admin/controller/update_product_controller.dart';
import 'package:borgiaflutterapp/admin/models/update_product_model.dart';
import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/product_list_controller.dart';
import '../../../models/product_model.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/custom_header.dart';
import '../../../widget/product_item_widget.dart';
import '../../../widget/profile_box.dart';

class UpdateCategoryPage extends StatefulWidget {
  final int shopId;
  const UpdateCategoryPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<UpdateCategoryPage> createState() => _UpdateCategoryPageState();
}

class _UpdateCategoryPageState extends State<UpdateCategoryPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController correctingFactorController = TextEditingController();

  String path = "";

  bool isManualPriceChecked = true;
  bool isActiveChecked = true;

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

  bool productIsChoose = false;
  late ProductModel productModelChosen;

  void _updateProduct(
    UpdateProductController updateProductController,
  ) {
    String username = AppConstants.USERNAME;
    String password = AppConstants.PASSWORD;

    String productImage = "";
    String productName = "";
    double correctingFactor = 0;
    double manualPrice = 0;

    if (nameController.text.trim() == "") {
      productName = productModelChosen.name!;
    } else {
      productName = nameController.text.trim();
    }

    if (priceController.text.trim() == "") {
      manualPrice = productModelChosen.manualPrice!;
    } else {
      manualPrice = double.parse(priceController.text.trim());
    }

    bool priceIsManual = isManualPriceChecked;
    bool isActive = isActiveChecked;

    if (correctingFactorController.text.trim() == "") {
      correctingFactor = productModelChosen.correctingFactor!;
    } else {
      correctingFactor = double.parse(correctingFactorController.text.trim());
    }

    if (path == "") {
      productImage = productModelChosen.image!;
    } else {
      productImage = path;
    }

    UpdateProductModel productModel = UpdateProductModel(
      username: username,
      password: password,
      productId: productModelChosen.id!,
      correctingFactor: correctingFactor,
      isActive: isActive,
      manualPrice: manualPrice,
      priceIsManual: priceIsManual,
      productImage: productImage,
      productName: productName,
    );

    if (productName == '' || productName.length >= 50) {
      Get.snackbar("Nom", "Nom de produit incorrect");
    } else if (manualPrice <= 0) {
      Get.snackbar("Prix manuel", "Entrer un prix correct");
    } else {
      updateProductController.updateProduct(productModel).then((status) {
        if (status.isSuccess) {
          //! changer below
          Get.back();
        } else {
          Get.snackbar("Erreur", "Produit non modifi??. Verifier les informations saisies", backgroundColor: Colors.redAccent);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.find<ProductListController>().getShopProduct(widget.shopId);

    return GetBuilder<ProductListController>(builder: (productListController) {
      return GetBuilder<UpdateProductController>(builder: (updateProductController) {
        return Scaffold(
            extendBody: true,
            body: Column(
              children: [
                const CustomHeader(text: "Modification de produit"),
                Expanded(
                  child: SingleChildScrollView(
                    child: (productIsChoose)
                        ? Column(
                            children: [
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
                                    hintText: (productModelChosen.name != null) ? productModelChosen.name : "Nom du produit",
                                    labelText: (productModelChosen.name != null) ? productModelChosen.name : "Nom du produit",
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
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                                child: TextFormField(
                                  scrollPadding: EdgeInsets.only(bottom: Dimensions.height100),
                                  keyboardType: TextInputType.number,
                                  //inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                  controller: priceController,
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
                                      Icons.money,
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                    hintText: (productModelChosen.manualPrice != null) ? productModelChosen.manualPrice.toString() : "Prix manuel en ???",
                                    labelText: (productModelChosen.manualPrice != null) ? productModelChosen.manualPrice.toString() : "Prix manuel en ???",
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
                                    path;
                                  });
                                },
                                child: SizedBox(
                                  width: double.maxFinite,

                                  //color: Colors.blueAccent,
                                  child: Row(
                                    children: [
                                      (productModelChosen.image != null)
                                          ? SizedBox(
                                              width: Dimensions.width45 * 7,
                                              child: ProfileBox(
                                                textColor: Theme.of(context).colorScheme.onPrimary,
                                                backgroundcolor: AppColors.mainColor,
                                                icon: Icons.image,
                                                text: "Image du produit",
                                                iconcolor: Theme.of(context).colorScheme.onPrimary,
                                                radius: Dimensions.width45,
                                                isEditable: false,
                                              ),
                                            )
                                          : SizedBox(
                                              width: Dimensions.screenWidth,
                                              child: ProfileBox(
                                                textColor: Theme.of(context).colorScheme.onPrimary,
                                                backgroundcolor: AppColors.mainColor,
                                                icon: Icons.image,
                                                text: "Image du produit",
                                                iconcolor: Theme.of(context).colorScheme.onPrimary,
                                                radius: Dimensions.width45,
                                                isEditable: false,
                                              ),
                                            ),
                                      (productModelChosen.image != null)
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
                                                child: Image.network(path),
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
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isManualPriceChecked = !isManualPriceChecked;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                                  margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                                  height: Dimensions.height45 * 1.7,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.all(Radius.circular(Dimensions.width45))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            checkColor: Colors.white,
                                            //fillColor: MaterialStateProperty.resolveWith(getColor),
                                            value: isManualPriceChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isManualPriceChecked = value!;
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: Dimensions.width20,
                                          ),
                                          BigText(
                                            fontTypo: 'Helvetica-Bold',
                                            text: "Prix manuel ?",
                                            size: Dimensions.height25 * 0.8,
                                            color: Theme.of(context).colorScheme.onPrimary,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isActiveChecked = !isActiveChecked;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                                  margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                                  height: Dimensions.height45 * 1.7,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.all(Radius.circular(Dimensions.width45))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            checkColor: Colors.white,
                                            //fillColor: MaterialStateProperty.resolveWith(getColor),
                                            value: isActiveChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isActiveChecked = value!;
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: Dimensions.width20,
                                          ),
                                          BigText(
                                            fontTypo: 'Helvetica-Bold',
                                            text: "Produit activ?? ?",
                                            size: Dimensions.height25 * 0.8,
                                            color: Theme.of(context).colorScheme.onPrimary,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  //inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                  scrollPadding: EdgeInsets.only(bottom: Dimensions.height100),
                                  controller: correctingFactorController,
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
                                      Icons.change_circle,
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                    hintText: (productModelChosen.correctingFactor != null)
                                        ? productModelChosen.correctingFactor.toString()
                                        : "Facteur de correction",
                                    labelText: (productModelChosen.correctingFactor != null)
                                        ? productModelChosen.correctingFactor.toString()
                                        : "Facteur de correction",
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
                                onTap: () {
                                  _updateProduct(updateProductController);
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
                              )
                            ],
                          )
                        : (productListController.shopProductListIsLoaded)
                            ? Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.only(right: Dimensions.width20, left: Dimensions.width20),
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: productListController.shopProductList.length,
                                    itemBuilder: (context, index) {
                                      ProductModel productModel = productListController.shopProductList[index];
                                      return GestureDetector(
                                          onTap: () {
                                            productModelChosen = productModel;

                                            setState(() {
                                              productIsChoose = true;

                                              isManualPriceChecked = productModelChosen.isManual!;
                                              isActiveChecked = productModelChosen.isActive!;
                                              path = productModelChosen.image!;
                                            });
                                          },
                                          child: ProductItemWidget(
                                            titleText: (productModel.name)!.capitalize!,
                                            illustImage: CachedNetworkImage(
                                              imageUrl: productModel.image!,
                                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                  CircularProgressIndicator(value: downloadProgress.progress),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                            ),
                                            priceProduct: productModel.manualPrice.toString(),
                                          ));
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
