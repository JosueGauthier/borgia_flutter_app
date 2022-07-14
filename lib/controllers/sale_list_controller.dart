import 'package:get/get.dart';

import '../data/repository/sale_list_repo.dart';

class SaleListController extends GetxController {
  final SaleListRepo saleListRepo;

  SaleListController({required this.saleListRepo});

  List<dynamic> _aListUser = [];

  List<dynamic> get aListUser => _aListUser;

  bool _isLoadedYearList = false;
  bool get isLoadedYearList => _isLoadedYearList;
  List<dynamic> _yearList = [];
  List<dynamic> get yearList => _yearList;

  bool _isLoadedHourList = false;
  bool get isLoadedHourList => _isLoadedHourList;
  List<dynamic> _hourList = [];
  List<dynamic> get hourList => _hourList;

  bool _isLoadedUser = false;
  bool get isLoadedUser => _isLoadedUser;

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

    if (response.statusCode == 200) {
      _aListUser = [];

      List responseBody = response.body;

      _aListUser = responseBody;

      _isLoadedUser = true;

      update();
    } else {}
  }
}
