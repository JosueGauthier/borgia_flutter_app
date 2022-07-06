import 'dart:developer';

import 'package:borgiaflutterapp/controllers/search_controller.dart';
import 'package:borgiaflutterapp/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';

class AdminSearchPage extends StatefulWidget {
  final int shopId;
  AdminSearchPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<AdminSearchPage> createState() => _AdminSearchPageState();
}

class _AdminSearchPageState extends State<AdminSearchPage> {
  final TextEditingController searchTextController = TextEditingController();

  void _search(SearchController searchController) {
    var searchController = Get.find<SearchController>();
    String searchWord = searchTextController.text.trim();

    if (searchWord.isEmpty) {
    } else {
      searchController.getAdminUserSearchList(searchWord).then((status) {});
    }
  }

  bool userChoose = false;

  bool productChoose = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: GetBuilder<SearchController>(builder: (searchController) {
          return Column(children: [
            Container(
              height: Dimensions.height45 * 2.7,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
              ),
              margin: EdgeInsets.only(bottom: Dimensions.height10),
              padding: EdgeInsets.only(bottom: Dimensions.height10 / 2, top: Dimensions.height30 * 1.3, left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimensions.height45 * 2.7,
                    width: Dimensions.height100 * 3.5,
                    child: TextFormField(
                      onChanged: (value) {
                        _search(searchController);
                      },
                      controller: searchTextController,
                      style: Theme.of(context).textTheme.headlineMedium,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        prefixIcon: Icon(Icons.search, size: Dimensions.height10 * 3, color: Theme.of(context).colorScheme.onPrimary),
                        hintText: "Recherche...",
                        hintStyle: Theme.of(context).textTheme.headlineMedium,
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (userChoose == false)
                ? (searchController.isLoaded)
                    ? Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: searchController.adminSearchList.length,
                            itemBuilder: ((context, index) {
                              return Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.only(left: Dimensions.width20, bottom: Dimensions.height20),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      userChoose = true;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      //! image section

                                      Container(
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
                                            child: ColorFiltered(
                                              colorFilter: ColorFilter.mode(
                                                  Color((((math.Random().nextDouble())) * 0xFFFFFF).toInt()).withOpacity(1.0), BlendMode.srcATop),
                                              child: Image.asset("assets/image/defaultuserimage.png"),
                                            )),
                                      ),

                                      SizedBox(
                                        width: Dimensions.width20 * 3,
                                      ),

                                      //! text section

                                      (searchController.adminSearchList[index].runtimeType == UserModel)
                                          ? Text(
                                              "${(searchController.adminSearchList[index].firstName.toString()).capitalize!} ${(searchController.adminSearchList[index].lastName.toString()).capitalize!}",
                                              style: Theme.of(context).textTheme.bodySmall,
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              );
                            })))
                    : Container()
                : Container(
                    height: 200,
                    width: 100,
                    color: Colors.greenAccent,
                  ),
            Container(
              color: Colors.transparent,
              height: Dimensions.height10 * 3,
            )
          ]);
        }));
  }
}
