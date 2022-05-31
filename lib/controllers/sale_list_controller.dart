import 'package:get/get.dart';

import '../data/repository/sale_list_repo.dart';
import '../models/year_salelist_model.dart';

class SaleListController extends GetxController {
  final SaleListRepo saleListRepo;

  SaleListController({required this.saleListRepo});

  List<dynamic> _saleList = [];

  List<dynamic> get saleList => _saleList;

  List<dynamic> _aList = [];

  List<dynamic> get aList => _aList;

  List<dynamic> _aListUser = [];

  List<dynamic> get aListUser => _aListUser;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isLoadedaList = false;
  bool get isLoadedaList => _isLoadedaList;

  bool _isLoadedUser = false;
  bool get isLoadedUser => _isLoadedUser;

  Future<void> getSaleList() async {
    Response response = await saleListRepo.getSaleList();

    if (response.statusCode == 200) {
      _saleList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        _saleList.add(YearChartModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      update();
    } else {}
  }

  Future<void> getMapList() async {
    Response response = await saleListRepo.getSaleList();

    if (response.statusCode == 200) {
      _aList = [];

      List responseBody = response.body;

      _aList = responseBody;

      _isLoadedaList = true;

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
