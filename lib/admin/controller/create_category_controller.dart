import 'package:borgiaflutterapp/admin/data/create_category_repo.dart';
import 'package:borgiaflutterapp/admin/models/create_category_model.dart';
import 'package:borgiaflutterapp/models/response_model.dart';
import 'package:get/get.dart';

class CreateCategoryController extends GetxController implements GetxService {
  final CreateCategoryRepo createCategoryRepo;

  CreateCategoryController({required this.createCategoryRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> createCategory(CreateCategoryModel createCategoryModel) async {
    _isLoading = true;

    update();

    Response response = await createCategoryRepo.createCategory(createCategoryModel);
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
