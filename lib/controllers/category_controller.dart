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
    //print(response);

    //print("Category from shop status code " + response.statusCode.toString());

    if (response.statusCode == 200) {
      _categoryOfShopList = [];

      //print("response : " + response.body.toString());

      List responseBody = response.body;

      //print("the length is " + response_body.length.toString());
      //print("the shop number is " + response_body.length.toString());

      for (var i = 0; i < responseBody.length; i++) {
        _categoryOfShopList.add(CategoryOfShopModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      AppConstants.CAT_LIST_MODULE = _categoryOfShopList;

      update();
    } else {}
  }
}
