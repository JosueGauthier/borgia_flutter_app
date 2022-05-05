// main.dart
import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import our custom number keyboard
import '../../routes/route_helper.dart';
import '../../widget/app_icon.dart';
import '../../widget/big_text.dart';
import '../../widget/custom_numpad.dart';

class RefillLydiaPage extends StatefulWidget {
  const RefillLydiaPage({Key? key}) : super(key: key);

  @override
  State<RefillLydiaPage> createState() => _RefillLydiaPageState();
}

class _RefillLydiaPageState extends State<RefillLydiaPage> {
  final TextEditingController _myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: Dimensions.height45 * 2.7,
            decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.height20),
                  bottomRight: Radius.circular(Dimensions.height20),
                )),
            margin: EdgeInsets.only(bottom: Dimensions.height10),
            padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Rechargement Lydia",
                  size: Dimensions.height10 * 3,
                  color: Colors.white,
                ),
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: const AppIcon(iconData: CupertinoIcons.house_alt, iconColor: AppColors.mainColor, backgroundColor: Colors.white)),
              ],
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.contain, image: const AssetImage("assets/image/lydiaRefill.png"))),

            //color: Colors.redAccent,
          ))

          // display the entered numbers

          // implement the custom NumPad
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.height20 * 21,
        //color: Colors.blueAccent,
        child: Column(
          children: [
            Container(
              height: Dimensions.height20 * 3,
              color: Colors.white.withOpacity(0.8),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.height10),
                child: SizedBox(
                  height: Dimensions.height10,
                  child: Center(
                      child: TextField(
                    controller: _myController,
                    textAlign: TextAlign.center,
                    showCursor: false,
                    style: TextStyle(fontSize: Dimensions.height45, color: AppColors.mainColor, fontFamily: 'OpenSansExtraBold'),
                    // Disable the default soft keybaord
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
                _myController.text = _myController.text.substring(0, _myController.text.length - 1);
              },
              // do something with the input numbers
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
          ],
        ),
      ),
    );
  }
}
