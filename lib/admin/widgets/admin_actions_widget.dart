import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

class AdminActionWidget extends StatelessWidget {
  const AdminActionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: Dimensions.height15),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
          //! image section

          Container(
            //margin: EdgeInsets.only(bottom: Dimensions.height10 * 2),
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
              //child: AssetImage(),
            ),
          ),
          SizedBox(
            width: Dimensions.width20 * 3,
          ),

          //! text section

          Container(
            //margin: EdgeInsets.only(bottom: Dimensions.height10 * 2),
            alignment: Alignment.center,
            child: Text(
              "(shopModel.name)!",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ]),
      ),
    );
  }
}
