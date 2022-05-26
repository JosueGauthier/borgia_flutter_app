import 'package:borgiaflutterapp/controllers/rank_user_controller.dart';
import 'package:borgiaflutterapp/models/rank_user_shop_model.dart';
import 'package:borgiaflutterapp/widget/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class RankUserPage extends StatefulWidget {
  const RankUserPage({Key? key}) : super(key: key);

  @override
  State<RankUserPage> createState() => _RankUserPageState();
}

class _RankUserPageState extends State<RankUserPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankUserStatController>(builder: (rankUserStatController) {
      if (rankUserStatController.isLoaded) {
        return SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            //! Podium

            //! List

            Container(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    RankUserShopModel rankUserShopModel = rankUserStatController.statList[index];
                    //print(productModel.image!);
                    return Container(
                      child: Column(
                        children: [BigText(text: rankUserShopModel.name!), BigText(text: rankUserShopModel.userTopTen![0].surname!)],
                      ),
                    );
                  }),
            ),
          ]),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.mainColor,
          ),
        );
      }
    });
  }
}
