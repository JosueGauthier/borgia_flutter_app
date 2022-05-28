import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';

class ListItemWidget extends StatelessWidget {
  //NetworkImage imageItem;
  var imageUrl;

  ListItemWidget({Key? key, /* required this.imageItem, */ required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      //! image section

      Container(
        margin: EdgeInsets.only(bottom: Dimensions.height10),
        height: Dimensions.height100 * 0.6,
        width: Dimensions.height100 * 0.6,
        decoration: BoxDecoration(
          //color: Colors.amber,
          image: DecorationImage(
            fit: BoxFit.contain,
            image: (imageUrl == null) ? AssetImage("assets/image/dafaultuserimage.png") as ImageProvider : NetworkImage(imageUrl),
          ),
          //borderRadius: BorderRadius.circular(Dimensions.width20)
        ),
      ),

      SizedBox(
        width: Dimensions.width20 * 3,
      ),

      //! text section

      Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
          child: BigText(
            fontTypo: 'Helvetica-Bold',
            text: 'aaa',
            size: Dimensions.height25 * 0.8,
            color: AppColors.titleColor,
          ),
        ),
      ),
    ]);
  }
}
