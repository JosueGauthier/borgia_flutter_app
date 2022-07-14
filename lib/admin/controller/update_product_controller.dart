import 'package:borgiaflutterapp/admin/data/update_product_repo.dart';
import 'package:borgiaflutterapp/admin/models/update_product_model.dart';
import 'package:borgiaflutterapp/models/response_model.dart';
import 'package:get/get.dart';

class UpdateProductController extends GetxController implements GetxService {
  final UpdateProductRepo updateProductRepo;

  UpdateProductController({required this.updateProductRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> updateProduct(UpdateProductModel updateProductModel) async {
    _isLoading = true;

    update();

    Response response = await updateProductRepo.updateProduct(updateProductModel);
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
