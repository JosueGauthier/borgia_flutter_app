import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import 'big_text.dart';

import 'package:borgiaflutterapp/models/product_list_from_category_models.dart';
import 'package:borgiaflutterapp/models/product_model.dart';
import 'package:borgiaflutterapp/widget/small_text_MaterialStateProperty.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/product_from_category_controller.dart';
import '../../widget/app_icon.dart';

import '../../routes/route_helper.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';

class PopUpSale extends StatefulWidget {
  final BuildContext context;
  final ProductModel productModel;

  const PopUpSale({
    Key? key,
    required this.context,
    required this.productModel,
  }) : super(key: key);

  @override
  State<PopUpSale> createState() => _PopUpSaleState();
}

class _PopUpSaleState extends State<PopUpSale> {
  @override
  Widget build(BuildContext context) {
    bool txtbuttonpressed = true;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.height20)),
      title: BigText(text: "productModel.name!", size: Dimensions.height30),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            //color: Colors.amber,
            width: Dimensions.width45 * 6,
            padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height10, bottom: Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    //controller.setQuantity(false);
                  },
                  child: AppIcon(
                    iconData: Icons.remove,
                    backgroundColor: AppColors.secondColor,
                    iconColor: Colors.white,
                    iconSize: 30,
                  ),
                ),
                BigText(
                  text: "\$ 10 x " + "5",
                  color: AppColors.mainBlackColor,
                  size: 20,
                ),
                GestureDetector(
                  onTap: () {
                    //controller.setQuantity(true);
                  },
                  child: AppIcon(
                    iconData: Icons.add,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: 30,
                  ),
                )
              ],
            ),
          ),
          Container(
            //color: Colors.redAccent,
            padding: EdgeInsets.only(
              top: Dimensions.height10,
              bottom: Dimensions.height20,
            ),
            child: Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    //controller.popular_addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(Dimensions.radius20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          size: 20,
                          text: "\$ 15 | Add to cart",
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ),
          Container(
            child: TextButton(
                child: SmallText(
                  text: " Je me bucque !",
                  size: Dimensions.height30,
                  color: txtbuttonpressed ? AppColors.secondColor : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    txtbuttonpressed = !txtbuttonpressed;
                  });

                  //showDialog(context: context, builder: (BuildContext context) => _buildPopupDialog(context, productModel));

                  //Get.offNamed(RouteHelper.getInitial());
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0), /* side: BorderSide(color: AppColors.greyColormedium) */
                  )),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height10, bottom: Dimensions.height10)),
                  backgroundColor:
                      txtbuttonpressed ? MaterialStateProperty.all<Color>(AppColors.greyColormedium) : MaterialStateProperty.all<Color>(AppColors.secondColor),
                )),
          ),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
