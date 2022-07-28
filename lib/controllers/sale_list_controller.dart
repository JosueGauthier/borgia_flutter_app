import 'dart:developer';

import 'package:get/get.dart';

import '../data/repository/sale_list_repo.dart';

class SaleListController extends GetxController {
  final SaleListRepo saleListRepo;

  SaleListController({required this.saleListRepo});

  List<dynamic> _userHistoryList = [];

  List<dynamic> get userHistoryList => _userHistoryList;

  bool _userHistoryListIsLoaded = false;
  bool get userHistoryListIsLoaded => _userHistoryListIsLoaded;

  bool _isLoadedYearList = false;
  bool get isLoadedYearList => _isLoadedYearList;
  List<dynamic> _yearList = [];
  List<dynamic> get yearList => _yearList;

  bool _isLoadedHourList = false;
  bool get isLoadedHourList => _isLoadedHourList;
  List<dynamic> _hourList = [];
  List<dynamic> get hourList => _hourList;

  Future<void> getMapListYearHistory() async {
    Response response = await saleListRepo.getYearSaleList();

    if (response.statusCode == 200) {
      _yearList = [];

      List responseBody = response.body;

      _yearList = responseBody;

      _isLoadedYearList = true;

      update();
    } else {}
  }

  Future<void> getMapListTwoHours() async {
    Response responseLive = await saleListRepo.getHourSaleList();

    inspect(responseLive.body);

    if (responseLive.statusCode == 200) {
      _hourList = [];
      List responseBody = responseLive.body;

      _hourList = responseBody;

      _isLoadedHourList = true;

      update();
    } else {}
  }

  Future<void> getUserSaleList() async {
    Response response = await saleListRepo.getSaleUserList();

    inspect(response.body);

    if (response.statusCode == 200) {
      _userHistoryList = [];

      List responseBody = response.body;

      _userHistoryList = responseBody;

      _userHistoryListIsLoaded = true;

      update();
    } else {}
  }
}
