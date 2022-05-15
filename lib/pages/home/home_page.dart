import 'package:borgiaflutterapp/pages/stats/stats_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/shop_controller.dart';
import '../../utils/colors.dart';
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

    //const FavPage(),

    const StatsPage()
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

  List<Widget> _buildScreens() {
    return pages;
  }

  /* List<PersistentBottomNavBarItem> _navBarsItems() {
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
  } */

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
            backgroundColor: Colors.white.withOpacity(0.5), //here set your transparent level
            elevation: 0,
            selectedItemColor: AppColors.mainColor,
            unselectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,

            currentIndex: _selectedIndex,

            onTap: _onItemTapped,

            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_alt, size: 30), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.search, size: 30), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart, size: 30), label: 'Cart'),
              //BottomNavigationBarItem(icon: Icon(Icons.perm_identity, size: 30), label: 'Me')
            ],
          )),
    );
  }
}


  





/* @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white.withOpacity(0.1), // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white.withOpacity(0),
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
      ),
    );
  } */