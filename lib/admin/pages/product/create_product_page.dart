import 'package:borgiaflutterapp/admin/controller/create_product_controller.dart';
import 'package:borgiaflutterapp/admin/models/create_product_model.dart';
import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/custom_header.dart';
import '../../../widget/profile_box.dart';

class CreateProductPage extends StatefulWidget {
  final int shopId;
  const CreateProductPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController correctingFactorController = TextEditingController();

  var path = "";
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

  bool imageOk = false;

  void _createProduct(
    CreateProductController createProductController,
  ) {
    String username = AppConstants.USERNAME;
    String password = AppConstants.PASSWORD;

    String productName = nameController.text.trim();
    bool priceIsManual = isManualPriceChecked;
    double manualPrice = double.parse(priceController.text.trim());
    int shopId = widget.shopId;
    bool isActive = isActiveChecked;
    double correctingFactor = double.parse(correctingFactorController.text.trim());
    String productImage = path;

    CreateProductModel productModel = CreateProductModel(
      username: username,
      password: password,
      correctingFactor: correctingFactor,
      isActive: isActive,
      manualPrice: manualPrice,
      priceIsManual: priceIsManual,
      productImage: productImage,
      productName: productName,
      shopId: shopId,
    );

    if (productName == '' || productName.length >= 50) {
      Get.snackbar("Nom", "Nom de produit incorrect");
    } else if (manualPrice <= 0) {
      Get.snackbar("Prix manuel", "Entrer un prix correct");
    } else {
      createProductController.createProduct(productModel).then((status) {
        if (status.isSuccess) {
          //! changer below
          Get.back();
          Get.back();
        } else {
          Get.snackbar("Erreur", "Produit non créé. Vérifier les informations saisies", backgroundColor: Colors.redAccent);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateProductController>(builder: (createProductController) {
      return Scaffold(
          extendBody: true,
          body: Column(
            children: [
              const CustomHeader(text: "Création de produit"),
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
                          hintText: "Nom du produit",
                          labelText: "Nom du produit",
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
                          prefixIcon: const Icon(
                            Icons.money,
                            color: Colors.white,
                          ),
                          hintText: "Prix manuel en €",
                          labelText: "Prix manuel en €",
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
                                ? SizedBox(
                                    width: Dimensions.width45 * 7,
                                    child: ProfileBox(
                                      textColor: Colors.white,
                                      backgroundcolor: AppColors.mainColor,
                                      icon: Icons.image,
                                      text: "Image du produit",
                                      iconcolor: Colors.white,
                                      radius: Dimensions.width45,
                                      isEditable: false,
                                    ),
                                  )
                                : SizedBox(
                                    width: Dimensions.screenWidth,
                                    child: ProfileBox(
                                      textColor: Colors.white,
                                      backgroundcolor: AppColors.mainColor,
                                      icon: Icons.image,
                                      text: "Image du produit",
                                      iconcolor: Colors.white,
                                      radius: Dimensions.width45,
                                      isEditable: false,
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
                                Transform.scale(
                                  scale: 1.2,
                                  child: Checkbox(
                                    checkColor: AppColors.mainColor,
                                    shape: const CircleBorder(),
                                    fillColor: MaterialStateProperty.all(Colors.white),
                                    value: isManualPriceChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isManualPriceChecked = value!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width20,
                                ),
                                BigText(
                                  fontTypo: 'Helvetica-Bold',
                                  text: "Prix manuel ?",
                                  size: Dimensions.height25 * 0.8,
                                  color: Colors.white,
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
                                Transform.scale(
                                  scale: 1.2,
                                  child: Checkbox(
                                    checkColor: AppColors.mainColor,
                                    shape: const CircleBorder(),
                                    fillColor: MaterialStateProperty.all(Colors.white),
                                    value: isActiveChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isActiveChecked = value!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width20,
                                ),
                                BigText(
                                  fontTypo: 'Helvetica-Bold',
                                  text: "Produit activé ?",
                                  size: Dimensions.height25 * 0.8,
                                  color: Colors.white,
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
                          hintText: "Facteur de correction",
                          labelText: "Facteur de correction",
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
                        _createProduct(createProductController);
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
                    )
                  ],
                )),
              ),
            ],
          ));
    });
  }
}
