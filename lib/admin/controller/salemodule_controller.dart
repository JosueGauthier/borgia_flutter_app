import 'package:borgiaflutterapp/admin/data/salemodule_repo.dart';
import 'package:borgiaflutterapp/admin/models/salemodule_model.dart';
import 'package:get/get.dart';

class SaleModuleController extends GetxController {
  final SaleModuleRepo saleModuleRepo;

  SaleModuleController({required this.saleModuleRepo});

  List<dynamic> _selfList = [];
  List<dynamic> get selfList => _selfList;

  bool _selfListisLoaded = false;
  bool get selfListisLoaded => _selfListisLoaded;

  List<dynamic> _operatorList = [];
  List<dynamic> get operatorList => _operatorList;

  bool _operatorListisLoaded = false;
  bool get operatorListisLoaded => _operatorListisLoaded;

  Future<void> getOperatorsaleModuleList() async {
    Response response = await saleModuleRepo.getOperatorsaleModuleList();

    if (response.statusCode == 200) {
      _operatorList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        _operatorList.add(SaleModuleModel.fromJson(responseBody[i]));
      }
      _operatorListisLoaded = true;

      update();
    } else {}
  }

  Future<void> getSelfsaleModuleList() async {
    Response response = await saleModuleRepo.getSelfsaleModuleList();

    if (response.statusCode == 200) {
      _selfList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        _selfList.add(SaleModuleModel.fromJson(responseBody[i]));
      }
      _selfListisLoaded = true;

      update();
    } else {}
  }
}
