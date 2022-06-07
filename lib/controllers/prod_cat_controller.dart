import 'package:borgiaflutterapp/data/repository/prodcat_repo.dart';
import 'package:borgiaflutterapp/models/category_product_model.dart';
import 'package:get/get.dart';

class CategoryFromProductController extends GetxController {
  final CategoryFromProductRepo categoryOfProductRepo;

  CategoryFromProductController({required this.categoryOfProductRepo});

  List<dynamic> _catList = [];

  List<dynamic> get catList => _catList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getCat(int productId) async {
    Response response = await categoryOfProductRepo.getCatList(productId);

    if (response.statusCode == 200) {
      _catList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        _catList.add(CategoryProductModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      //AppConstants.CAT_LIST = _catList;

      update();
    } else {}
  }
}
