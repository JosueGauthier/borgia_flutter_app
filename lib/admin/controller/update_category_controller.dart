import 'package:borgiaflutterapp/admin/data/update_category_repo.dart';
import 'package:borgiaflutterapp/admin/models/update_category_model.dart';
import 'package:borgiaflutterapp/models/response_model.dart';
import 'package:get/get.dart';

class UpdateCategoryController extends GetxController implements GetxService {
  final UpdateCategoryRepo updateCategoryRepo;

  UpdateCategoryController({required this.updateCategoryRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> updateProduct(UpdateCategoryModel updateCategoryModel) async {
    _isLoading = true;

    update();

    Response response = await updateCategoryRepo.updateCategory(updateCategoryModel);
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
