import 'package:borgiaflutterapp/controllers/rank_user_controller.dart';
import 'package:borgiaflutterapp/models/rank_user_shop_model.dart';
import 'package:borgiaflutterapp/utils/dimensions.dart';
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

            SizedBox(
              height: Dimensions.height20,
            ),

            Container(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: rankUserStatController.statList.length,
                  itemBuilder: (context, indexShop) {
                    RankUserShopModel rankUserShopModel = rankUserStatController.statList[indexShop];
                    List<UserTopTen>? userTopTenList = rankUserShopModel.userTopTen;
                    return Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height30),
                      //color: Colors.greenAccent,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              //! image section

                              Container(
                                margin: EdgeInsets.only(left: Dimensions.width20, bottom: Dimensions.height10),
                                height: Dimensions.height100 * 0.6,
                                width: Dimensions.height100 * 0.6,
                                decoration: BoxDecoration(
                                  //color: Colors.amber,
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(rankUserShopModel.image!),
                                  ),
                                  //borderRadius: BorderRadius.circular(Dimensions.width20)
                                ),
                              ),

                              Container(
                                height: Dimensions.height100 * 0.6,
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  //! text section

                                  //? expanded widget force container to take all the available space
                                  Container(
                                    //color: Colors.greenAccent,
                                    padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                    child: BigText(
                                      size: Dimensions.height25 * 1.1,
                                      fontTypo: 'Montserrat-Bold',
                                      text: (rankUserShopModel.name)!.capitalize!,
                                      color: AppColors.titleColor,
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                          Container(
                            height: Dimensions.height100 * 1.7,
                            //color: Colors.amber,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  height: Dimensions.height100 * 1.3,
                                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                                  child: Image.asset(
                                    "assets/image/podium.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Positioned(
                                  top: Dimensions.height10 * 4,
                                  left: Dimensions.width10 * 2,
                                  child: Column(
                                    children: [
                                      Container(
                                        //color: Colors.greenAccent,
                                        height: Dimensions.height10 * 4,
                                        width: Dimensions.width10 * 7.2,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text: (userTopTenList![1].surname)!.capitalize!,
                                                size: ((Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenList[1].surname!.length)) * 0.14) >=
                                                        Dimensions.height10)
                                                    ? Dimensions.height10 * 1.7
                                                    : Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenList[1].surname!.length)) * 0.14,
                                                color: AppColors.titleColor,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 2,
                                              ),
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text: (userTopTenList[1].family! +
                                                        " " +
                                                        userTopTenList[1].campus!.toLowerCase().capitalize! +
                                                        (userTopTenList[1].promotion! - 1800).toString())
                                                    .capitalize!,
                                                size: Dimensions.height10 * 1.5,
                                                color: AppColors.titleColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: Dimensions.width10 * 9.5,
                                  child: Column(
                                    children: [
                                      Container(
                                        //color: Colors.greenAccent,
                                        height: Dimensions.height10 * 4,
                                        width: Dimensions.width10 * 7.2,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text: (userTopTenList[0].surname)!.capitalize!,
                                                size: ((Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenList[0].surname!.length)) * 0.14) >=
                                                        Dimensions.height10)
                                                    ? Dimensions.height10 * 1.7
                                                    : Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenList[0].surname!.length)) * 0.14,
                                                color: AppColors.titleColor,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 2,
                                              ),
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text: (userTopTenList[0].family! +
                                                        " " +
                                                        userTopTenList[0].campus!.toLowerCase().capitalize! +
                                                        (userTopTenList[0].promotion! - 1800).toString())
                                                    .capitalize!,
                                                size: Dimensions.height10 * 1.5,
                                                color: AppColors.titleColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: Dimensions.height10 * 7.5,
                                  left: Dimensions.width10 * 17,
                                  child: Column(
                                    children: [
                                      Container(
                                        //color: Colors.greenAccent,
                                        height: Dimensions.height10 * 4,
                                        width: Dimensions.width10 * 7.2,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text: (userTopTenList[2].surname)!.capitalize!,
                                                size: ((Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenList[2].surname!.length)) * 0.14) >=
                                                        Dimensions.height10)
                                                    ? Dimensions.height10 * 1.7
                                                    : Dimensions.height10 * ((Dimensions.width10 * 7.2) / (userTopTenList[2].surname!.length)) * 0.14,
                                                color: AppColors.titleColor,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 2,
                                              ),
                                              BigText(
                                                fontTypo: 'Helvetica-Bold',
                                                text: (userTopTenList[2].family! +
                                                        " " +
                                                        userTopTenList[2].campus!.toLowerCase().capitalize! +
                                                        (userTopTenList[2].promotion! - 1800).toString())
                                                    .capitalize!,
                                                size: Dimensions.height10 * 1.5,
                                                color: AppColors.titleColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          /* ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: userTopTenList.length,
                              itemBuilder: (context, indexUser) {
                                UserTopTen userStatModel = userTopTenList[indexUser];
                                return Container(
                                  child: Column(children: [
                                    BigText(text: userStatModel.surname!),
                                  ]),
                                );
                              }), */
                        ],
                      ),
                    );
                  }),
            ),

            SizedBox(
              height: Dimensions.height10 * 5,
            )
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
