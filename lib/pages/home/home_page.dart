import 'package:borgiaflutterapp/icon/lydiaicon_icons.dart';
import 'package:borgiaflutterapp/pages/money/rechargement_lydia_page.dart';
import 'package:borgiaflutterapp/utils/dimensions.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/shop_controller.dart';
import '../../utils/app_constants.dart';
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
    Get.find<CartController>().getCartData();
  }

  List<Widget> pages = [
    const WelcomePageWithHeader(),
    const SearchPage(),
    const FavPage(),
    const RefillLydiaPage(),
  ];

  var _selectedIndex = 0;
  late PageController _pageController;

  void onTapNav(int index) {
    setState(() {});
  }

  void onItemTapped(int index) {
    setState(() {
      AppConstants.bienvenueUsernameisfinishedRotate = true;
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _loadRessources();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          extendBody: true,
          body: SizedBox.expand(
            child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _selectedIndex = index);
                },
                children: pages),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.85),
            elevation: 0,
            selectedItemColor: AppColors.mainColor,
            unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: onItemTapped,
            iconSize: Dimensions.height30,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_alt), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart), label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Lydiaicon.lydia,
                    size: 23,
                  ),
                  label: 'Lydia')
            ],
          )),
    );
  }
}
