import 'package:borgiaflutterapp/admin/data/delete_category_repo.dart';
import 'package:borgiaflutterapp/admin/models/delete_category_model.dart';
import 'package:borgiaflutterapp/models/response_model.dart';
import 'package:get/get.dart';

class DeleteCategoryController extends GetxController implements GetxService {
  final DeleteCategoryRepo deleteCategoryRepo;

  DeleteCategoryController({required this.deleteCategoryRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> deleteProduct(DeleteCategoryModel deleteCategoryModel) async {
    _isLoading = true;

    update();

    Response response = await deleteCategoryRepo.deleteCategory(deleteCategoryModel);
    late ResponseModel responseModel;

    if (response.statusCode == 202) {
      responseModel = ResponseModel(true, "Succes");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;

    update();

    return responseModel;
  }
}
