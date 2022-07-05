import 'package:borgiaflutterapp/data/repository/category_list_repo.dart';
import 'package:borgiaflutterapp/models/categories_shop_model.dart';
import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';

class CategoryOfShopController extends GetxController {
  final CategoryOfShopRepo categoryOfShopRepo;

  CategoryOfShopController({required this.categoryOfShopRepo});

  List<dynamic> _categoryOfShopList = [];

  List<dynamic> get categoryOfShopList => _categoryOfShopList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getCategoryList(int shopId) async {
    Response response = await categoryOfShopRepo.getProductList(shopId);

    if (response.statusCode == 200) {
      _categoryOfShopList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        var a = CategoryOfShopModel.fromJson(responseBody[i]);

        if (a.contentType == 21) {
          _categoryOfShopList.add(CategoryOfShopModel.fromJson(responseBody[i]));
        }
      }
      _isLoaded = true;

      AppConstants.CAT_LIST_MODULE = _categoryOfShopList;

      update();
    } else {}
  }
}
