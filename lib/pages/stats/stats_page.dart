import 'package:borgiaflutterapp/controllers/sale_list_controller.dart';
import 'package:borgiaflutterapp/controllers/shop_stat_controller.dart';
import 'package:borgiaflutterapp/pages/stats/global_stat_page.dart';
import 'package:borgiaflutterapp/pages/stats/personal_stat_page.dart';
import 'package:borgiaflutterapp/pages/stats/rank_user_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/rank_user_controller.dart';
import '../../controllers/user_shop_stat_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widget/big_text.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    Get.find<RankUserStatController>().getRankUserList();

    Get.find<SaleListController>().getMapListYearHistory();

    Get.find<SaleListController>().getMapListTwoHours();

    Get.find<SaleListController>().getUserSaleList();

    Get.find<ShopStatController>().getShopStatList();

    Get.find<UserShopStatController>().getUserShopStatList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: const TabBarView(
            children: [
              GlobalStatPage(),
              MyStatPage(),
              RankUserPage(),
            ],
          ),
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: Dimensions.height20 * 3,
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
            shadowColor: Colors.white,
            title: //! header
                Container(
              height: Dimensions.height45 * 1.2,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              margin: EdgeInsets.only(bottom: Dimensions.height10),
              padding: EdgeInsets.only(top: Dimensions.height30 * 0.5, left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BigText(
                    fontTypo: 'Montserrat-Bold',
                    text: "Statistiques",
                    size: Dimensions.height10 * 3,
                    color: AppColors.titleColor,
                  ),
                ],
              ),
            ),
            bottom: const TabBar(
              indicatorColor: AppColors.mainColor,
              labelColor: AppColors.mainColor,
              unselectedLabelColor: AppColors.titleColor,
              tabs: [
                Tab(
                    text: "Global",
                    icon: Icon(
                      Icons.people_rounded,
                      color: AppColors.titleColor,
                    )),
                Tab(
                    text: "Moi",
                    icon: Icon(
                      Icons.person_sharp,
                      color: AppColors.titleColor,
                    )),
                Tab(
                    text: "Podium",
                    icon: Icon(
                      Icons.emoji_events,
                      color: AppColors.titleColor,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
