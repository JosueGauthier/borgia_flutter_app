import 'package:get/get.dart';

import '../data/repository/sale_list_repo.dart';
import '../models/year_salelist_model.dart';

class SaleListController extends GetxController {
  final SaleListRepo saleListRepo;

  SaleListController({required this.saleListRepo});

  List<dynamic> _saleList = [];

  List<dynamic> get saleList => _saleList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

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
}
