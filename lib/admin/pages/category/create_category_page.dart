import 'dart:developer';

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
import '../../controller/salemodule_controller.dart';

class CreateCategoryPage extends StatefulWidget {
  final int shopId;
  const CreateCategoryPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<CreateCategoryPage> createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState extends State<CreateCategoryPage> {
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
      inspect(productModel);
      createProductController.createProduct(productModel).then((status) {
        if (status.isSuccess) {
          //! changer below
          Get.back();
        } else {
          Get.snackbar("Erreur", "Produit non créé. Verifier les informations saisies", backgroundColor: Colors.redAccent);
        }
      });
    }
  }

  String selectedModule = "Categorie opérateur";
  Map<String, IconData> mapModule = {
    "Categorie opérateur": Icons.man,
    "Categorie selfsale": Icons.self_improvement,
  };

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateProductController>(builder: (createProductController) {
      return Scaffold(
          extendBody: true,
          body: GetBuilder<SaleModuleController>(builder: (saleModuleController) {
            inspect(saleModuleController.operatorList);
            inspect(saleModuleController.selfList);

            int selfModuleId = 0;

            int operatorModuleId = 0;

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
                              height: Dimensions.height20,
                            ),
                            Container(
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
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        value,
                                                      ),
                                                      SizedBox(
                                                        width: Dimensions.height10,
                                                      ),
                                                      Text(
                                                        text,
                                                        style: Theme.of(context).textTheme.bodySmall,
                                                      ),
                                                    ],
                                                  ),
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

                                inspect(path);

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
                                                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                          ],
                        )),
                      ),
                    ],
                  )
                : Container();
          }));
    });
  }
}
