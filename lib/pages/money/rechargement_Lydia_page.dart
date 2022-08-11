import 'dart:async';

import 'package:borgiaflutterapp/controllers/lydia_controller.dart';
import 'package:borgiaflutterapp/models/lydia_model.dart';
import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../widget/big_text.dart';

class RefillLydiaPage extends StatefulWidget {
  const RefillLydiaPage({Key? key}) : super(key: key);

  @override
  State<RefillLydiaPage> createState() => _RefillLydiaPageState();
}

class _RefillLydiaPageState extends State<RefillLydiaPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  void _lydiaRefill(
    LydiaController lydiaController,
  ) {
    String username = AppConstants.USERNAME;
    String password = AppConstants.PASSWORD;

    String phoneNumber = phoneController.text.trim();
    String amount = amountController.text.trim();

    LydiaModel lydiaModel = LydiaModel(
      username: username,
      password: password,
      amount: amount,
      phoneNumber: phoneNumber,
    );

    lydiaController.lydiaAPIDoRequest(lydiaModel).then((status) async {
      if (status.isSuccess) {
        print(lydiaController.collectPageLydiaUrl);

        var isAppInstalled = await LaunchApp.isAppInstalled(androidPackageName: 'com.lydia', iosUrlScheme: 'pulsesecure://');

        if (isAppInstalled == false) {
          await LaunchApp.openApp(
            androidPackageName: 'com.lydia',
            // openStore: false
          );
        } else {
          Uri url = Uri.parse(lydiaController.collectPageLydiaUrl);
          _launchInBrowser(url);
        }

        //Get.toNamed(RouteHelper.getLydiaWebPage(lydiaController.collectPageLydiaUrl));
      } else {
        Get.snackbar("Erreur", ". Vérifier les informations saisies", backgroundColor: Colors.redAccent);
      }
    });

    //! faire un regex
    /* if (phoneNumber == '' || phoneNumber.length >= 50) {
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
          Get.snackbar("Erreur", "Produit non crée. Vérifier les informations saisies", backgroundColor: Colors.redAccent);
        }
      });
    } */
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LydiaController>(builder: (lydiaController) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Dimensions.height45 * 2.7,
                padding: EdgeInsets.only(top: Dimensions.height30 * 1.3, left: Dimensions.width20 * 2, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Lydia", style: Theme.of(context).textTheme.headlineMedium),
                  ],
                ),
              ),
              SizedBox(
                //color: Colors.redAccent,
                height: Dimensions.height100 * 3,
                width: double.maxFinite,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(Rect.fromLTRB(0, Dimensions.height20 * 7, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.height20 * 2.5),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/image/lydiaapp_bg.png",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10),
                child: TextFormField(
                  scrollPadding: EdgeInsets.only(bottom: Dimensions.height100),
                  keyboardType: TextInputType.number,
                  controller: phoneController,
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
                      Icons.phone,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    hintText: "Numéro de téléphone",
                    labelText: "Numéro de téléphone",
                    labelStyle: Theme.of(context).textTheme.bodySmall,
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10),
                child: TextFormField(
                  scrollPadding: EdgeInsets.only(bottom: Dimensions.height100),
                  keyboardType: TextInputType.number,
                  controller: amountController,
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
                      Icons.euro,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    hintText: "Montant à recharger",
                    labelText: "Montant à recharger",
                    labelStyle: Theme.of(context).textTheme.bodySmall,
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height20 * 2,
              ),
              Container(
                height: Dimensions.height20 * 3.3,
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: Dimensions.width20 * 2,
                  right: Dimensions.width20 * 2,
                ),
                child: ElevatedButton(
                    onPressed: () {
                      _lydiaRefill(lydiaController);
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.only(left: Dimensions.width45, right: Dimensions.width45, top: Dimensions.height10, bottom: Dimensions.height10)),
                        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          return AppColors.mainColor;
                        })),
                    child: BigText(
                      text: "Recharger ",
                      size: Dimensions.height20,
                      color: Theme.of(context).colorScheme.surface,
                      fontTypo: 'Montserrat-Bold',
                    )),
              ),
            ],
          ),
        ),
        /* bottomNavigationBar: SizedBox(
        height: Dimensions.height20 * 23,
        child: Column(
          children: [
            Container(
              height: Dimensions.height20 * 3,
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.height10),
                child: SizedBox(
                  height: Dimensions.height10,
                  child: Center(
                      child: TextField(
                    controller: _myController,
                    textAlign: TextAlign.center,
                    showCursor: false,
                    style: Theme.of(context).textTheme.labelLarge,
                    keyboardType: TextInputType.none,
                  )),
                ),
              ),
            ),
            NumPad(
              buttonSize: Dimensions.height10 * 6,
              buttonColor: AppColors.secondColor,
              iconColor: AppColors.mainColor,
              controller: _myController,
              delete: () {
                if ((_myController.text).isNotEmpty) {
                  _myController.text = _myController.text.substring(0, _myController.text.length - 1);
                }
              },
              onSubmit: () {
                debugPrint('Your code: ${_myController.text}');
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          content: Text(
                            "You code is ${_myController.text}",
                            style: const TextStyle(fontSize: 30),
                          ),
                        ));
              },
            ),
            SizedBox(
              height: Dimensions.height20,
            )
          ],
        ),
      ),
     */
      );
    });
  }
}
