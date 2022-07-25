import 'package:borgiaflutterapp/data/repository/category_list_repo.dart';
import 'package:borgiaflutterapp/models/categories_shop_model.dart';
import 'package:get/get.dart';

class CategoryOfShopController extends GetxController {
  final CategoryOfShopRepo categoryOfShopRepo;

  CategoryOfShopController({required this.categoryOfShopRepo});

  List<dynamic> _selfSaleCategoryList = [];

  List<dynamic> get selfSaleCategoryList => _selfSaleCategoryList;

  List<dynamic> _operatorList = [];

  List<dynamic> get operatorList => _operatorList;

  bool _selfSaleCategoryListIsLoaded = false;
  bool get selfSaleCategoryListIsLoaded => _selfSaleCategoryListIsLoaded;

  bool _operatorListIsLoaded = false;
  bool get operatorListIsLoaded => _operatorListIsLoaded;

  List<dynamic> _allCategoriesList = [];

  List<dynamic> get allCategoriesList => _allCategoriesList;

  bool _allCategoriesListIsLoaded = false;
  bool get allCategoriesListIsLoaded => _allCategoriesListIsLoaded;

  Future<void> getSelfSaleCategoryList(int shopId) async {
    Response response = await categoryOfShopRepo.getProductList(shopId);

    if (response.statusCode == 200) {
      _selfSaleCategoryList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        var categoryShopModel = CategoryOfShopModel.fromJson(responseBody[i]);

        if (categoryShopModel.contentType!.model == 'selfsalemodule') {
          _selfSaleCategoryList.add(categoryShopModel);
        }
      }
      _selfSaleCategoryListIsLoaded = true;

      update();
    } else {}
  }

  Future<void> getOperatorCategoryList(int shopId) async {
    Response response = await categoryOfShopRepo.getProductList(shopId);

    if (response.statusCode == 200) {
      _operatorList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        var categoryShopModel = CategoryOfShopModel.fromJson(responseBody[i]);

        if (categoryShopModel.contentType!.model == 'operatorsalemodule') {
          _operatorList.add(categoryShopModel);
        }
      }

      _operatorListIsLoaded = true;

      update();
    } else {}
  }

  Future<void> getAllCategoryList(int shopId) async {
    Response response = await categoryOfShopRepo.getProductList(shopId);

    if (response.statusCode == 200) {
      _allCategoriesList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        var categoryShopModel = CategoryOfShopModel.fromJson(responseBody[i]);

        _allCategoriesList.add(categoryShopModel);
      }

      _allCategoriesListIsLoaded = true;

      update();
    } else {}
  }
}
