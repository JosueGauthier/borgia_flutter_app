import 'package:borgiaflutterapp/admin/controller/update_shop_controller.dart';
import 'package:borgiaflutterapp/admin/models/update_shop_model.dart';
import 'package:borgiaflutterapp/models/shop_model.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/shop_controller.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widget/big_text.dart';
import '../../../widget/custom_header.dart';
import '../../../widget/profile_box.dart';

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

  bool imageChanged = false;
  bool correctingFactorChanged = false;

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

    var cloudinary = AppConstants.CLOUDINARY_PUBLIC_VAR;
    response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(filePath, resourceType: resourceType),
    );
    return response;
  }

  late ShopModel shopModel;

  void _updateShop(
    UpdateShopController updateShopController,
  ) {
    String username = AppConstants.USERNAME;
    String password = AppConstants.PASSWORD;

    String shopImage = "";

    if (path == "") {
      shopImage = shopModel.image!;
    } else {
      shopImage = path;
    }

    UpdateShopModel updateShopModel = UpdateShopModel(
      username: username,
      password: password,
      shopId: shopModel.id!,
      correctingFactorActivated: correctingFactorActivated,
      shopImage: shopImage,
    );

    updateShopController.updateShop(updateShopModel).then((status) {
      if (status.isSuccess) {
        //! changer below
        Get.back();
      } else {
        Get.snackbar("Erreur", "Magasin non modifié. Vérifier les informations saisies", backgroundColor: Colors.redAccent);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    Get.find<ShopController>().getShopList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateShopController>(builder: (updateShopController) {
      return GetBuilder<ShopController>(builder: (shopController) {
        List shopList = shopController.shopList;

        shopModel = (shopList.where((element) => element.id == widget.shopId)).single;

        if (imageChanged == false) {
          path = shopModel.image!;
        }
        if (correctingFactorChanged == false) {
          correctingFactorActivated = shopModel.correctingFactorActivated!;
        }

        return shopController.isLoaded
            ? Scaffold(
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
                              readOnly: true,
                              scrollPadding: EdgeInsets.only(bottom: Dimensions.height100),
                              controller: nameController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: AppColors.titleColor),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  //borderSide: const BorderSide(color: AppColors.mainColor),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                prefixIcon: Icon(
                                  Icons.bookmark,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                                hintText: (shopModel.name != null) ? shopModel.name : "Nom du magasin",
                                //labelText: (shopModel.name != null) ? shopModel.name : "Nom du magasin",
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
                                imageChanged = true;
                                path;
                              });
                            },
                            child: SizedBox(
                              width: double.maxFinite,

                              //color: Colors.blueAccent,
                              child: Row(
                                children: [
                                  (path != "")
                                      ? SizedBox(
                                          width: Dimensions.width45 * 7,
                                          child: ProfileBox(
                                            textColor: Colors.white,
                                            backgroundcolor: AppColors.mainColor,
                                            icon: Icons.image,
                                            text: "Image du magasin",
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
                                            text: "Image du magasin",
                                            iconcolor: Colors.white,
                                            radius: Dimensions.width45,
                                            isEditable: false,
                                          ),
                                        ),
                                  (path != "")
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
                                correctingFactorChanged = true;
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
                                      Transform.scale(
                                        scale: 1.2,
                                        child: Checkbox(
                                          checkColor: AppColors.mainColor,
                                          shape: const CircleBorder(),

                                          fillColor: MaterialStateProperty.all(Colors.white),
                                          //fillColor: MaterialStateProperty.resolveWith(getColor),
                                          value: correctingFactorActivated,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              correctingFactorChanged = true;
                                              correctingFactorActivated = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimensions.width20,
                                      ),
                                      BigText(
                                        fontTypo: 'Helvetica-Bold',
                                        text: "Facteur de correction ?",
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
                            height: Dimensions.height20 * 2,
                          ),
                          GestureDetector(
                            onTap: () {
                              _updateShop(updateShopController);
                            },
                            child: SizedBox(
                              width: Dimensions.width45 * 5,
                              child: ProfileBox(
                                textColor: Colors.white,
                                backgroundcolor: AppColors.greenEmerald,
                                icon: Icons.check,
                                text: "Modifier",
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
                ))
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
