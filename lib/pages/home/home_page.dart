import 'package:borgiaflutterapp/pages/money/rechargement_lydia_page.dart';
import 'package:borgiaflutterapp/pages/stats/stats_page.dart';
import 'package:borgiaflutterapp/utils/dimensions.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/shop_controller.dart';
import '../../utils/colors.dart';
import '../fav_products/fav_page.dart';
import '../search/searchpage.dart';
import 'welcome_page_with_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _loadRessources() async {
    //! Use it to clean sharedpreferences
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    //await preferences.clear();
    await Get.find<ShopController>().getShopList();

    //await Get.find<UserController>().getUserList(AppConstants.USERNAME);
    //await Get.find<PopularProductController>().getPopularProductList();
    //await Get.find<RecommendedProductController>().getRecomendedProductList();
  }

  List<Widget> pages = [
    const WelcomePageWithHeader(),

    SearchPage(),

    const FavPage(),

    const RefillLydiaPage(),

    const StatsPage(),

    //LineAreaPointPage(),
  ];

  var _selectedIndex = 0;

  void onTapNav(int index) {
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadRessources();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          body: Center(
            child: pages.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white.withOpacity(0.85), //here set your transparent level
            elevation: 0,
            selectedItemColor: AppColors.mainColor,
            unselectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,

            currentIndex: _selectedIndex,

            onTap: _onItemTapped,

            iconSize: Dimensions.height30,

            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_alt), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart), label: 'Cart'),
              BottomNavigationBarItem(icon: Icon(Icons.currency_exchange_sharp), label: 'Lydia'),
              BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Stat'),

              //BottomNavigationBarItem(icon: Icon(Icons.perm_identity, size: 30), label: 'Me')
            ],
          )),
    );
  }
}
