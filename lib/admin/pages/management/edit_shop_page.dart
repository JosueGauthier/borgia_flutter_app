import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/custom_header.dart';
import '../../../widget/profile_box.dart';
import '../../controller/update_product_controller.dart';
import '../../models/update_product_model.dart';

class EditShopPage extends StatefulWidget {
  final int shopId;
  const EditShopPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<EditShopPage> createState() => _EditShopPageState();
}

class _EditShopPageState extends State<EditShopPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String path = "";

  bool correctingFactorActivated = true;
  bool selfSaleModuleActivated = true;
  bool operatorSaleModuleActivated = true;

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
  late ShopModel shopModel;

  void _updateShop(
    UpdateProductController updateProductController,
  ) {
    String username = AppConstants.USERNAME;
    String password = AppConstants.PASSWORD;

    String productImage = "";
    String productName = "";
    double correctingFactor = 0;
    double manualPrice = 0;

    if (nameController.text.trim() == "") {
      productName = shopModel.name!;
    } else {
      productName = nameController.text.trim();
    }

    if (descriptionController.text.trim() == "") {
      //manualPrice = shopModel.manualPrice!;
    } else {
      manualPrice = double.parse(descriptionController.text.trim());
    }

    bool priceIsManual = correctingFactorActivated;
    bool isActive = selfSaleModuleActivated;

    if (path == "") {
      productImage = shopModel.image!;
    } else {
      productImage = path;
    }

    UpdateProductModel productModel = UpdateProductModel(
      username: username,
      password: password,
      productId: shopModel.id!,
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
          Get.back();
        } else {
          Get.snackbar("Erreur", "Magasin non modifié. Vérifier les informations saisies", backgroundColor: Colors.redAccent);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    path = shopModel.image!;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateProductController>(builder: (updateProductController) {
      return Scaffold(
          extendBody: true,
          body: Column(
            children: [
              const CustomHeader(text: "Modification"),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
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
                          hintText: (shopModel.name != null) ? shopModel.name : "Nom du magasin",
                          labelText: (shopModel.name != null) ? shopModel.name : "Nom du magasin",
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
                        controller: descriptionController,
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
                          //hintText: (shopModel.manualPrice != null) ? shopModel.manualPrice.toString() : "Prix manuel en €",
                          //labelText: (shopModel.manualPrice != null) ? shopModel.manualPrice.toString() : "Prix manuel en €",
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
                            (shopModel.image != null)
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
                            (shopModel.image != null)
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
                          correctingFactorActivated = !correctingFactorActivated;
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
                                  value: correctingFactorActivated,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      correctingFactorActivated = value!;
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
                          selfSaleModuleActivated = !selfSaleModuleActivated;
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
                                  value: selfSaleModuleActivated,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      selfSaleModuleActivated = value!;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: Dimensions.width20,
                                ),
                                BigText(
                                  fontTypo: 'Helvetica-Bold',
                                  text: "Produit activé ?",
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
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _updateShop(updateProductController);
                      },
                      child: SizedBox(
                        width: Dimensions.width45 * 5,
                        child: ProfileBox(
                          textColor: Theme.of(context).colorScheme.onPrimary,
                          backgroundcolor: AppColors.greenEmerald,
                          icon: Icons.check,
                          text: "Modifier",
                          iconcolor: Theme.of(context).colorScheme.onPrimary,
                          radius: Dimensions.width45,
                          isEditable: false,
                        ),
                      ),
                    )
                  ],
                )),
              ),
            ],
          ));
    });
  }
}
