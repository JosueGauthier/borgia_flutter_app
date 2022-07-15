import 'package:borgiaflutterapp/admin/data/delete_product_repo.dart';
import 'package:borgiaflutterapp/admin/models/delete_product_model.dart';
import 'package:borgiaflutterapp/models/response_model.dart';
import 'package:get/get.dart';

class DeleteProductController extends GetxController implements GetxService {
  final DeleteProductRepo deleteProductRepo;

  DeleteProductController({required this.deleteProductRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> deleteProduct(DeleteProductModel deleteProductModel) async {
    _isLoading = true;

    update();

    Response response = await deleteProductRepo.deleteProduct(deleteProductModel);
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
