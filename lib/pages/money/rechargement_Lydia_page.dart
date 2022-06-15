import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:borgiaflutterapp/utils/dimensions.dart';
import 'package:flutter/material.dart';
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
      //backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: Dimensions.height45 * 2.7,
            padding: EdgeInsets.only(top: Dimensions.height30 * 1.3, left: Dimensions.width20 * 2, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BigText(
                  fontTypo: 'Montserrat-Bold',
                  text: "Rechargement Lydia",
                  size: Dimensions.height10 * 3,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: double.maxFinite,
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
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
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
    );
  }
}
