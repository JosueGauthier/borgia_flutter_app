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

    Get.find<UserShopStatController>().getUserRank();

    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
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
            title: //! header
                Container(
              height: Dimensions.height45 * 1.2,
              margin: EdgeInsets.only(bottom: Dimensions.height10),
              padding: EdgeInsets.only(top: Dimensions.height30 * 0.5, left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Statistiques", style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
            ),
            bottom: TabBar(
              indicatorColor: AppColors.mainColor,
              labelColor: AppColors.mainColor,
              unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
              tabs: [
                Tab(
                    text: "Global",
                    icon: Icon(
                      Icons.people_rounded,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
                Tab(
                    text: "Moi",
                    icon: Icon(
                      Icons.person_sharp,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
                Tab(
                    text: "Podium",
                    icon: Icon(
                      Icons.emoji_events,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
