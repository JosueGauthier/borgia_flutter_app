import 'package:borgiaflutterapp/pages/cart/cart_history.dart';
import 'package:borgiaflutterapp/pages/cart/cart_page.dart';
import 'package:borgiaflutterapp/pages/fav_products/fav_page.dart';
import 'package:borgiaflutterapp/pages/profile/profile_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/shop_controller.dart';
import '../../utils/colors.dart';
import 'welcome_page_with_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;

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
    //const AuthPage(),
    //CartHistory(),

    //const SignUpPage(),

    //ShopPageDetail(),

    const CartPage(),

    const FavPage(),

    const ProfilePage(),
  ];

  void onTapNav(int index) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
    _loadRessources();
  }

  List<Widget> _buildScreens() {
    return pages;
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.house_alt),
        title: ("Home"),
        activeColorPrimary: AppColors.secondColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.archivebox),
        title: ("History"),
        activeColorPrimary: AppColors.secondColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.heart),
        title: ("Cart"),
        activeColorPrimary: AppColors.secondColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Me"),
        activeColorPrimary: AppColors.secondColor,
        inactiveColorPrimary: AppColors.greyColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }
}
