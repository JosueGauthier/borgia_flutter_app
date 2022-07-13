import 'package:borgiaflutterapp/admin/data/create_product_repo.dart';
import 'package:borgiaflutterapp/admin/models/create_product_model.dart';
import 'package:borgiaflutterapp/models/response_model.dart';
import 'package:get/get.dart';

class CreateProductController extends GetxController implements GetxService {
  final CreateProductRepo createProductRepo;

  CreateProductController({required this.createProductRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> createProduct(CreateProductModel createProductModel) async {
    _isLoading = true;

    update();

    Response response = await createProductRepo.createProduct(createProductModel);
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
