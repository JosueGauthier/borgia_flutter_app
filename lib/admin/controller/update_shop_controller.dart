import 'package:borgiaflutterapp/admin/data/update_shop_repo.dart';
import 'package:borgiaflutterapp/admin/models/update_shop_model.dart';
import 'package:borgiaflutterapp/models/response_model.dart';
import 'package:get/get.dart';

class UpdateShopController extends GetxController implements GetxService {
  final UpdateShopRepo updateShopRepo;

  UpdateShopController({required this.updateShopRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> updateShop(UpdateShopModel updateShopModel) async {
    _isLoading = true;

    update();

    Response response = await updateShopRepo.updateShop(updateShopModel);
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
