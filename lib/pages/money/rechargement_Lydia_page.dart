import 'dart:async';

import 'package:borgiaflutterapp/controllers/lydia_controller.dart';
import 'package:borgiaflutterapp/models/lydia_model.dart';
import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:borgiaflutterapp/widget/loading_indicator.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/user_controller.dart';
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

  bool paymentAccepted = false;
  bool isInProcess = false;

  var success = false;
  bool done = false;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<bool> _lydiaCheckState(LydiaStateRequestController lydiaStateRequestController, String requestUuidString) async {
    String username = AppConstants.USERNAME;
    String password = AppConstants.PASSWORD;
    String requestUuid = requestUuidString;

    bool success = false;

    LydiaModelStateRequestModel lydiaStateRequestModel = LydiaModelStateRequestModel(
      username: username,
      password: password,
      requestUuid: requestUuid,
    );

    await lydiaStateRequestController.lydiaAPIStateRequest(lydiaStateRequestModel).then((status) {
      if (status.isSuccess) {
        if (lydiaStateRequestController.state == "1") {
          success = true;
          setState(() {
            isInProcess = false;
            Get.find<UserController>().getUserList(AppConstants.USERNAME);
            phoneController.clear();
            amountController.clear();
            Get.snackbar("Succès", "Vous avez bien été crédité", backgroundColor: AppColors.greenEmerald);
          });
        }
      } else {
        Get.snackbar("Erreur", "Vérifier les informations saisies \n Vous n'avez pas été débité", backgroundColor: Colors.redAccent);
      }
    });

    return success;
  }

  void _lydiaRefill(
    LydiaDoRequestController lydiaDoController,
    LydiaStateRequestController lydiaStateController,
  ) {
    String username = AppConstants.USERNAME;
    String password = AppConstants.PASSWORD;

    String phoneNumber = phoneController.text.trim();
    String amount = amountController.text.trim();

    LydiaModelDoRequestModel lydiaModel = LydiaModelDoRequestModel(
      username: username,
      password: password,
      amount: amount,
      phoneNumber: phoneNumber,
    );

    lydiaDoController.lydiaAPIDoRequest(lydiaModel).then((status) async {
      if (mounted) {
        if (status.isSuccess) {
          //Todo check ios
          var isAppInstalled = await LaunchApp.isAppInstalled(androidPackageName: 'com.lydia', iosUrlScheme: 'lydia//');

          //! warning set true !
          if (isAppInstalled == false) {
            await LaunchApp.openApp(
              androidPackageName: 'com.lydia',
              // openStore: false
            );
          } else {
            Uri url = Uri.parse(lydiaDoController.collectPageLydiaUrl);
            _launchInBrowser(url);
          }

          //todo on dispose kill stream
          Stream.periodic(const Duration(seconds: 2)).takeWhile((_) => !done).forEach((_) async {
            success = await _lydiaCheckState(lydiaStateController, lydiaDoController.requestUuid);
            done = success; // only if you want to finish the function earlier
            setState(() {});
          });
        } else {
          Get.snackbar("Erreur", "Vérifier les informations saisies \n Vous n'avez pas été débité", backgroundColor: Colors.redAccent);
        }
      }
    });

    //todo faire un regex
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LydiaDoRequestController>(builder: (lydiaDoRequestController) {
      return GetBuilder<LydiaStateRequestController>(builder: (lydiaStateRequestController) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: Dimensions.height20 * 6,
                      padding: EdgeInsets.only(top: Dimensions.height10 * 3, left: Dimensions.width20),
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
                            FocusScope.of(context).unfocus();
                            _lydiaRefill(lydiaDoRequestController, lydiaStateRequestController);
                            setState(() {
                              isInProcess = true;
                            });
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
                isInProcess
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: Dimensions.screenHeight,
                            width: Dimensions.screenWidth,
                            color: Colors.black.withOpacity(0.7),
                          ),
                          Column(
                            children: [
                              Text(
                                "Confirmation de l'operation en attente",
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                              const CustomLoadingIndicator(),
                            ],
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        );
      });
    });
  }
}
