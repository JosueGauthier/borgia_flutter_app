import 'package:borgiaflutterapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/dimensions.dart';

import '../category/category_management_page.dart';
import '../product/product_management_page.dart';

class ManagementShopPage extends StatefulWidget {
  final int shopId;
  const ManagementShopPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<ManagementShopPage> createState() => _ManagementShopPageState();
}

class _ManagementShopPageState extends State<ManagementShopPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              CategoryManagementPage(
                shopId: widget.shopId,
              ),
              ProductManagementPage(
                shopId: widget.shopId,
              )
            ],
          ),
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: Dimensions.height20 * 3,
            title: //! header
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                          width: Dimensions.width15 * 4,
                          height: Dimensions.width15 * 4,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )),
                  ],
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(right: Dimensions.width20),
                    child: Text("Management", style: Theme.of(context).textTheme.headlineMedium),
                  ),
                ),
              ],
            ),
            bottom: TabBar(
              indicatorColor: AppColors.mainColor,
              labelColor: AppColors.mainColor,
              unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
              tabs: [
                Tab(
                    text: "Catégories",
                    icon: Icon(
                      Icons.category,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
                Tab(
                    text: "Produits",
                    icon: Icon(
                      Icons.fastfood,
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
